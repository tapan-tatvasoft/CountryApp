//
//  CountryModel.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

struct Country: Codable, Identifiable {
    var id: String
    let name: CountryName
    let capital: [String]?
    let flags: Flags?
    let flag: String?
    let currencies: [String: Currency]?
    var bestFlagURL: String? {
        
        
        if let svg = flags?.svg, !svg.isEmpty {
            return svg
        }
        if let png = flags?.png, !png.isEmpty {
            return png
        }
        if let flag = flag, !flag.isEmpty {
            return flag
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "cca3"
        case name, capital, flags, flag, currencies
    }
}

struct CountryName: Codable {
    let common: String
    let official: String
}

struct Currency: Codable {
    let name: String
    let symbol: String
}

struct Flags: Codable {
    let svg: String?
    let png: String?
}
