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
    
    init() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        UIToolbar.appearance().barTintColor = .yellow
        UIToolbar.appearance().backgroundColor = .green

    }
    
    func updateTab(item: Int) {
        if item == 0 {
            title = "Track"
            selectedTab = 0
        } else if item == 1 {
            title = "Rates"
            selectedTab = 1
        } else if item == 2 {
            title = "FAQs"
            selectedTab = 2
        } else if item == 3 {
            title = "Locations"
            selectedTab = 3
        }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                TrackView()
                    .tabItem {
                        Label("Track", systemImage: "magnifyingglass.circle.fill")
                    }
                    .tag(0)
                
                RatesView(title: "Rates")
                    .tabItem {
                        Label("Rates", systemImage: "dollarsign.circle")
                    }.tag(1)
                
                FAQsView()
                    .tabItem {
                        Label("FAQs", systemImage: "questionmark.circle")
                    }.tag(2)
                
                LocationsView()
                    .tabItem {
                        Label("Locations", systemImage: "building.2.crop.circle")
                    }.tag(3)
            }
            .onChange(of: selectedTab) { newValue in
                updateTab(item: newValue)
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
