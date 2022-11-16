import Foundation

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
