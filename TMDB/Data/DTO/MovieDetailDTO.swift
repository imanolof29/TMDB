//
//  MovieDetailDTO.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import Foundation

struct MovieDetailDTO: Sendable, Decodable {
    let id : Int
    let title : String
    let adult : Bool
    let backdropPath : String?
    /// TMDB devuelve `null` cuando la película no pertenece a ninguna saga.
    let belongsToCollection : String?
    let budget : Int
    let genres : [GenreDTO]
    let homepage : String
    let originCountry : [String]
    let originalLanguage : String
    let originalTitle : String
    let overview : String
    let popularity : Double
    let posterPath : String?
    let releaseDate : String
    let revenue : Int
    let runtime : Int
    let video : Bool?
    let voteAverage : Double
    let voteCount : Int
}
