//
//  CountryListViewModelTests.swift
//  CountryApp
//
//  Created by Tapan on 18/06/25.
//

import XCTest
import Combine
@testable import CountryApp
import SwiftData

@MainActor
final class CountryListViewModelTests: XCTestCase {
    var viewModel: CountryListViewModel!
    var mockAPI: MockAPIService!
    var locationManager: MockLocationManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()

        mockAPI = MockAPIService()
        locationManager = MockLocationManager()

        viewModel = CountryListViewModel(apiService: mockAPI, locationManager: locationManager)

        // Create in-memory SwiftData context
        let container = try! ModelContainer(for: CDCountry.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = ModelContext(container)

        viewModel.setContext(context)
    }


    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        locationManager = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchCountries_success() async {
        // Given
        
        let mockCountry = Country(id: "1", name: .init(common: "India", official: "India"), capital: ["Delhi"], flags: .init(svg: nil, png: nil), flag: nil, currencies: ["INR": .init(name: "Ruppes", symbol: "INR")], countryCode: "IN")
        
        mockAPI.countriesToReturn = [mockCountry]
        viewModel.searchText = "India"

        // When
        await viewModel.fetchCountries()

        // Then
        XCTAssertEqual(viewModel.searchResults.count, 1)
        XCTAssertEqual(viewModel.searchResults.first?.name.common, "India")
    }

    func test_fetchCountries_failure() async {
        // Given
        mockAPI.shouldThrowError = true
        viewModel.searchText = "XYZ"

        // When
        await viewModel.fetchCountries()

        // Then
        XCTAssertEqual(viewModel.searchResults.count, 0)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func test_selectInitialCountry_addsCountry() async {
        // Given
        let mockCountry = Country(
            id: "1",
            name: .init(common: "India", official: "India"),
            capital: ["Delhi"],
            flags: .init(svg: nil, png: "https://flagcdn.com/w320/in.png"),
            flag: "🇮🇳",
            currencies: ["INR": .init(name: "Rupees", symbol: "₹")],
            countryCode: "IN"
        )

        mockAPI.countriesToReturn = [mockCountry]

        // When
        await viewModel.selectInitialCountry(with: "IN", countryName: "India")

        // Then
        XCTAssertTrue(
            viewModel.countries.contains(where: { $0.countryCode == "IN" }),
            "Country should be added to the list"
        )
    }


    func test_addCountry_shouldAddToList() {
        // Given
        let mockCountry = Country(
            id: "1",
            name: .init(common: "India", official: "India"),
            capital: ["Delhi"],
            flags: .init(svg: nil, png: "https://flagcdn.com/w320/in.png"),
            flag: "🇮🇳",
            currencies: ["INR": .init(name: "Rupees", symbol: "₹")],
            countryCode: "IN"
        )
        // When
        viewModel.countries = []
        viewModel.addCountry(mockCountry)

        // Then
        XCTAssertTrue(viewModel.countries.contains(where: { $0.id == "1" }))
    }

    func test_removeCountry_shouldRemoveFromList() {
        // Given
        let mockCountry = Country(
            id: "1",
            name: .init(common: "India", official: "India"),
            capital: ["Delhi"],
            flags: .init(svg: nil, png: "https://flagcdn.com/w320/in.png"),
            flag: "🇮🇳",
            currencies: ["INR": .init(name: "Rupees", symbol: "₹")],
            countryCode: "IN"
        )
        viewModel.countries = [mockCountry]

        // When
        viewModel.removeCountry(at: IndexSet(integer: 0))

        // Then
        XCTAssertFalse(viewModel.countries.contains(where: { $0.id == "1" }))
    }
}
