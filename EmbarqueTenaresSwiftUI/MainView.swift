//
//  ContentView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

struct MainView: View {
    
    @State var selectedTab = 0
    
    @State var title = "Embarque Tenares"
    
    let track : LocalizedStringKey = "track"
    let rates : LocalizedStringKey = "rates"
    let faqs : LocalizedStringKey = "faqs"
    let locations : LocalizedStringKey = "locations"
    
    init() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        UIToolbar.appearance().barTintColor = .yellow
        UIToolbar.appearance().backgroundColor = .green
        
    }

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                TrackView()
                    .tabItem {
                        Label(track, systemImage: "magnifyingglass.circle.fill")
                    }
                    .tag(0)
                
                RatesView()
                    .tabItem {
                        Label(rates, systemImage: "dollarsign.circle")
                    }.tag(1)
                
                LocationsView()
                    .tabItem {
                        Label(locations, systemImage: "building.2.crop.circle")
                    }.tag(3)
                
                FAQsView()
                    .tabItem {
                        Label(faqs, systemImage: "questionmark.circle")
                    }.tag(2)
            }
            .navigationBarTitle(title, displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        print("Edit button pressed...")
                    }) {
                        Image(systemName: "globe.americas.fill").imageScale(.large)
                    }
            )
            .accentColor(.accent)
            .padding(.bottom, 9.0)
        }
    }
}
