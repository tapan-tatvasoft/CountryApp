//
//  MockAPIService.swift
//  CountryApp
//
//  Created by Tapan on 18/06/25.
//

import Foundation
import Combine
@testable import CountryApp

final class MockAPIService: APIService {
    var countriesToReturn: [Country] = []
    var shouldThrowError = false

    func execute<R>(_ request: PreparedRequest<R>) async throws -> R {
        print("Mock API executed")
        
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }

        guard let result = countriesToReturn as? R else {
            fatalError("MockAPIService: Could not cast result")
        }
        
        return result
    }

}
