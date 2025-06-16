//
//  APIService.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import Foundation

protocol APIService {
    func execute<R>(_ request: PreparedRequest<R>) async throws -> R
}
