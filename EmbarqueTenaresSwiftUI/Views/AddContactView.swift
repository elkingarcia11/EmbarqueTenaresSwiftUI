//
//  AddContact.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 11/20/22.
//

import Foundation
import SwiftUI
import Contacts

struct AddContactView: View {
    
    @State private var showAlert = false
    
    var location : Int
    
    let contact : LocalizedStringKey = "contact"
    let contactSaved : LocalizedStringKey = "contactSaved"
    let contactAdded : LocalizedStringKey = "contactAdded"
    
    func addToContact(){
        let contact = CNMutableContact();
        contact.givenName = "Embarque Tenares"
        if(location == 0){
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
        } else {
            contact.familyName = "RD"
            contact.emailAddresses = [CNLabeledValue(label: CNLabelOther, value: "rd@embarquetenares.com")];
            contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: "8099700007")),CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: "8092612373"))];
            contact.urlAddresses = [CNLabeledValue(label: CNLabelURLAddressHomePage, value: "embarquetenares.com")];
            
            let address = CNMutablePostalAddress()
                address.street = "San Marcos #10"
                address.city = "Puerto Plata"
                address.state = "DO"
                address.postalCode = "57000"
                address.country = "DO"
            contact.postalAddresses = [CNLabeledValue<CNPostalAddress>(label: CNLabelHome, value: address)]
        }
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        do {
            try store.execute(saveRequest)
            showAlert.toggle()
            print("SHOW ALERT TOGGLED")
            
        } catch {
            print("Error occur: \(error)")
        }
    }
    
    var body: some View {
        Button(action: addToContact){
            Label(contact, systemImage: "person.crop.circle.badge.plus")
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(contactSaved),
                message: Text(contactAdded)
            )
        }
    }
}
