//
//  ErrorTypes.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 3/26/22.
//

import Foundation

enum DatabaseError:String,Error{
    case failed = "Failed to Fetch from Database"
}

enum AuthErorr: String,Error{
    case failedToConnect = "Failed to connect to database"
}

