//
//  HTTPClient.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//


import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(_ request: HTTPRequest) async throws -> T
}

// Extension to add helper methods to all HTTPClient implementations
extension HTTPClient {
    // GET request
    func get<T: Decodable>(url: String, headers: [String: String] = [:]) async throws -> T {
        let request = HTTPRequest(url: url, method: .get, headers: headers)
        return try await sendRequest(request)
    }
    
    // POST request with dictionary body
    func post<T: Decodable>(url: String, body: [String: Any]?, headers: [String: String] = [:]) async throws -> T {
        let request = HTTPRequest(url: url, method: .post, headers: headers, body: body)
        return try await sendRequest(request)
    }
    
    // POST request with Encodable body
    func post<T: Decodable, U: Encodable>(url: String, body: U, headers: [String: String] = [:]) async throws -> T {
        let request = HTTPRequest(url: url, method: .post, headers: headers, bodyObject: body)
        return try await sendRequest(request)
    }
    
    // PUT request with dictionary body
    func put<T: Decodable>(url: String, body: [String: Any]?, headers: [String: String] = [:]) async throws -> T {
        let request = HTTPRequest(url: url, method: .put, headers: headers, body: body)
        return try await sendRequest(request)
    }
    
    // PUT request with Encodable body
    func put<T: Decodable, U: Encodable>(url: String, body: U, headers: [String: String] = [:]) async throws -> T {
        let request = HTTPRequest(url: url, method: .put, headers: headers, bodyObject: body)
        return try await sendRequest(request)
    }
    
    // PATCH request with dictionary body
    func patch<T: Decodable>(url: String, body: [String: Any]?, headers: [String: String] = [:]) async throws -> T {
        let request = HTTPRequest(url: url, method: .patch, headers: headers, body: body)
        return try await sendRequest(request)
    }
    
    // PATCH request with Encodable body
    func patch<T: Decodable, U: Encodable>(url: String, body: U, headers: [String: String] = [:]) async throws -> T {
        let request = HTTPRequest(url: url, method: .patch, headers: headers, bodyObject: body)
        return try await sendRequest(request)
    }
    
    // DELETE request
    func delete<T: Decodable>(url: String, headers: [String: String] = [:]) async throws -> T {
        let request = HTTPRequest(url: url, method: .delete, headers: headers)
        return try await sendRequest(request)
    }
    
    // DELETE request with body
    func delete<T: Decodable, U: Encodable>(url: String, body: U, headers: [String: String] = [:]) async throws -> T {
        let request = HTTPRequest(url: url, method: .delete, headers: headers, bodyObject: body)
        return try await sendRequest(request)
    }
}

enum HTTPClientError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case serverError(Int)
    case unauthorized
    case unknownError
    case invalidRequestData
}
