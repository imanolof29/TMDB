//
//  MovieMapper.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

enum MovieMapper {

    private nonisolated static let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    nonisolated static func map(_ dto: MovieDTO) -> Movie? {
        Movie(
            id: dto.id,
            title: dto.title,
            overview: dto.overview,
            posterURL: ImageURLBuilder.url(path: dto.posterPath),
            backdropURL: ImageURLBuilder.url(path: dto.backdropPath),
            releaseDate: dto.releaseDate.flatMap { releaseDateFormatter.date(from: $0) },
            voteAverage: dto.voteAverage,
            voteCount: dto.voteCount,
            runtime: dto.runtime,
            genres: GenreMapper.map(dto.genres ?? [])
        )
    }

    nonisolated static func map(_ dtos: [MovieDTO]) -> [Movie] {
        dtos.compactMap { map($0) }
    }

}
