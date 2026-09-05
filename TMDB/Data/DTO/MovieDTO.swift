//
//  MovieDTO.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

struct MovieDTO: Sendable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let originalLanguage: String
    let originalTitle: String
    let adult: Bool
    let runtime: Int?
    let tagline: String?
    let status: String?
    /// Solo presente en la respuesta de `movie/{id}` (detalle). Los endpoints de listado
    /// devuelven `genre_ids` en su lugar, que no mapeamos por ahora.
    let genres: [GenreDTO]?
}
