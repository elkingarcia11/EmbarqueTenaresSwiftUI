//
//  EmbarqueTenaresSwiftUIApp.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct EmbarqueTenaresSwiftUIApp: App {
    
    init() {
        FirebaseApp.configure()
        Auth.auth().signIn(withEmail: "elkingarcia.11@gmail.com", password: "Ee041195!") { result, err in
            if let err = err {
                print(err.localizedDescription)
            } else {
                print("LOGIN SUCCESSFUL")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
