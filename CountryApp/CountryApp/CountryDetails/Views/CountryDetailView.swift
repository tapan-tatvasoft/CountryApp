//
//  CountryDetailView.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import SwiftUI

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
            WebImageView(
                urlString: country.bestFlagURL,
                placeholderImageName: SystemIcons.photo,
                width: 200,
                height: 100
            )
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
            countryDetailView(with: localizeString("capitalName"),
                              country.capital?[0] ?? "N/A")
            Divider()
            if let currency = country.currencies?.first {
                countryDetailView(with: localizeString("currencyName"),
                                  "\(currency.value.name) (\(currency.key))")
            } else {
                countryDetailView(with: localizeString("currencyName"),
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
