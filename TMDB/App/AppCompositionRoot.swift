//
//  AppCompositionRoot.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import Foundation
import Observation

@MainActor
@Observable
class AppCompositionRoot {
    
    let movieRepository: any MovieRepositoryProtocol
    
    init() {
        let apiClient = AppCompositionRoot.buildAPIClient()
        movieRepository = MovieRepository(client: apiClient)
    }
    
    private static func buildAPIClient() -> APIClientProtocol {
        return APIClient(session: URLSession(configuration: .default), requestBuilder: RequestBuilder())
    }

}
