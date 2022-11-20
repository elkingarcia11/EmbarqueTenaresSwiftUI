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
        } else {
            contact.familyName = "RD"
            contact.emailAddresses = [CNLabeledValue(label: CNLabelOther, value: "rd@embarquetenares.com")];
            contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: "8099700007")),CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: "8092612373"))];
            contact.urlAddresses = [CNLabeledValue(label: CNLabelURLAddressHomePage, value: "embarquetenares.com")];
        }
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        do {
            try store.execute(saveRequest)
            showAlert.toggle()
            
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
