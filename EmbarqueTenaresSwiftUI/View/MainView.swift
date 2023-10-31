import SwiftUI
import UIKit
import NaturalLanguage
import CoreML

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

struct MainView: View {
    @State private var selectedTab = 1
    @State var resetTrack : Bool = false
    
    @State var title : LocalizedStringKey = ""
    @State(initialValue: "es") var lang: String
    
    let fonts = Fonts()
    
    let track : LocalizedStringKey = "track"
    let rates : LocalizedStringKey = "rates"
    let faqs : LocalizedStringKey = "faqs"
    let locations : LocalizedStringKey = "locations"
    
    @StateObject var httpHeader = HttpHeader()
    
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
                        .environmentObject(httpHeader)
                    
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
                    leading: Text("V 4.1")
                        .font(.subheadline)
                        .foregroundColor(Color.gray),
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
        .task{
            do {
                try await httpHeader.getHttpHeaders() 
            }
            catch {
                print("Error retrieving http headers")
            }
        }
        .environment(\.locale, Locale(identifier: self.lang))
    }
}
