//
//  Endpoint.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

public enum HTTPMethod: String, Sendable {
    case get = "GET"
}

public protocol Endpoint: Sendable {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var headers: [String: String] { get }
}

public extension Endpoint {
    var queryItems: [URLQueryItem]? { nil }
    var bodyData: Data? { nil }
}
