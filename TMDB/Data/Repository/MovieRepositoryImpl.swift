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
    
    func getMovieDetail(id: String) async throws -> MovieDetail {
        do {
            let dto: MovieDetailDTO = try await client.request(GetMovieDetailEndpoint(id: id))
            return MovieDetailMapper.map(dto)
        } catch {
            throw mapToTMDBError(error)
        }
    }
    
    func getPopularMovies() async throws -> [Movie] {
        do {
            let endpoint = GetPopularMoviesEndpoint()
            let pageDTO: PaginationDTO<[MovieDTO]> = try await client.request(endpoint)
            return MovieMapper.map(pageDTO.results)
        } catch {
            throw mapToTMDBError(error)
        }
    }
    
    func getNowPlaying() async throws -> [Movie] {
        do {
            let endpoint = GetNowPlayingEndpoint()
            let pageDTO: PaginationDTO<[MovieDTO]> = try await client.request(endpoint)
            return MovieMapper.map(pageDTO.results)
        } catch {
            throw mapToTMDBError(error)
        }
    }
    
}
