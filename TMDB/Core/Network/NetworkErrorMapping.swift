//
//  NetworkErrorMapping.swift
//  TMDB
//
//  Created by Imanol Ortiz on 04/09/2026.
//

import Foundation


nonisolated func mapToTMDBError(_ error: Error) -> TMDBError {
    if let ifError = error as? TMDBError { return ifError }

    if let networkErr = error as? NetworkError {
        switch networkErr {
        case .unauthorized:
            return .unauthorized
        case .requestFailed(let code) where code == 404:
            return .notFound("el recurso solicitado")
        case .requestFailed(let code):
            return .serverError(statusCode: code)
        case .serverError(let code, _):
            return .serverError(statusCode: code)
        case .cancelled:
            return .networkUnavailable
        case .invalidURL, .decodingFailed, .invalidResponse:
            return .unknown(String(describing: networkErr))
        }
    }

    if let urlErr = error as? URLError {
        switch urlErr.code {
        case .notConnectedToInternet, .networkConnectionLost, .timedOut, .cannotConnectToHost:
            return .networkUnavailable
        default:
            return .unknown(urlErr.localizedDescription)
        }
    }

    return .unknown(String(describing: error))
}
