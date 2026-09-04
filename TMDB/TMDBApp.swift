//
//  TMDBApp.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import SwiftUI

@main
struct TMDBApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(homeViewModel: HomeViewModel(movieRepository: MovieRepository(client: APIClient(session: URLSession(), requestBuilder: RequestBuilder()))))
        }
    }
}
