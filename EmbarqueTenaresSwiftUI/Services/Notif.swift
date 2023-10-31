import Foundation
import SwiftUI
import UserNotifications

enum NotifError: Error {
  case invalidDateComponents
  case authorizationDenied
  case other
}

public class Notif : ObservableObject {
    
    init(title: String, body: String, dateComponent: DateComponents) throws {
        if dateComponent.isValidDate(in: Calendar.current) {
            // Request authorization from the user to send notifications.
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                if success {
                    // Create a UNMutableNotificationContent object.
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = body
                    content.sound = UNNotificationSound.default
                    
                    // Create a UNCalendarNotificationTrigger object.
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                    
                    // Create a UNNotificationRequest object.
                    let request = UNNotificationRequest(identifier: "myNotification", content: content, trigger: trigger)
                    
                    // Add the notification request to the notification center.
                    UNUserNotificationCenter.current().add(request) { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    print(error?.localizedDescription ?? "Notifications not allowed")
                }
            }
            print("Notification was created")
        } else {
            throw NotifError.invalidDateComponents
        }
    }
}
