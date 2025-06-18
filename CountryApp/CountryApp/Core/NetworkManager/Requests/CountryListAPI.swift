//
//  CountryListAPI.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import Foundation

enum CouontryListAPI {
    static func getCountries(searchName: String) throws -> PreparedRequest<[Country]> {
        
        let endpoint = CountryEndpoint.searchCountry(
            name: searchName,
            fields: ["cca3", "cca2", "name", "flags", "flag", "currencies", "latlng", "capital"]
        )
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return PreparedRequest<[Country]>(
            urlRequest: request,
            decode: { data in
                try JSONDecoder().decode([Country].self, from: data)
            }
        )
    }
}
