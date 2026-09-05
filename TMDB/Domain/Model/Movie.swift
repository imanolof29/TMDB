//
//  Movie.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

struct Movie: Identifiable, Equatable, Sendable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: URL?
    let backdropURL: URL?
    let releaseDate: Date?
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
}
