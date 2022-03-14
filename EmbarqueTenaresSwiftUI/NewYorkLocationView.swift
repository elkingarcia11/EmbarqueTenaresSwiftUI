//
//  RatesView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import Foundation
import SwiftUI
import MapKit

// URLS FROM DB

struct NewYorkLocationView: View {
    let weekday = Calendar.current.component(.weekday, from: Date())
    
    var body: some View {
        VStack{
            
            HStack(alignment: .top){
                Text("Address:")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                
                
                Link("2249 Washington Ave, Bronx, NY 10457", destination: URL(string:"https://goo.gl/maps/RUVQUFbiPr6J113z5")!)
                    .foregroundColor(.accent)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.leading)
            }
            .padding(.bottom, 2.0)
            .frame(maxWidth: .infinity)
            
            // Hours
            HStack(alignment: .top){
                Text("Hours:")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                
                HStack {
                    VStack(alignment: .leading){
                        Text("Monday")
                            .fontWeight( weekday == 2 ?.bold : .regular)
                        Text("Tuesday")
                            .fontWeight( weekday == 3 ?.bold : .regular)
                        Text("Wednesday")
                            .fontWeight( weekday == 4 ?.bold : .regular)
                        Text("Thursday")
                            .fontWeight( weekday == 5 ?.bold : .regular)
                        Text("Friday")
                            .fontWeight( weekday == 6 ?.bold : .regular)
                        Text("Saturday")
                            .fontWeight( weekday == 7 ?.bold : .regular)
                        Text("Sunday")
                            .fontWeight( weekday == 1 ?.bold : .regular)
                    }
                    .padding(.trailing)
                    
                    VStack(alignment: .leading){
                        Text("8AM-6PM")
                            .fontWeight( weekday == 2 ?.bold : .regular)
                        Text("8AM-6PM")
                            .fontWeight( weekday == 3 ?.bold : .regular)
                        Text("8AM-6PM")
                            .fontWeight( weekday == 4 ?.bold : .regular)
                        Text("8AM-6PM")
                            .fontWeight( weekday == 5 ?.bold : .regular)
                        Text("8AM-6PM")
                            .fontWeight( weekday == 6 ?.bold : .regular)
                        Text("8AM-6PM")
                            .fontWeight( weekday == 7 ?.bold : .regular)
                        Text("Closed")
                            .fontWeight( weekday == 1 ?.bold : .regular)
                    }
                    
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
                
            }
            .padding(.bottom)
            
            // Phone
            HStack(alignment: .top){
                
                Text("Phone:")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                
                Link ("(718) 562-1300", destination: URL (string: "tel:7185621300")!)
                    .frame(maxWidth: .infinity)
                
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            
            // Email
            HStack(alignment: .top){
                
                Text("Email:")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                
                Link ("ny@embarquetenares.com", destination: URL (string: "mailto:ny@embarquetenares.com")!)
                    .frame(maxWidth: .infinity)
                
            }
            .frame(maxWidth: .infinity)
            
        }.padding(.vertical)
            .frame(width: screenWidth-10, height: screenHeight/2, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.accent, lineWidth: 1.5)
            )
    }
}
