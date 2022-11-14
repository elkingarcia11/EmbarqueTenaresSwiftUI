import Foundation
import SwiftUI

struct DrLocationView: View {
    var locationViewModel = LocationViewModel()
    let dr : LocalizedStringKey = "dr"
    let drAdrress : LocalizedStringKey = "drAddress"
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
    let closedForLunch : LocalizedStringKey = "closedForLunch"
    
    @State var isCollapsed : Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            Text(dr)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(width: screenWidth)
            Link(destination: URL(string:"https://goo.gl/maps/k1N2CKedA8Awaa9MA")!) {
                Text(drAdrress)
                    .fontWeight(.semibold)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .frame(width: screenWidth)
            }
            .padding(.bottom)
            
            HStack(alignment: .center){
                Link(destination: URL(string:"https://goo.gl/maps/k1N2CKedA8Awaa9MA")!) {
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
                Link(destination: URL(string: "tel:8099700007")!) {
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
                Link(destination: URL(string: "mailto:rd@embarquetenares.com")!) {
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
                                Text(LocalizedStringKey(locationViewModel.drFirstSlotHours))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            if(locationViewModel.isDrClosedForLunch){
                                Text(LocalizedStringKey("closedForLunch"))
                                    .foregroundColor(Color(UIColor.systemRed))
                            } else {
                                Text(LocalizedStringKey(locationViewModel.isDrClosed ? "closed" : "open"))
                                    .foregroundColor(locationViewModel.isDrClosed ? Color(UIColor.systemRed) : Color(UIColor.systemGreen))
                            }
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
                            Text(LocalizedStringKey(locationViewModel.drFirstSlot))
                                .fontWeight(.semibold)
                            Text(LocalizedStringKey(locationViewModel.drSecondSlot))
                            Text(LocalizedStringKey(locationViewModel.drThirdSlot))
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 0){
                            Text(LocalizedStringKey(locationViewModel.drFirstSlotHours))
                                .fontWeight(.semibold)
                            Text(LocalizedStringKey(locationViewModel.drSecondSlotHours))
                            Text(LocalizedStringKey(locationViewModel.drThirdSlotHours))
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
