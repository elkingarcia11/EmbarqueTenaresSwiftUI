//
//  Notif.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 6/7/23.
//

import Foundation
import SwiftUI
import UserNotifications

class Notif : ObservableObject {
    
    init(title: String, body: String, dateComponent: DateComponents) {
        
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
                print(error?.localizedDescription ?? "Notifcations not allowed")
            }
        }
        
    }
}
