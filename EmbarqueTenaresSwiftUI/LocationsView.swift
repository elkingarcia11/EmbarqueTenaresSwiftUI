//
//  LocationsView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import Foundation
import SwiftUI

struct LocationsView: View {
    
    var body: some View {
        VStack{
            TabView {
                NewYorkLocationView()
                    .tabItem {
                        Label("New York", systemImage: "building")
                    }
                
                DominicanRepublicLocationView()
                    .tabItem {
                        Label("Dominican Republic", systemImage: "building")
                    }
            }
            .accentColor(.secondary)
        }
        
    }
}
