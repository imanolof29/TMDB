//
//  MovieRepository.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

final class MovieRepository: MovieRepositoryProtocol, Sendable {
    
    private let client: any APIClientProtocol
    
    init(client: any APIClientProtocol) {
        self.client = client
    }
    
    func getMovies() async throws -> [Movie] {
        do {
            let endpoint = GetMoviesEndpoint()
            let pageDTO: PaginationDTO<[MovieDTO]> = try await client.request(endpoint)
            return MovieMapper.map(pageDTO.results)
        } catch {
            throw mapToTMDBError(error)
        }
    }
    
    func getMovie(id: String) async throws -> Movie {
        do {
            let dto: MovieDTO = try await client.request(GetMovieEndpoint(id: id))
            guard let movie = MovieMapper.map(dto) else {
                throw TMDBError.unknown("Invalid response")
            }
            return movie
        } catch {
            throw mapToTMDBError(error)
        }
    }
    
}
