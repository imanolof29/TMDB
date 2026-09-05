//
//  HomeView.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import SwiftUI

@MainActor
struct HomeView: View {

    @Environment(AppCoordinator.self) private var coordinator
    @Environment(AppCompositionRoot.self) private var compositionRoot

    @State private var homeViewModel: HomeViewModel

    init(homeViewModel: HomeViewModel) {
        _homeViewModel = State(initialValue: homeViewModel)
    }

    var body: some View {
        @Bindable var coordinator = coordinator
        NavigationStack(path: $coordinator.homePath) {
            Group {
                switch homeViewModel.loadState {
                case .loading, .idle:
                    ProgressView()

                case .loaded:
                    loadedContent

                case .failed:
                    errorView(homeViewModel.loadState.userMessage)
                }
            }
            .navigationTitle("Películas")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await homeViewModel.load()
            }
            .navigationDestination(for: TMDBRoute.self) { route in
                switch route {
                case .home:
                    EmptyView()
                case .movieDetail(let id):
                    MovieDetailView(viewModel: MovieDetailViewModel(movieId: id, movieRepository: compositionRoot.movieRepository))
                }
            }
        }
    }

    private var loadedContent: some View {
        VStack(spacing: 0) {
            if homeViewModel.isEmpty {
                EmptyView()
            } else {
                moviesList
            }
        }
    }

    private var moviesList: some View {
        List {
            ForEach(homeViewModel.allMovies) { movie in
                NavigationLink(value: TMDBRoute.movieDetail(id: movie.id)) {
                    MovieCardView(movie: movie)
                }
            }
        }
        .listStyle(.plain)
        .refreshable { await homeViewModel.reload() }
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
            Text(message)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button("Reintentar") { Task { await homeViewModel.retry() } }
                .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(32)
    }

}
