//
//  HomeView.swift
//  TMDB
//
//  Created by Imanol Ortiz on 03/09/2026.
//

import SwiftUI

struct HomeView: View {
    
    @State private var homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        _homeViewModel = State(initialValue: homeViewModel)
    }
    
    @State private var columns = [
        GridItem(.flexible(minimum: 50, maximum: .infinity)),
        GridItem(.flexible(minimum: 50, maximum: .infinity))
    ]
    
    var body: some View {
        NavigationStack {
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
                MovieCardView(movie: movie)
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
