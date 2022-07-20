//
//  EmbarqueTenaresSwiftUIApp.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      Auth.auth().signIn(withEmail: "elkingarcia.11@gmail.com", password: "Ee041195!") { result, err in
          if let err = err {
              print(err.localizedDescription)
          }
      }
    return true
  }
}

@main
struct EmbarqueTenaresSwiftUIApp: App {
    /*
    init() {
        FirebaseApp.configure()
        Auth.auth().signIn(withEmail: "elkingarcia.11@gmail.com", password: "Ee041195!") { result, err in
            if let err = err {
                print(err.localizedDescription)
            }
        }
    }*/
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.colorScheme, .light)
        }
    }
}
