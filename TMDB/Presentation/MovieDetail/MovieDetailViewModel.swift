//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import Foundation

@Observable
final class MovieDetailViewModel {

    private(set) var loadState: LoadState<Movie> = .idle

    private let movieId: Int
    private let movieRepository: MovieRepositoryProtocol

    init(movieId: Int, movieRepository: MovieRepositoryProtocol) {
        self.movieId = movieId
        self.movieRepository = movieRepository
    }

    func load() async {
        loadState = .loading
        do {
            let movie = try await movieRepository.getMovie(id: String(movieId))
            loadState = .loaded(movie)
        } catch {
            loadState = .failed(TMDBError.from(error))
        }
    }

    func retry() async {
        loadState = .idle
        await load()
    }

}
