//
//  HTTPClientInjection.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//


// MARK: - HTTP Client Key
struct HTTPClientKey: InjectedKey {
    static var currentValue: HTTPClient = HTTPClientFactory.shared.makeHTTPClient()
}

// MARK: - InjectedValues Extension
extension InjectedValues {
    var httpClient: HTTPClient {
        get { Self[HTTPClientKey.self] }
        set { Self[HTTPClientKey.self] = newValue }
    }
}

// MARK: - DependencyContainer Extension
extension DependencyContainer {
    static func registerNetworkServices() {
        InjectedValues[\.httpClient] = HTTPClientFactory.shared.makeHTTPClient()
    }
    
    static func registerMockNetworkServices() {
        InjectedValues[\.httpClient] = HTTPClientFactory.shared.makeMockHTTPClient()
    }
}
