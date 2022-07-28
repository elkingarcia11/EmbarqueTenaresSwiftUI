import Foundation
import SwiftUI
import MapKit

// URLS FROM DB

extension LocalizedStringKey.StringInterpolation{
    mutating func appendInterpolation(value: LocalizedStringKey){
        self.appendInterpolation(Text(value))
    }
    
}
struct DominicanRepublicLocationView: View {
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
    let closedDaily : LocalizedStringKey = "closedDaily"
    
    let drAddress : LocalizedStringKey = "drAddress"

    
    var body: some View {
        VStack{
            
            
            Image(systemName: "building.2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical)
                .frame(width: 75, height: 75)
                .foregroundColor(.dark)
            
            VStack{
                Text(address)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 20.0)
                
                Link(drAddress, destination: URL(string:"https://goo.gl/maps/k1N2CKedA8Awaa9MA")!)
                    .padding(.top, 2.0)
                    .foregroundColor(.accent)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.leading)
            }
            .padding([.leading, .bottom, .trailing])
            
            // Hours
            VStack{
                Text(hours)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 2.0)
                
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
                        Text(closed)
                            .fontWeight( weekday == 1 ?.bold : .regular)
                    }
                }
                .frame(maxWidth: .infinity)
                
                Text(closedDaily)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2.0)
            }
            .padding([.leading, .bottom, .trailing])
            
            // Phone
            VStack{
                Text(phone)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 2.0)
                
                Link ("(809) 970-0007", destination: URL (string: "tel:8099700007")!)
                    .frame(maxWidth: .infinity)
                
            }
            .padding([.leading, .bottom, .trailing])
            .frame(maxWidth: .infinity)
            
            // Email
            VStack{
                Text(email)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 2.0)
                
                Link ("rd@embarquetenares.com", destination: URL (string: "mailto:rd@embarquetenares.com")!)
                    .frame(maxWidth: .infinity)
                
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
