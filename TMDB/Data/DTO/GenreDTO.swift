//
//  GenreDTO.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import Foundation

struct GenreDTO: Sendable, Decodable {
    let id: Int
    let name: String
}
