import Foundation

struct Credentials {
    var email : String
    var password : String
}

enum KeychainError: Error {
    case unhandledError(status: OSStatus)
}
