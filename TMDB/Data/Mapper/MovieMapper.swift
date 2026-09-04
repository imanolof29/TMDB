//
//  MovieMapper.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

enum MovieMapper {
    
    nonisolated static func map(_ dto: MovieDTO) -> Movie? {
        .init(id: dto.id, title: dto.title, overview: dto.overview)
    }
    
    nonisolated static func map(_ dtos: [MovieDTO]) -> [Movie] {
        dtos.compactMap { map($0) }
    }
    
}
