//
//  HTTPRequest.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//

struct HTTPRequest {
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let body: Any?
    
    init(
        url: String,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        body: Any? = nil
    ) {
        self.url = url
        self.method = method
        
        // Default headers
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        // Merge with custom headers (custom headers override defaults)
        for (key, value) in headers {
            defaultHeaders[key] = value
        }
        
        self.headers = defaultHeaders
        self.body = body
    }
    
    // Overloaded initializer for Encodable objects
    init<T: Encodable>(
        url: String,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        bodyObject: T
    ) {
        self.url = url
        self.method = method
        
        // Default headers
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        // Merge with custom headers
        for (key, value) in headers {
            defaultHeaders[key] = value
        }
        
        self.headers = defaultHeaders
        self.body = bodyObject
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
