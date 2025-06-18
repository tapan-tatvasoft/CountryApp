//
//  enums.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

enum APIURLS {
    static let baseURL = "https://restcountries.com/v3.1/"
}

enum SystemIcons {
    static let photo = "photo"
    static let trash = "trash"
    static let plusCircleFill = "plus.circle.fill"
    static let magnifyingglass = "magnifyingglass"
    static let xmarkCircleFill = "xmark.circle.fill"
}

enum ActiveAlert {
    case deleteConfirmation
    case countryLimit
}
