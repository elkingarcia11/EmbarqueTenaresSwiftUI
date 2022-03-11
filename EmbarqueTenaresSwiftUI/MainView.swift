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
    
    var track : String = "Track"
    
    var rates : String = "Rates"
    
    var body: some View {
        NavigationView {
            TabView {
                TrackView()
                    .tabItem {
                        Label("Track", systemImage: "magnifyingglass.circle.fill")
                    }
                
                RatesView(title: rates)
                    .tabItem {
                        Label("Rates", systemImage: "dollarsign.circle")
                    }
                
                FAQsView()
                    .tabItem {
                        Label("FAQs", systemImage: "questionmark.circle")
                    }
                
                LocationsView()
                    .tabItem {
                        Label("Locations", systemImage: "building.2.crop.circle")
                    }
            }
            .navigationBarTitle("Embarque Tenares", displayMode: .inline)
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
