//
//  ImageURLBuilder.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import Foundation


enum ImageURLBuilder {

    private nonisolated static let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")!

    nonisolated static func url(path: String?) -> URL? {
        guard let path else { return nil }
        return baseURL.appendingPathComponent(path)
    }

}
