//
//  enums.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

enum SelectedCountries {
    static let navigationTitle = "Countries"
    static let headerTitle = "Selected Countries"
    static let searchBtnTitle = "Search Country"
    static let progressTitle = "Fetching location…"
    static let nocountriesAdded = "No countries added yet."
    static let noInternetConnection = "You are not connected to the internet. Please check your connection."
    static let tryAgain = "Try again"
}

enum DetailView {
    static let navigationTitle = "Country Details"
    static let countryName = "Country Name:"
    static let capitalName = "Capital:"
    static let currencyName = "Currency:"
}

enum CountrySearchView {
    static let navigationTitle = "Country Search"
    static let searchForACountry = "Search for a country"
    static let noResult = "No results found \n Please try a different search"
}
