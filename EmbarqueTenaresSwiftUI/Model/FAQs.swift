//
//  FAQs.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 3/21/22.
//

import Foundation

// Each db entry will be 
struct FAQs: Identifiable, Codable {
    var id : Int
    var q_en : String
    var q_es : String
    var a_en : String
    var a_es : String
}

struct QandA: Identifiable {
    var id : Int
    var q : String
    var a : String
}
