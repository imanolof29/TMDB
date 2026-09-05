//
//  GenreMapper.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import Foundation

enum GenreMapper {

    nonisolated static func map(_ dto: GenreDTO) -> Genre {
        Genre(id: dto.id, name: dto.name)
    }

    nonisolated static func map(_ dtos: [GenreDTO]) -> [Genre] {
        dtos.map(map)
    }

}
