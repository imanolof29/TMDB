//
//  MovieEndpoints.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import Foundation

struct GetMoviesEndpoint: Endpoint {
    var path: String { "movies" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
    var headers: [String : String]{ [:] }
}

struct GetMovieEndpoint: Endpoint {
    let id: String
    var method: HTTPMethod { .get }
    var body: Data? { nil }
    var headers: [String : String] { [:] }
    var path: String { "movies/\(id)" }
}
