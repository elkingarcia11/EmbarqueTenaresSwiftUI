import SwiftUI
import UIKit
import NaturalLanguage
import CoreML
import Firebase

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

class HttpHeader : ObservableObject {
    @Published var token : String?
    @Published var apiKey : String = ""
    @Published var appId : String = ""
    @Published var httpHeaderChanged : Bool = false
    
    func getHttpHeaders(){
        Firestore.firestore().collection("auth").document("login").addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                self.apiKey = ""
                self.appId = ""
                return
            }
            
            guard let data = document.data() else {
                self.apiKey = ""
                self.appId = ""
                return
            }
            
            self.apiKey = data["Api-Key"] as! String
            self.appId = data["App-Id"] as! String
            self.httpHeaderChanged.toggle()
            print("Change in http header info")
        }
    }
    
    @MainActor
    func getToken() async throws {
        guard let url = URL(string: "https://api.embarquero.com/api/tenares/auth/login")
        else {
            return
        }
        var urlRequest = URLRequest(url: url)
        // Create object to store log in response which will be ->
        // APIResponse is status, action, message, response object
        // LogInResponse is a response object with a token object and user object
        // Token object contains access and refresh fields
        // user object contains id fullname username active and role
        var result : APIResponse<LogInResponse>
        let objectType = APIResponse<LogInResponse>.self
        
        // Set up headers for login request
        urlRequest.httpMethod = "POST"
        print("App id, api key", self.appId, self.apiKey)
        urlRequest.setValue(self.appId, forHTTPHeaderField: "App-Id")
        urlRequest.setValue(self.apiKey, forHTTPHeaderField: "Api-Key")
        
        // Set up body for login request
        let body: [String: Any] = ["Username" : "elkin", "Type" : "MOBILE"]
        // Serialize body into json
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        urlRequest.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let statuscode = (response as? HTTPURLResponse)?.statusCode else { return }
        
        if(200...299).contains(statuscode){
            result = try JSONDecoder().decode(objectType, from: data)
            let logInResponse = result.response[0]
            self.token = logInResponse.token.access
        } else {
            return
        }
    }
}

struct MainView: View {
    @State private var selectedTab = 1
    @State var resetTrack : Bool = false
    
    @State var title : LocalizedStringKey = ""
    @State(initialValue: "es") var lang: String
    
    @StateObject var httpHeader = HttpHeader()
    
    let fonts = Fonts()
    
    let track : LocalizedStringKey = "track"
    let rates : LocalizedStringKey = "rates"
    let faqs : LocalizedStringKey = "faqs"
    let locations : LocalizedStringKey = "locations"
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(Color.light)
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UITabBar.appearance().backgroundColor = UIColor(Color.light)
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.light.ignoresSafeArea()
                TabView(selection: $selectedTab)
                {
                    TrackView(title: $title, lang: $lang, resetScreen: $resetTrack)
                        .tabItem {
                            Label(track, systemImage: "magnifyingglass.circle.fill")
                        }
                        .tag(1)
                    
                    RatesView(lang: $lang)
                        .tabItem {
                            Label(rates, systemImage: "dollarsign.circle")
                        }
                        .tag(2)
                    
                    LocationsView()
                        .tabItem {
                            Label(locations, systemImage: "building.2.crop.circle")
                        }
                        .tag(3)
                    
                    FAQsView(lang: $lang)
                        .tabItem {
                            Label(faqs, systemImage: "questionmark.circle")
                        }
                        .tag(4)
                }
                .padding(.top)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text(title)
                            .font(Font.custom(fonts.one, size: 26))
                            .fontWeight(.regular)
                            .onTapGesture {
                                self.resetTrack.toggle()
                                selectedTab = 1
                                title = ""
                            }
                    }
                }
                .onChange(of: selectedTab){ newState in
                    UITabBar.appearance().backgroundColor = UIColor(Color.light)
                    self.resetTrack.toggle() //<< when pressing Tab Bar Reset Navigation View
                    if newState == 1 {
                        title = ""
                    } else if newState == 2 {
                        title = "rates"
                    } else if newState == 3 {
                        title = "locations"
                    } else {
                        title = "faqs"
                    }
                }
                .navigationBarItems(
                    trailing:
                        Menu {
                            Button("English", action: {self.lang = "en"})
                            Button("Español", action: {self.lang = "es"})
                        } label: {
                            HStack(alignment: .center){
                                Image(systemName: "globe.americas.fill").imageScale(.small)
                                Text(self.lang == "en" ? "English" : "Español")
                                    .font(.callout)
                                Image(systemName: "chevron.down").imageScale(.small)
                            }
                        }
                )
                .accentColor(.primary)
            }
        }
        .onAppear{
            httpHeader.getHttpHeaders()
        }
        .onChange(of: httpHeader.httpHeaderChanged) { newValue in
            Task{
                try await httpHeader.getToken()
            }
            
        }
        .environment(\.locale, Locale(identifier: self.lang))
        .environmentObject(httpHeader)
    }
}
