//
//  LocationProviding.swift
//  CountryApp
//
//  Created by Tapan on 18/06/25.
//

// LocationProviding.swift

import Combine

protocol LocationProviding: AnyObject {
    var currentCountryCodePublisher: Published<String?>.Publisher { get }
    var countryName: String? { get }
}
