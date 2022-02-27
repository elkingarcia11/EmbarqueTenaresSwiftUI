//
//  ContentView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView {
            TrackView()
                .tabItem {
                    Label("Track", systemImage: "magnifyingglass.circle.fill")
                }
            
            RatesView()
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
        .accentColor(.accent)
        .padding(.bottom, 9.0)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
