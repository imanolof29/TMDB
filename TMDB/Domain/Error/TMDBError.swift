//
//  TMDBError.swift
//  TMDB
//
//  Created by Imanol Ortiz on 04/09/2026.
//

import Foundation

public enum TMDBError: Error, Sendable, Equatable {
    case notFound(String)
    case unauthorized
    case networkUnavailable
    case serverError(statusCode: Int)
    case validationFailed(String)
    case unknown(String)
}

extension TMDBError {
    public static func from(_ error: Error) -> TMDBError {
        (error as? TMDBError) ?? .unknown(error.localizedDescription)
    }

    public var userMessage: String {
        switch self {
        case .notFound(let resource):
            return "No encontramos \(resource)."
        case .unauthorized:
            return "Sesión expirada. Vuelve a iniciar sesión."
        case .networkUnavailable:
            return "Sin conexión. Revisa tu internet e intenta de nuevo."
        case .serverError(let code):
            return "Error del servidor (\(code)). Intenta más tarde."
        case .validationFailed(let message):
            return message
        case .unknown(let message):
            return message
        }
    }
}
