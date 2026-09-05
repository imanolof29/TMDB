//
//  TMDBApp.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import SwiftUI

@main
struct TMDBApp: App {
    
    @State private var compositionRoot = AppCompositionRoot()
    @State private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            HomeView(homeViewModel: HomeViewModel(movieRepository: compositionRoot.movieRepository))
                .environment(compositionRoot)
                .environment(coordinator)
        }
    }
}
