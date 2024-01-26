import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import UserNotifications


class AppDelegate: NSObject, UIApplicationDelegate {
    
    var config: [String: Any]?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        Auth.auth().signInAnonymously { authResult, error in
            if authResult != nil {
                print("Successfully signed in")
            } else {
                if let error {
                    print("Error signing in \(error)")
                } else {
                    print("Error signing in")
                }
            }
        }
        return true
    }
}

@main
struct EmbarqueTenaresSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        do{
            let components = DateComponents(year: 2024, month: 1, day: 10, hour: 12, minute: 0)
            // Create a new instance of the Notif class.
            _ = try Notif(title: "¡Ofertas disponibles!", body: "¡Aprovecha nuestras ofertas y llámanos hoy!", dateComponent: components)
            
            let components1 = DateComponents(year: 2024, month: 3, day: 20, hour: 12, minute: 0)
            // Create a new instance of the Notif class.
            _ = try Notif(title: "¡Ofertas disponibles!", body: "¡Aprovecha nuestras ofertas y llámanos hoy!", dateComponent: components1)
            
            let components2 = DateComponents(year: 2024, month: 5, day: 31, hour: 12, minute: 0)
            // Create a new instance of the Notif class.
            _ = try Notif(title: "¡El verano ya casi está aquí!", body: "¡Envíe sus artículos de vacaciones con nosotros!", dateComponent: components2)
            
            let components3 = DateComponents(year: 2023, month: 8, day: 15, hour: 12, minute: 0)
            // Create a new instance of the Notif class.
            _ = try Notif(title: "¡Ofertas disponibles!", body: "¡Aprovecha nuestras ofertas y llámanos hoy!", dateComponent: components3)
            
            let components4 = DateComponents(year: 2023, month: 10, day: 27, hour: 12, minute: 0)
            // Create a new instance of the Notif class.
            _ = try Notif(title: "¡La Navidad ya casi está aquí!", body:  "¡Llama y programa tu cita antes del 20 de noviembre para recibir tus artículos antes de Navidad!", dateComponent: components4)
        } catch{
            // Handle the error.
            print(error.localizedDescription)
        }
        
        
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
