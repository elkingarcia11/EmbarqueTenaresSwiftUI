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
    
    @State private var selectedLocation: Int = 0
    
    
    let ny : LocalizedStringKey = "ny"
    let dr : LocalizedStringKey = "dr"
    
    init() {
        
        //and this changes the color for the whole "bar" background
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.lightAccent)
        //this changes the "thumb" that selects between items
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accent)

        //this will change the font size
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)

        //these lines change the text color for various states
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.black], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        VStack{
            
            Spacer()
            Picker("Locations", selection: $selectedLocation) {
                Text(ny).tag(0)
                Text(dr).tag(1)
            }
            
            Spacer()
            
            if selectedLocation == 0 {
                NewYorkLocationView()
                    .frame(height: screenHeight*0.6)
            } else {
                DominicanRepublicLocationView()
                    .frame(height: screenHeight*0.6)
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
