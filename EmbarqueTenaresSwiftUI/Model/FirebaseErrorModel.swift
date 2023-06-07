//
//  FirebaseErrorModel.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 4/5/23.
//

import Foundation
import SwiftUI

enum FirebaseError: Error {
    case failToReadDocument
    case failToGetToken
    case failToGetUser
    case notActive

    // returns a text view with the localized error string
    var localizedDescription: Text? {
        let userNotActiveText: LocalizedStringKey = "login.userNotActive"
        switch self {
        case .notActive:
            return Text(userNotActiveText)//"User is disabled, failed to sign-in"
        case .failToReadDocument:
            return Text("Failed to read snapshot document")
        case .failToGetToken:
            return Text("Failed to get auth token")
        case .failToGetUser:
            return Text("Failed to get current user")
        }
    }
}
