//
//  RequestBuilder.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

struct RequestBuilder: Sendable {
    
    public func build(_ endpoint: any Endpoint) throws -> URLRequest {
        guard var components = URLComponents(url: URL(string: "")!, resolvingAgainstBaseURL: true) else {
            throw NetworkError.invalidURL
        }
        
        components.queryItems = endpoint.queryItems
        guard let url = components.url else { throw NetworkError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
}
