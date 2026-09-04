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
}
