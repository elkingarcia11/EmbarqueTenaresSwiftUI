//
//  TrackModel.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 7/18/22.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case tokenNotSet
    case missingAuthHeadersError
    case apiUrlNotSet
    case apiError(String)
    case networkError
    case unknown(String)
}

extension APIError : LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .apiError(let error):
                return error
            case .decodingError:
                return "Decoding error"
            case .errorCode(let code):
                return "Error code: \(code)"
            case .tokenNotSet:
                return "Token not set"
            case .missingAuthHeadersError:
                return "Missing auth headers in api request"
            case .apiUrlNotSet:
                return "API url is not set"
            case .networkError:
                return "Network error"
            case .unknown(let error):
                return error
        }
    }
}

enum APIState : Equatable {
    case successful
    case failed
    case loading
    case na
}

struct APIResponse<T:Codable> : Codable {
    let status : Int
    let action : String
    let message : String
    let response : [T]
}

struct LogInResponse : Codable {
    let token : Token
    let user : User
}

struct Token : Codable {
    let access : String
    let refresh : String
}

struct User : Codable {
    let id : Int
    let fullName : String
    let userName : String
    let active : Bool
    let role : String
}

struct InvoiceResponse: Codable {
    let number : String
    let date : String
    let container : String
}
