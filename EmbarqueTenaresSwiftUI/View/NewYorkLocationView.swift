import Foundation
import SwiftUI
import Contacts

struct NewYorkLocationView: View {
    @Environment(\.openURL) private var openURL
    @State var isCollapsed : Bool = false
    @State private var showAlert = false
    
    var locationViewModel = LocationViewModel()
    
    let ny : LocalizedStringKey = "ny"
    let directions : LocalizedStringKey = "directions"
    let call : LocalizedStringKey = "call"
    let email : LocalizedStringKey = "email"
    let website : LocalizedStringKey = "website"
    let more : LocalizedStringKey = "more"
    let hours : LocalizedStringKey = "hours"
    let open : LocalizedStringKey = "open"
    let closed : LocalizedStringKey = "closed"
    
    let contact : LocalizedStringKey = "contact"
    let contactSaved : LocalizedStringKey = "contactSaved"
    let contactAdded : LocalizedStringKey = "contactAdded"
    
    func openLocation(){
        if let googleUrl = URL(string: "comgooglemaps://?q=Embarque+Tenares+Corp.+Bronx,+NY&center=40.85455068009679,-73.89396676221173&views=satellite,traffic&zoom=15") {
            openURL(googleUrl) { accepted in
                if(!accepted) {
                    if let appleUrl = URL(string: "maps://?q=Embarque+Tenares+2249+Washington+Ave+Bronx,+NY+10457") {
                        openURL(appleUrl) { succeeded in
                            if(!succeeded){
                                if let googleUrl = URL(string: "https://goo.gl/maps/RUVQUFbiPr6J113z5") {
                                    openURL(googleUrl)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func openDirections() {
        if let googleUrl = URL(string: "comgooglemaps://?saddr=&daddr=Embarque+Tenares+Bronx,+NY+10457") {
            openURL(googleUrl) { accepted in
                if(!accepted) {
                    if let appleUrl = URL(string: "maps://?saddr=&daddr=Embarque+Tenares+2249+Washington+Ave+Bronx,+NY+10457") {
                        openURL(appleUrl) { succeeded in
                            if(!succeeded){
                                if let googleUrl = URL(string: "https://goo.gl/maps/RUVQUFbiPr6J113z5") {
                                    openURL(googleUrl)
                                }
                            }
                        }
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
    
    func addToContact(){
        let contact = CNMutableContact();
        contact.givenName = "Embarque Tenares"
        contact.familyName = "NY"
        contact.emailAddresses = [CNLabeledValue(label: CNLabelOther, value: "ny@embarquetenares.com")];
        contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: "7185621300"))];
        contact.urlAddresses = [CNLabeledValue(label: CNLabelURLAddressHomePage, value: "embarquetenares.com")];
        
        let address = CNMutablePostalAddress()
        address.street = "2249 Washington Ave"
        address.city = "Bronx"
        address.state = "NY"
        address.postalCode = "10457"
        address.country = "US"
        
        contact.postalAddresses = [CNLabeledValue<CNPostalAddress>(label: CNLabelHome, value: address)]
        
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        do {
            try store.execute(saveRequest)
            self.showAlert.toggle()
            
        } catch {
            print("Error occur: \(error)")
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            Text(ny)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 3.0)
                .frame(width: screenWidth)
            
            Button(action: openLocation) {
                Text("2249 Washington Ave Bronx, NY 10457")
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
                            .font(.caption2)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(Color.primary)
                
                Link(destination: URL(string: "tel:7185621300")!){
                    VStack(alignment: .center){
                        Image(systemName: "phone.fill")
                            .padding(.bottom, -2.0)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(call)
                            .fontWeight(.semibold)
                            .font(.caption2)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(Color.primary)
                
                Link(destination: URL(string: "mailto:ny@embarquetenares.com")!){
                    VStack(alignment: .center){
                        Image(systemName: "envelope.fill")
                            .padding(.bottom, -2.0)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(email)
                            .fontWeight(.semibold)
                            .font(.caption2)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(Color.primary)
                
                Menu {
                    Button(action: openWebsite){
                        Label(website, systemImage: "safari")
                    }
                    Button(action: addToContact){
                        Label(contact, systemImage: "person.crop.circle.badge.plus")
                    }
                } label: {
                    VStack(alignment: .center){
                        Image(systemName: "ellipsis.circle.fill")
                            .padding(.bottom, -2.0)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        Text(more)
                            .fontWeight(.semibold)
                            .font(.caption2)
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
                                Text(LocalizedStringKey(locationViewModel.nyFirstSlotHours))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            Text(locationViewModel.isNyClosed ? closed : open)
                                .foregroundColor(locationViewModel.isNyClosed ? Color(UIColor.systemRed) : Color(UIColor.systemGreen))
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
                                Text(LocalizedStringKey(locationViewModel.nyFirstSlot))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                Text(LocalizedStringKey(locationViewModel.nySecondSlot))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 0){
                                Text(LocalizedStringKey(locationViewModel.nyFirstSlotHours))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                Text(LocalizedStringKey(locationViewModel.nySecondSlotHours))
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(contactSaved),
                message: Text(contactAdded)
            )
        }
    }
}
