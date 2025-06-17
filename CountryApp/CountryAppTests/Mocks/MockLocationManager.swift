//
//  MockLocationManager.swift
//  CountryApp
//
//  Created by Tapan on 18/06/25.
//

// MARK: - MockLocationManager.swift
// In Tests/CountryAppTests/MockLocationManager.swift

import Foundation
import Combine
@testable import CountryApp

final class MockLocationManager: LocationProviding {
    @Published var currentCountryCode: String? = "IN"
    var countryName: String? = "India"

    var currentCountryCodePublisher: Published<String?>.Publisher {
        $currentCountryCode
    }
}
