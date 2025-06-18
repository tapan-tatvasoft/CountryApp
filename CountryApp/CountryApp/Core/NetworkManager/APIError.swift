//
//  APIError.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(statusCode: Int, message: String?)
    case network(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return localizeString("invalidURL")
        case .invalidResponse:
            return localizeString("invalidResponse")
        case .decodingFailed:
            return localizeString("decodingError")
        case .serverError(let code, let message):
            if code == 404 {
                return localizeString("dataNotFound")
            }
            return "\(localizeString("serverError")), (\(code): \(message ?? localizeString("unknownError")))"
        case .network(let error):
            return error.localizedDescription
        case .unknown:
            return localizeString("unknownError")
        }
    }
}
