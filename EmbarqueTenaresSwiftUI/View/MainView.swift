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
    
    @State var title : LocalizedStringKey = "company"
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
        UINavigationBar.appearance().tintColor = UIColor.red
        UITabBar.appearance().backgroundColor = UIColor(Color.light)
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: fonts.one, size: 20)!]
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
                            Label(locations, systemImage: "building.2.crop.circle")
                        }
                        .tag(3)
                    
                    FAQsView(lang: $lang)
                        .tabItem {
                            Label(faqs, systemImage: "questionmark.circle")
                        }
                        .tag(4)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text(title)
                            .font(Font.custom(fonts.one, size: 20))
                            .fontWeight(.semibold)
                            .onTapGesture {
                                resetTrack = true
                                selectedTab = 1
                            }
                    }
                }
                .onChange(of: selectedTab){ newState in
                    resetTrack = true //<< when pressing Tab Bar Reset Navigation View
                    if newState == 1 {
                        title = "company"
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
                            Image(systemName: "globe.americas.fill").imageScale(.large)
                        }
                )
                .accentColor(.accent)
            }
        }
        .environment(\.locale, Locale(identifier: self.lang))
    }
}
