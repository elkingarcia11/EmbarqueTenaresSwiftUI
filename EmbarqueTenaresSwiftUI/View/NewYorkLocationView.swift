import Foundation
import SwiftUI
import MapKit

struct NewYorkLocationView: View {
    
    var locationViewModel = LocationViewModel()
    
    let address : LocalizedStringKey = "address"
    let hours : LocalizedStringKey = "hours"
    let phone : LocalizedStringKey = "phone"
    let email : LocalizedStringKey = "email"
    let ny : LocalizedStringKey = "ny"
    let call : LocalizedStringKey = "call"
    let directions : LocalizedStringKey = "directions"
    let website : LocalizedStringKey = "website"
    let open : LocalizedStringKey = "open"
    let closed : LocalizedStringKey = "closed"
    
    @State var isCollapsed : Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            Text(ny)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: screenWidth)
            Link(destination: URL(string:"https://goo.gl/maps/RUVQUFbiPr6J113z5")!) {
                Text("2249 Washington Ave Bronx, NY 10457")
                    .fontWeight(.semibold)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .frame(width: screenWidth)
            }
            .padding(.bottom)
            
            HStack(alignment: .center){
                Link(destination: URL(string:"https://goo.gl/maps/RUVQUFbiPr6J113z5")!) {
                    VStack(alignment: .center){
                        Image(systemName: "arrow.triangle.turn.up.right.circle.fill")
                            .padding(.vertical, 0.5)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(directions)
                            .fontWeight(.semibold)
                            .font(.footnote)
                    }
                    .padding(.vertical)
                    .foregroundColor(.primary)
                    .background(.white)
                    .cornerRadius(10)
                    .frame(width: screenWidth*0.22)
                }
                Link(destination: URL(string: "tel:7185621300")!) {
                    VStack(alignment: .center){
                        Image(systemName: "phone.fill")
                            .padding(.vertical, 0.5)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(call)
                            .fontWeight(.semibold)
                            .font(.footnote)
                    }
                    .padding(.vertical)
                    .foregroundColor(.primary)
                    .background(.white)
                    .cornerRadius(10)
                    .frame(width: screenWidth*0.22)
                }
                Link(destination: URL(string: "mailto:ny@embarquetenares.com")!) {
                    VStack(alignment: .center){
                        Image(systemName: "envelope.fill")
                            .padding(.vertical, 0.5)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(email)
                            .fontWeight(.semibold)
                            .font(.footnote)
                    }
                    .padding(.vertical)
                    .foregroundColor(.primary)
                    .background(.white)
                    .cornerRadius(10)
                    .frame(width: screenWidth*0.22)
                }
                Link(destination: URL(string:"https://embarquetenares.com")!) {
                    VStack(alignment: .center){
                        Image(systemName: "safari.fill")
                            .padding(.vertical, 0.5)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(website)
                            .fontWeight(.semibold)
                            .font(.footnote)
                    }
                    .padding(.vertical)
                    .foregroundColor(.primary)
                    .background(.white)
                    .cornerRadius(10)
                    .frame(width: screenWidth*0.22)
                }
            }
            .padding(.vertical)
            .frame(width: screenWidth)
            
            VStack(alignment: .center, spacing: 0){
                Button(action: {isCollapsed.toggle()}){
                    HStack(alignment: .center){
                        VStack(alignment: .leading, spacing: 0){
                            Text("Hours")
                                .foregroundColor(Color(UIColor.systemGray))
                            if(!isCollapsed){
                                Text(LocalizedStringKey(locationViewModel.nyFirstSlotHours))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            Text(LocalizedStringKey(locationViewModel.isNyClosed ? "closed" : "open"))
                                .foregroundColor(locationViewModel.isNyClosed ? Color(UIColor.systemRed) : Color(UIColor.systemGreen))
                        }
                        .padding()
                        Spacer()
                        Image(systemName: isCollapsed ? "chevron.up" : "chevron.down")
                            .padding(.trailing)
                            .font(.headline)
                            .foregroundColor(Color(UIColor.systemGray))
                    }
                }
                if(isCollapsed){
                    // Hours - after collapsed
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 0){
                            Text(LocalizedStringKey(locationViewModel.nyFirstSlot))
                                .fontWeight(.semibold)
                            Text(LocalizedStringKey(locationViewModel.nySecondSlot))
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 0){
                            Text(LocalizedStringKey(locationViewModel.nyFirstSlotHours))
                                .fontWeight(.semibold)
                            Text(LocalizedStringKey(locationViewModel.nySecondSlotHours))
                        }
                        .padding(.trailing)
                    }
                    .padding(.bottom)
                }
            }
            .frame(width: screenWidth*0.93)
            .background(.white)
            .cornerRadius(5)
        }
        .padding(.vertical)
    }
    
}
