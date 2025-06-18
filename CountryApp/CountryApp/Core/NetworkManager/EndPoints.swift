//
//  EndPoints.swift
//  CountryApp
//
//  Created by Tapan on 18/06/25.
//

import Foundation

enum Environment {
    static var baseURL: String {
        guard let url = ProcessInfo.processInfo.environment["API_BASE_URL"] else {
            return APIURLS.baseURL
        }
        return url
    }
}

enum CountryEndpoint {
    case searchCountry(name: String, fields: [String])

    var path: String {
        switch self {
        case let .searchCountry(name, fields):
            let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
            let fieldsQuery = fields.joined(separator: ",")
            return "name/\(encodedName)?fields=\(fieldsQuery)"
        }
    }

    var url: URL {
        guard let url = URL(string: Environment.baseURL + path) else {
            fatalError("Invalid URL for endpoint: \(self)")
        }
        return url
    }
}

