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
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed:
            return "Unable to decode the response."
        case .serverError(let code, let message):
            return "Server error (\(code)): \(message ?? "Unknown error")"
        case .network(let error):
            return error.localizedDescription
        case .unknown:
            return "Unknown error."
        }
    }
}
