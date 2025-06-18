//
//  StoredCountry.swift
//  CountryApp
//
//  Created by Tapan on 17/06/25.
//

import Foundation
import SwiftData

@Model
class CDCountry {
    var id: String
    var name: String
    var flagURL: String?
    var countryCode: String
    var capital: String?

    init(id: String, name: String, flagURL: String?, countryCode: String, capital: String?) {
        self.id = id
        self.name = name
        self.flagURL = flagURL
        self.countryCode = countryCode
        self.capital = capital
    }

    convenience init(model: Country) {
        self.init(
            id: model.id,
            name: model.name.common,
            flagURL: model.bestFlagURL,
            countryCode: model.countryCode,
            capital: model.capital?.first
        )
    }

    func toModel() -> Country {
        return Country(
            id: id,
            name: CountryName(common: name, official: name),
            capital: capital.map { [$0] },
            flags: Flags(svg: nil, png: flagURL),
            flag: flagURL,
            currencies: nil,
            countryCode: countryCode
        )
    }
}
