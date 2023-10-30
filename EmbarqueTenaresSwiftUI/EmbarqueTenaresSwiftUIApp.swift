import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct EmbarqueTenaresSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        // Configure Firebase
        FirebaseApp.configure()
        
        // Get the app's bundle identifier from the info.plist file.
        if let auth_u = Bundle.main.infoDictionary?["AUTH_U"] as? String {
            if let auth_p = Bundle.main.infoDictionary?["AUTH_P"] as? String {
                Auth.auth().signIn(withEmail: auth_u, password: auth_p){
                    (result, error) in
                    if error == nil {
                        print("Signed in succesfully")
                    } else {
                        print(error?.localizedDescription ?? "Error signing in")
                    }
                }
            }
        }
        
        let components = DateComponents(year: 2024, month: 1, day: 10, hour: 12, minute: 0)
        // Create a new instance of the Notif class.
        _ = Notif(title: "¡Ofertas disponibles!", body: "¡Aprovecha nuestras ofertas y llámanos hoy!", dateComponent: components)
        
        let components1 = DateComponents(year: 2024, month: 3, day: 20, hour: 12, minute: 0)
        // Create a new instance of the Notif class.
        _ = Notif(title: "¡Ofertas disponibles!", body: "¡Aprovecha nuestras ofertas y llámanos hoy!", dateComponent: components1)
        
        let components2 = DateComponents(year: 2024, month: 5, day: 31, hour: 12, minute: 0)
        // Create a new instance of the Notif class.
        _ = Notif(title: "¡El verano ya casi está aquí!", body: "¡Envíe sus artículos de vacaciones con nosotros!", dateComponent: components2)
        
        let components3 = DateComponents(year: 2023, month: 8, day: 15, hour: 12, minute: 0)
        // Create a new instance of the Notif class.
        _ = Notif(title: "¡Ofertas disponibles!", body: "¡Aprovecha nuestras ofertas y llámanos hoy!", dateComponent: components3)
        
        let components4 = DateComponents(year: 2023, month: 10, day: 27, hour: 12, minute: 0)
        // Create a new instance of the Notif class.
        _ = Notif(title: "¡La Navidad ya casi está aquí!", body:  "¡Llama y programa tu cita antes del 20 de noviembre para recibir tus artículos antes de Navidad!", dateComponent: components4)
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
