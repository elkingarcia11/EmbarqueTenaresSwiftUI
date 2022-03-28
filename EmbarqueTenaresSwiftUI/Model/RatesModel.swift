import Foundation


struct CategoryAndItems: Identifiable, Codable {
    let id : Int
    var category : Category
    var items : [Item]
}


struct RatesCategoryServiceResult: Codable {
    let results: [Category]
}

struct RatesItemServiceResult: Codable {
    let results: [Item]
}

struct Category: Identifiable, Codable {
    var id : Int
    var name_en : String
    var name_es : String
}

struct Item: Identifiable, Codable {
    var id : Int
    var name_en: String
    var name_es: String
    var price: String
}

