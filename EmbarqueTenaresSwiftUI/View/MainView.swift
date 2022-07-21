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
    
    @State var selectedTab: Int = 0
    @State var resetTrack : Bool = false
    
    @State var title = "Embarque Tenares"
    @State(initialValue: "es") var lang: String
    
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
        
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.light.ignoresSafeArea()
                TabView(selection: Binding<Int>(
                    get: {
                        selectedTab
                    }, set: {
                        selectedTab = $0
                        resetTrack = true //<< when pressing Tab Bar Reset Navigation View
                    }))
                {
                    TrackView(lang: $lang, shouldReset: $resetTrack)
                        .tabItem {
                            Label(track, systemImage: "magnifyingglass.circle.fill")
                        }
                        .tag(0)
                    
                    RatesView(lang: $lang)
                        .tabItem {
                            Label(rates, systemImage: "dollarsign.circle")
                        }
                        .tag(1)
                    
                    LocationsView()
                        .tabItem {
                            Label(locations, systemImage: "building.2.crop.circle")
                        }.tag(3)
                    
                    FAQsView(lang: $lang)
                        .tabItem {
                            Label(faqs, systemImage: "questionmark.circle")
                        }.tag(2)
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
                .navigationBarTitleDisplayMode(.inline)
                .accentColor(.accent)
            }
        }
        .environment(\.locale, Locale(identifier: self.lang))
    }
}
