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
    @State var userID : FirebaseAuth.User?
    
    init() {
        var uID : FirebaseAuth.User?
        FirebaseApp.configure()
        Auth.auth().signInAnonymously { authResult, error in
            if let err = error {
                print(err.localizedDescription)
            }
            uID = authResult?.user
        }
        userID = uID
        
    }
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
       WindowGroup {
           SplashScreenView()
       }
   }
}
