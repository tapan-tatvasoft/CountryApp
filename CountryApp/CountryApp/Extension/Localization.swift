//
//  Localization.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import Foundation

// MARK: String Localization
public func localizeString(_ stringToLocalize: String) -> String {
    return NSLocalizedString(stringToLocalize, comment: "").precomposedStringWithCanonicalMapping
}
