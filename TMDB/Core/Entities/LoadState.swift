//
//  LoadState.swift
//  TMDB
//
//  Created by Imanol Ortiz on 04/09/2026.
//

import Foundation

public enum LoadState<T: Sendable>: Sendable {
    case idle
    case loading
    case loaded(T)
    case failed(TMDBError)
}

extension LoadState {
    public var ifError: TMDBError? {
        guard case .failed(let error) = self else { return nil }
        return error
    }

    public var userMessage: String {
        guard case .failed(let error) = self else { return "" }
        return error.userMessage
    }
}
