//
//  MovieRepository.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getMovies() async throws -> [Movie]
    func getMovie(id: String) async throws -> Movie
}
