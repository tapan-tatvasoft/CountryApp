//
//  CountryListAPI.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import Foundation

let API_URL = "https://restcountries.com/v3.1/name/%@?fields=cca3,cca2,name,flags,flag,currencies,latlng,capital"


enum CouontryListAPI {
    static func getCountries(searchName: String) throws -> PreparedRequest<[Country]> {
        
        guard let url = URL(string: String(format: API_URL, searchName)) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
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
