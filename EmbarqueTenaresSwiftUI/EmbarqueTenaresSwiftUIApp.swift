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

class YourAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    if #available(iOS 14.0, *) {
      return AppAttestProvider(app: app)
    } else {
      return DeviceCheckProvider(app: app)
    }
  }
}

@main
struct EmbarqueTenaresSwiftUIApp: App {
    
    init() {
        
        let providerFactory = YourAppCheckProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
        if let auth_u = Bundle.main.infoDictionary?["AUTH_U"] as? String {
            if let auth_p = Bundle.main.infoDictionary?["AUTH_P"] as? String {
                Auth.auth().signIn(withEmail: auth_u, password: auth_p){
                    (result, error) in
                    if error != nil {
                        print(error?.localizedDescription ?? "Error signing in")
                    } else {
                        print("Signed in succesfully")
                    }
                }
            }
        }
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        // Regular notif
        let rN = UNMutableNotificationContent()
        rN.title = "¡Ofertas disponibles!"
        rN.body = "¡Aprovecha nuestras ofertas y llámanos hoy!"
        rN.sound = UNNotificationSound.default
        
        // Early jan
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.month = 1
        dateComponents.day = 10
        dateComponents.hour = 12
        
        var trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        var request = UNNotificationRequest(identifier: UUID().uuidString, content: rN, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        // early april
        dateComponents.month = 4
        dateComponents.day = 10
        dateComponents.hour = 12
        
        trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        request = UNNotificationRequest(identifier: UUID().uuidString, content: rN, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)

        
        let sN = UNMutableNotificationContent()
        sN.title = "¡El verano ya casi está aquí!"
        sN.body = "¡Envíe sus artículos de vacaciones con nosotros!"
        sN.sound = UNNotificationSound.default
        
        dateComponents.month = 5
        dateComponents.day = 31
        dateComponents.hour = 12
        
        trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        request = UNNotificationRequest(identifier: UUID().uuidString, content: sN, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        
        let wN = UNMutableNotificationContent()
        wN.title = "¡La Navidad ya casi está aquí!"
        wN.body = "¡Llama y programa tu cita antes del 20 de noviembre para recibir tus artículos antes de Navidad!"
        wN.sound = UNNotificationSound.default
        
        dateComponents.month = 10
        dateComponents.day = 27
        dateComponents.hour = 12
        
        trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        request = UNNotificationRequest(identifier: UUID().uuidString, content: sN, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
       WindowGroup {
           SplashScreenView()
       }
   }
}
