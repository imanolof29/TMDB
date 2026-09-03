//
//  APIClient.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

public enum NetworkError: Error, Sendable, Equatable {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int)
    case decodingFailed(String)
    case unauthorized
    case serverError(statusCode: Int, message: String?)
    case cancelled
}

protocol APIClientProtocol: Sendable {
    func request<T: Decodable>(endpoint: any Endpoint) async throws -> T
}

public final class APIClient: APIClientProtocol, Sendable {
    
    private let session: URLSession
    private let requestBuilder: RequestBuilder
    
    init(session: URLSession, requestBuilder: RequestBuilder) {
        self.session = session
        self.requestBuilder = requestBuilder
    }
    
    func request<T>(endpoint: any Endpoint) async throws -> T where T : Decodable {
        let urlRequest = try buildRequest(for: endpoint)
        let (data, response) = try await performRequest(urlRequest)

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
         
        try validate(statusCode: http.statusCode)
        return try decode(data)
    }
    
    private func buildRequest(for endpoint: any Endpoint) throws -> URLRequest {
        return try requestBuilder.build(endpoint)
    }

    private func performRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: request)
        } catch let urlError as URLError where urlError.code == .cancelled {
            throw NetworkError.cancelled
        } catch {
            throw error
        }
    }
    
    private func validate(statusCode: Int) throws {
        switch statusCode {
        case 200...299: return
        case 401:       throw NetworkError.unauthorized
        case 400...499: throw NetworkError.requestFailed(statusCode: statusCode)
        case 500...599: throw NetworkError.serverError(statusCode: statusCode, message: nil)
        default:        throw NetworkError.requestFailed(statusCode: statusCode)
        }
    }

    private func decode<T: Decodable>(_ data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            let wrapped = NetworkError.decodingFailed(error.localizedDescription)
            throw wrapped
        }
    }
    
}
