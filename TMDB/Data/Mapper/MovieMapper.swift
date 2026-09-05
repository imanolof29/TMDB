//
//  MovieMapper.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

enum MovieMapper {

    private static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")!

    private static let releaseDateFormatter: DateFormatter = {
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
            posterURL: imageURL(path: dto.posterPath),
            backdropURL: imageURL(path: dto.backdropPath),
            releaseDate: dto.releaseDate.flatMap { releaseDateFormatter.date(from: $0) },
            voteAverage: dto.voteAverage,
            voteCount: dto.voteCount,
            runtime: dto.runtime
        )
    }

    nonisolated static func map(_ dtos: [MovieDTO]) -> [Movie] {
        dtos.compactMap { map($0) }
    }

    private static func imageURL(path: String?) -> URL? {
        guard let path else { return nil }
        return imageBaseURL.appendingPathComponent(path)
    }

}
