//
//  LocationsView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import Foundation
import SwiftUI

// DB URLS

struct LocationsView: View {
    
    @State private var selectedLocation: Int = 1
    
    var body: some View {
        VStack{
            
            Picker("Locations", selection: $selectedLocation) {
                Text("New York").tag(0)
                Text("Dominican Republic").tag(1)
            }
            
            Spacer()
            
            Image(systemName: "building.2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75, alignment: .center)
                .foregroundColor(.dark)
            
            Spacer()
            
            if selectedLocation == 0 {
                NewYorkLocationView()
            } else {
                DominicanRepublicLocationView()
            }
            
            Spacer()
            
            SocialMediaFooter()
            
            Spacer()
            
        }.pickerStyle(.segmented)
    }
}

struct SocialMediaFooter : View {
    
    @Environment(\.openURL) var openURL
    
    func openLink(index : Int){
        
        if index == 0 {
            if let url = URL(string: "https://api.whatsapp.com/send?phone=17185621300") {
                openURL(url)
            }
        } else if index == 1 {
            if let url = URL(string: "fb://profile?id=embarquetenaress") {
                openURL(url) { accepted in
                    let _ = accepted ? () : tryBackUpLink()
                }
            }
        } else if index == 2 {
            if let url = URL(string: "https://instagram.com/embarquetenares") {
                openURL(url)
            }
        }
    }
    
    func tryBackUpLink(){
        if let url = URL(string: "https://www.facebook.com/EmbarqueTenaress/") {
            openURL(url)
        }
    }
    
    var body: some View {
        HStack(alignment: .center){
            
            Spacer()
            Button(action: {openLink(index: 0)}){
                Image("whatsapp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)}
            Spacer()
            Button(action: {openLink(index: 1)}){
                Image("facebook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)}
            Spacer()
            Button(action: {openLink(index: 2)}){
                Image("instagram")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)}
            
            Spacer()
        }
        .frame(width: screenWidth)
        
    }
}
