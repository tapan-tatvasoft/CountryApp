//
//  NetworkManager.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import Foundation


actor APIManager: APIService {
    static let shared = APIManager()

    func execute<R>(_ request: PreparedRequest<R>) async throws -> R {
        let (data, response) = try await URLSession.shared.data(for: request.urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8)
            throw APIError.serverError(statusCode: httpResponse.statusCode, message: message)
        }

        return try request.decode(data)
    }
}
