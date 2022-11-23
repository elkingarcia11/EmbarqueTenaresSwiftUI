import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      return true
  }
}

@main
struct EmbarqueTenaresSwiftUIApp: App {
    
    init() {
        FirebaseApp.configure()
        
        Auth.auth().createUser(withEmail: ConfigValues.get().FBUS, password: ConfigValues.get().FBPS) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
            }
        }
    }
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
       WindowGroup {
           SplashScreenView()
       }
   }
}
