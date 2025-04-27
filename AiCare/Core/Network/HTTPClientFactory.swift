//
//  HTTPSClientFactory.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//

import Foundation

class HTTPClientFactory {
    static let shared = HTTPClientFactory()
    
    private init() {}
    
    func makeHTTPClient() -> HTTPClient {
#if DEBUG
        // In debug mode, we might want to use a special configuration
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 300
        
        // You could also add logging interceptor or other debug features
        let session = URLSession(configuration: configuration)
        let urlSessionClient = URLSessionHTTPClient(session: session)
        return NetworkService(client: urlSessionClient)
#else
        // In production, use standard configuration
        return NetworkService(client: URLSessionHTTPClient())
#endif
    }
    
    func makeMockHTTPClient() -> HTTPClient {
        // For testing purposes
        return MockHTTPClient()
    }
}

// Mock implementation for testing
class MockHTTPClient: HTTPClient {
    var response: Any?
    var error: Error?
    
    func sendRequest<T: Decodable>(_ request: HTTPRequest) async throws -> T {
        if let error = error {
            throw error
        }
        
        if let response = response as? T {
            return response
        }
        
        throw HTTPClientError.unknownError
    }
    
    func setResponse<T: Decodable>(_ response: T) {
        self.response = response
    }
    
    func setError(_ error: Error) {
        self.error = error
    }
}
