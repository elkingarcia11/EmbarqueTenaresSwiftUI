//
//  ContentView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import SwiftUI
import UIKit
import NaturalLanguage
import CoreML

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var selectedTab = 1
    @State var resetTrack : Bool = false
    
    @State var title : LocalizedStringKey = ""
    @State(initialValue: "es") var lang: String
    
    let fonts = Fonts()
    
    let company : LocalizedStringKey = "company"
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
                    TrackView(title: $title, lang: $lang, shouldReset: $resetTrack)
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
                            VStack{
                                Image(systemName: "building.2.crop.circle").imageScale(.small)
                                    .foregroundColor(Color.black)
                                Text(locations)
                                    .font(.largeTitle)
                            }
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
                                title = "company"
                            }
                    }
                }
                .onChange(of: selectedTab){ newState in
                    UITabBar.appearance().backgroundColor = UIColor(Color.light)
                    resetTrack = true //<< when pressing Tab Bar Reset Navigation View
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
                .accentColor(.accent)
            }
        }
        .environment(\.locale, Locale(identifier: self.lang))
    }
}
