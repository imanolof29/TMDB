//
//  MovieDetail.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import Foundation

struct MovieDetail: Identifiable, Sendable {
    let id : Int
    let title : String
    let adult : Bool
    let backdropURL : URL?
    let belongsToCollection : String?
    let budget : Int
    let genres : [Genre]
    let homepage : String
    let originCountry : [String]
    let originalLanguage : String
    let originalTitle : String
    let overview : String
    let popularity : Double
    let posterURL : URL?
    let releaseDate : String
    let revenue : Int
    let runtime : Int
    let video : Bool?
    let voteAverage : Double
    let voteCount : Int
}

