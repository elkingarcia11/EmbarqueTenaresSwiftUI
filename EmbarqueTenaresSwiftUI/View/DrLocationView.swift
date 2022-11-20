import Foundation
import SwiftUI
// places: "comgooglemaps://?q=Tenares+Shipping+Corp.+Puerto+Plata,+RD&center=19.794385316539273,-70.71694280130453&views=satellite,traffic&zoom=15"
// directions: "comgooglemaps://?saddr=&daddr=Tenares+Shipping+Corp.+Puerto+Plata,+RD+57000"
// places: 
// directions:

struct DrLocationView: View {
    @Environment(\.openURL) private var openURL
    @State var isCollapsed : Bool = false
    
    var locationViewModel = LocationViewModel()
    
    let dr : LocalizedStringKey = "dr"
    let drAddress : LocalizedStringKey = "drAddress"
    let directions : LocalizedStringKey = "directions"
    let call : LocalizedStringKey = "call"
    let email : LocalizedStringKey = "email"
    let website : LocalizedStringKey = "website"
    let more : LocalizedStringKey = "more"
    let hours : LocalizedStringKey = "hours"
    let open : LocalizedStringKey = "open"
    let closed : LocalizedStringKey = "closed"
    let closedForLunch : LocalizedStringKey = "closedForLunch"
    
    func openLocation(){
        if let googleUrl = URL(string:"comgooglemaps://?q=Tenares+Shipping+Corp.+Puerto+Plata,+RD&center=19.794385316539273,-70.71694280130453&views=satellite,traffic&zoom=15") {
            openURL(googleUrl) { accepted in
                if(!accepted) {
                    if let googleUrl = URL(string: "https://goo.gl/maps/k1N2CKedA8Awaa9MA") {
                        openURL(googleUrl)
                    }
                }
            }
        }
    }
    
    func openDirections() {
        if let googleUrl = URL(string: "comgooglemaps://?saddr=&daddr=Tenares+Shipping+Corp.+Puerto+Plata,+RD+57000") {
            openURL(googleUrl) { accepted in
                if(!accepted) {
                    if let googleUrl = URL(string: "https://goo.gl/maps/k1N2CKedA8Awaa9MA") {
                        openURL(googleUrl)
                    }
                }
            }
        }
    }
    
    
    func openWebsite(){
        if let url = URL(string: "https://embarquetenares.com") {
            openURL(url)
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            Text(dr)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 3.0)
                .frame(width: screenWidth)
            
            Button(action: openLocation) {
                Text(drAddress)
                    .fontWeight(.semibold)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
            }
            .buttonStyle(.borderless)
            .foregroundColor(Color.primary)
            
            HStack(alignment: .center){
                Button(action: openDirections) {
                    VStack(alignment: .center){
                        Image(systemName: "arrow.triangle.turn.up.right.circle.fill")
                            .padding(.bottom, -2.0)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(directions)
                            .fontWeight(.semibold)
                            .font(.footnote)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(Color.primary)
                
                Link(destination: URL(string: "tel:8099700007")!) {
                    VStack(alignment: .center){
                        Image(systemName: "phone.fill")
                            .padding(.bottom, -2.0)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(call)
                            .fontWeight(.semibold)
                            .font(.footnote)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(Color.primary)
                
                Link(destination: URL(string: "mailto:rd@embarquetenares.com")!) {
                    VStack(alignment: .center){
                        Image(systemName: "envelope.fill")
                            .padding(.bottom, -2.0)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(email)
                            .fontWeight(.semibold)
                            .font(.footnote)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(Color.primary)
                
                Menu {
                    Button(action: openWebsite){
                        Label(website, systemImage: "safari")
                    }
                    AddContactView(location: 1)
                } label: {
                    VStack(alignment: .center){
                        Image(systemName: "ellipsis.circle.fill")
                            .padding(.bottom, -2.0)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(more)
                            .fontWeight(.semibold)
                            .font(.footnote)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(Color.primary)
            }
            .padding()
            
            Button(action: {isCollapsed.toggle()}){
                VStack(spacing: 0){
                    HStack(alignment: .center){
                        VStack(alignment: .leading, spacing: 0){
                            Text(hours)
                                .foregroundColor(Color(UIColor.systemGray))
                            if(!isCollapsed){
                                Text(LocalizedStringKey(locationViewModel.drFirstSlotHours))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            if(locationViewModel.isDrClosedForLunch){
                                Text(closedForLunch)
                                    .foregroundColor(Color(UIColor.systemRed))
                            } else {
                                Text(locationViewModel.isDrClosed ? closed : open)
                                    .foregroundColor(locationViewModel.isDrClosed ? Color(UIColor.systemRed) : Color(UIColor.systemGreen))
                            }
                        }
                        Spacer()
                        Image(systemName: isCollapsed ? "chevron.up" : "chevron.down")
                            .font(.headline)
                            .foregroundColor(Color(UIColor.systemGray))
                    }
                    
                    if(isCollapsed){
                        // Hours - after collapsed
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 0){
                                Text(LocalizedStringKey(locationViewModel.drFirstSlot))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                Text(LocalizedStringKey(locationViewModel.drSecondSlot))
                                    .foregroundColor(.black)
                                Text(LocalizedStringKey(locationViewModel.drThirdSlot))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 0){
                                Text(LocalizedStringKey(locationViewModel.drFirstSlotHours))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                Text(LocalizedStringKey(locationViewModel.drSecondSlotHours))
                                    .foregroundColor(.black)
                                Text(LocalizedStringKey(locationViewModel.drThirdSlotHours))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top)
                    }
                }
                .padding()
            }
            .frame(width: screenWidth*0.93)
            .padding(.bottom)
            .buttonStyle(.borderedProminent)
            .tint(.white)
        }
        .padding(.vertical)
    }
}
