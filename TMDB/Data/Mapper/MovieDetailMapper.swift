//
//  MovieDetailMapper.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import Foundation

enum MovieDetailMapper {

    nonisolated static func map(_ dto: MovieDetailDTO) -> MovieDetail {
        MovieDetail(
            id: dto.id,
            title: dto.title,
            adult: dto.adult,
            backdropURL: ImageURLBuilder.url(path: dto.backdropPath),
            belongsToCollection: dto.belongsToCollection,
            budget: dto.budget,
            genres: GenreMapper.map(dto.genres),
            homepage: dto.homepage,
            originCountry: dto.originCountry,
            originalLanguage: dto.originalLanguage,
            originalTitle: dto.originalTitle,
            overview: dto.overview,
            popularity: dto.popularity,
            posterURL: ImageURLBuilder.url(path: dto.posterPath),
            releaseDate: dto.releaseDate,
            revenue: dto.revenue,
            runtime: dto.runtime,
            video: dto.video,
            voteAverage: dto.voteAverage,
            voteCount: dto.voteCount
        )
    }

}
