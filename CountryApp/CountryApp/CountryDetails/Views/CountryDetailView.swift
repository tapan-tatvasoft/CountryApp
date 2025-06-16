//
//  CountryDetailView.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import SwiftUI

extension String {
    
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
}


struct CountryDetailView: View {
    
    let country: Country
    
    struct ConstantsValue {
        static let zeroSpacing: CGFloat = 0
        static let titleFontSize: CGFloat = 12
        static let descriptionFontSize: CGFloat = 16
        static let viewSpacing: CGFloat = 12
        static let detailSpacing: CGFloat = 4
    }
    
    // MARK: - Body
    var body: some View {
        mainView
            .navigationTitle(country.name.common)
            .navigationBarTitleDisplayMode(.inline)
    }
    
}

// MARK: - Views -
extension CountryDetailView {
    
    // MARK: - Main View
    private var mainView: some View {
        VStack(spacing: ConstantsValue.zeroSpacing) {
            // MARK: Header
       //     headerView
            // MARK: - Country flag view
            if let url = URL(string: country.bestFlagURL ?? "") {
                CachedAsyncImageView(url: url)
                    .frame(width: 64, height: 32)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 2)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 64, height: 32)
            }
            // MARK: - Country Info
            countryInfoView
            Spacer()
        }
    }

    // Country Info
    private var countryInfoView: some View {
        VStack(alignment: .leading, spacing: ConstantsValue.viewSpacing) {
            countryDetailView(with: country.name.official,
                              country.name.common)
            Divider()
            countryDetailView(with: String.DetailView.capitalName,
                              country.capital?[0] ?? "N/A")
            Divider()
            if let currency = country.currencies?.first {
                countryDetailView(with: String.DetailView.currencyName,
                                  "\(currency.value.name) (\(currency.key))")
            } else {
                countryDetailView(with: String.DetailView.currencyName,
                                  "N/A")
            }
            Spacer()
        }
        .padding()
    }
    
}

// MARK: - Helper methods -
extension CountryDetailView {
    
    func countryDetailView(with title: String,
                                   _ description: String) -> some View {
        VStack(alignment: .leading, spacing: ConstantsValue.detailSpacing) {
            Text(title)
                .font(.system(size: ConstantsValue.titleFontSize, weight: .medium))
                .foregroundColor(Color.red)
            Text(description)
                .font(.system(size: ConstantsValue.descriptionFontSize, weight: .regular))
                .foregroundColor(Color.gray)
        }
    }
    
}
