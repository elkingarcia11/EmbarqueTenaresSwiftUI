//
//  Config.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 11/23/22.
//

import Foundation

struct Config : Decodable {
    let FBUS : String
    let FBPS : String
}

struct ConfigValues {
    
    static func get() -> Config {
        guard let url = Bundle.main.url(forResource: "Config", withExtension: "plist") else {
            fatalError("Could not find Config.plist in your Bundle")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            return try decoder.decode(Config.self, from: data)
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }
    
}
