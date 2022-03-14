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
    
    let address : LocalizedStringKey = "address"
    let hours : LocalizedStringKey = "hours"
    let phone : LocalizedStringKey = "phone"
    let email : LocalizedStringKey = "email"
    
    let monday : LocalizedStringKey = "monday"
    let tuesday : LocalizedStringKey = "tuesday"
    let wednesday : LocalizedStringKey = "wednesday"
    let thursday : LocalizedStringKey = "thursday"
    let friday : LocalizedStringKey = "friday"
    let saturday : LocalizedStringKey = "saturday"
    let sunday : LocalizedStringKey = "sunday"
    let closed : LocalizedStringKey = "closed"
    
    var body: some View {
        VStack{
            
            HStack(alignment: .top){
                Text(address)
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
                Text(hours)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                
                HStack {
                    VStack(alignment: .leading){
                        Text(monday)
                            .fontWeight( weekday == 2 ?.bold : .regular)
                        Text(tuesday)
                            .fontWeight( weekday == 3 ?.bold : .regular)
                        Text(wednesday)
                            .fontWeight( weekday == 4 ?.bold : .regular)
                        Text(thursday)
                            .fontWeight( weekday == 5 ?.bold : .regular)
                        Text(friday)
                            .fontWeight( weekday == 6 ?.bold : .regular)
                        Text(saturday)
                            .fontWeight( weekday == 7 ?.bold : .regular)
                        Text(sunday)
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
                        Text(closed)
                            .fontWeight( weekday == 1 ?.bold : .regular)
                    }
                    
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
                
            }
            .padding(.bottom)
            
            // Phone
            HStack(alignment: .top){
                
                Text(phone)
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
                
                Text(email)
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
