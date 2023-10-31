import Foundation

// List of categories retrieved from database
struct RatesCategoryServiceResult: Codable {
    let results: [Category]
}

// List of items in category retrieved from database
struct RatesItemServiceResult: Codable {
    let results: [Item]
}

// Category structure
struct Category: Identifiable, Codable {
    var id : Int
    var name_en : String
    var name_es : String
    var items : [Item]?
}

// Item of category structure
struct Item: Identifiable, Codable {
    var id : UUID
    var name_en: String
    var name_es: String
    var price: String
}

