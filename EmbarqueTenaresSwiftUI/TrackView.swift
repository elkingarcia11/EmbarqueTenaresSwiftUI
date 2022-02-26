//
//  TrackView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import Foundation
import SwiftUI

struct TrackView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let screenSize = UIScreen.main.bounds.size
    @State var text = ""
    
    @State var progressValue: Float = 0.75
    @State var eta: String = ""
    
    @State var showPopUp = false
    /*
     if eta == "ALM-NY"
     
     func updateETAbar : Float (){
     if eta == "ALM-NY" || eta == "DEV-NY" {
     
     } else if eta == "EN TRANSITO" {
     
     } else if eta == "ALM-RD" {
     
     } else if eta == "CONDUCE" {
     
     } else if eta == "ENTREGADO" {
     
     }
     }*/
    //18-30 days
    // alm ny 1-3 days
    // en transito 4-19
    // rd 2-4 days
    // conduce 1-2 days
    // if entregado
    var body: some View {
        VStack(alignment: .center) {
            Text("Track Invoice")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .padding(.top)
            Spacer()
            VStack(alignment: .center){
                Text("123456")
                    .padding()
                    .frame(width: screenWidth/2, height: screenHeight/16)
                    .background(Color.positive)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(15)
                
                VStack{
                    HStack{
                        Divider()
                    }
                    Button("Almacen NY", action: {
                        self.showPopUp = true
                    })
                        .foregroundColor(.white)
                        .padding()
                        .font(.subheadline)
                        .frame(width: screenWidth/2, height: screenHeight/16)
                        .background(Color.primary)
                        .cornerRadius(25)
                    HStack{
                        Divider()
                    }
                    Button("En transito", action: {
                        self.showPopUp = true
                    })
                        .foregroundColor(.white)
                        .padding()
                        .font(.subheadline)
                        .frame(width: screenWidth/2, height: screenHeight/16)
                        .background(Color.gray)
                        .cornerRadius(25)
                    
                    HStack{
                        Divider()
                    }
                    Button("Almacen RD", action: {
                        self.showPopUp = true
                    })
                        .foregroundColor(.white)
                        .padding()
                        .font(.subheadline)
                        .frame(width: screenWidth/2, height: screenHeight/16)
                        .background(Color.gray)
                        .cornerRadius(25)
                    
                    HStack{
                        Divider()
                    }
                    Button("En camino", action: {
                        self.showPopUp = true
                    })
                        .foregroundColor(.white)
                        .padding()
                        .font(.subheadline)
                        .frame(width: screenWidth/2, height: screenHeight/16)
                        .background(Color.gray)
                        .cornerRadius(25)
                    HStack{
                        Divider()
                    }
                    
                    Button("Entregado", action: {
                        self.showPopUp = true
                    })
                        .foregroundColor(.white)
                        .padding()
                        .font(.subheadline)
                        .frame(width: screenWidth/2, height: screenHeight/16)
                        .background(Color.gray)
                        .cornerRadius(25)
                }
            }
            .frame(width: screenWidth)
            .padding(.vertical)
            
            Spacer()
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search for invoice", text: $text)
            }
            .padding()
            .background(Color.light)
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .font(.custom("American Typewriter", size: 24))
            .background(Color.red)
            .border(Color.purple)
            .cornerRadius(8)
    }
}
