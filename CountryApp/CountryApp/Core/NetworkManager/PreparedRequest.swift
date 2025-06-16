//
//  PreparedRequest.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import Foundation

struct PreparedRequest<Response: Decodable> {
    let urlRequest: URLRequest
    let decode: (Data) throws -> Response
}
