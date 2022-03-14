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

struct DominicanRepublicLocationView: View {
    let weekday = Calendar.current.component(.weekday, from: Date())
    
    var body: some View {
        VStack{
            
            HStack(alignment: .top){
                Text("Address:")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)

                    Link("San Marcos #10, Puerto Plata, RD 57000", destination: URL(string:"https://goo.gl/maps/k1N2CKedA8Awaa9MA")!)
                        .foregroundColor(.accent)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
            }
            .padding(.bottom)
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
                        Text("8AM-5PM")
                            .fontWeight( weekday == 2 ?.bold : .regular)
                        Text("8AM-6PM")
                            .fontWeight( weekday == 3 ?.bold : .regular)
                        Text("8AM-5PM")
                            .fontWeight( weekday == 4 ?.bold : .regular)
                        Text("8AM-5PM")
                            .fontWeight( weekday == 5 ?.bold : .regular)
                        Text("8AM-5PM")
                            .fontWeight( weekday == 6 ?.bold : .regular)
                        Text("8AM-5PM")
                            .fontWeight( weekday == 7 ?.bold : .regular)
                        Text("Closed")
                            .fontWeight( weekday == 1 ?.bold : .regular)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 2.0)
            
            Text("Closed daily for lunch 12PM-2PM")
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding([.leading, .bottom, .trailing])
                .frame(maxWidth: .infinity)
            
            // Phone
            HStack(alignment: .top){
                
                Text("Phone:")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                
                Link ("(809) 970-0007", destination: URL (string: "tel:8099700007")!)
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
                
                Link ("rd@embarquetenares.com", destination: URL (string: "mailto:rd@embarquetenares.com")!)
                    .frame(maxWidth: .infinity)
                
            }
            .frame(maxWidth: .infinity)
            
        }.padding(.vertical)
            .frame(width: screenWidth-10, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.accent, lineWidth: 1.5)
            )
    }
}
