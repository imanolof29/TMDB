//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

@Observable
final class HomeViewModel {
    
    private(set) var loadState: LoadState<[Movie]> = .idle
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    var allMovies: [Movie] {
        guard case .loaded(let movies) = loadState else { return [] }
        return movies
    }
    
    var isEmpty: Bool { allMovies.isEmpty }
    
    func load() async {
        loadState = .loading
        do {
            let movies = try await movieRepository.getMovies()
            loadState = .loaded(movies)
        } catch {
            loadState = .failed(TMDBError.from(error))
        }
    }
    
    func retry() async {
        loadState = .idle
        await load()
    }
    
    func reload() async {
        loadState = .idle
        do {
            let movies = try await movieRepository.getMovies()
            loadState = .loaded(movies)
        } catch {
            loadState = .failed(TMDBError.from(error))
        }
    }
    
}
