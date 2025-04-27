//
//  NetworkServices.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//

import Foundation

class NetworkService: HTTPClient {
    private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func sendRequest<T: Decodable>(_ request: HTTPRequest) async throws -> T {
        do {
            return try await client.sendRequest(request)
        } catch let error as HTTPClientError {
            // Here we can add common error handling, logging, etc.
            switch error {
                case .unauthorized:
                    // Handle authentication issues (e.g., trigger logout)
                    NotificationCenter.default.post(name: NSNotification.Name("UserAuthenticationFailed"), object: nil)
                    throw error
                default:
                    throw error
            }
        } catch {
            throw HTTPClientError.unknownError
        }
    }
}
