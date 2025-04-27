//
//  URLSessionHTTPClient.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    init(session: URLSession = .shared) {
        self.session = session
        
        // Configure encoders and decoders
        jsonEncoder.dateEncodingStrategy = .iso8601
        jsonEncoder.keyEncodingStrategy = .useDefaultKeys
        
        jsonDecoder.dateDecodingStrategy = .iso8601
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
    }
    
    func sendRequest<T: Decodable>(_ request: HTTPRequest) async throws -> T {
        guard let url = URL(string: request.url) else {
            throw HTTPClientError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        // Add headers
        for (key, value) in request.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // Add body if exists
        if let body = request.body {
            if let encodableBody = body as? Encodable {
                // If the body is Encodable, use JSONEncoder
                urlRequest.httpBody = try jsonEncoder.encode(AnyEncodable(encodableBody))
            } else if let dictionary = body as? [String: Any] {
                // If the body is a dictionary, use JSONSerialization
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: dictionary)
            } else if let array = body as? [Any] {
                // If the body is an array, use JSONSerialization
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: array)
            }
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPClientError.invalidResponse
            }
            
            switch httpResponse.statusCode {
                case 200...299:
                    do {
                        let decodedResponse = try jsonDecoder.decode(T.self, from: data)
                        return decodedResponse
                    } catch {
                        throw HTTPClientError.decodingFailed(error)
                    }
                case 401:
                    throw HTTPClientError.unauthorized
                default:
                    throw HTTPClientError.serverError(httpResponse.statusCode)
            }
        } catch let error as HTTPClientError {
            throw error
        } catch {
            throw HTTPClientError.requestFailed(error)
        }
    }
}

// Helper to encode any Encodable type
private struct AnyEncodable: Encodable {
    private let encodable: Encodable
    
    init(_ encodable: Encodable) {
        self.encodable = encodable
    }
    
    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
