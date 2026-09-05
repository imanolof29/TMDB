//
//  MovieDetailView.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import SwiftUI

struct MovieDetailView: View {

    @State private var viewModel: MovieDetailViewModel

    init(viewModel: MovieDetailViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        Group {
            switch viewModel.loadState {
            case .idle, .loading:
                ProgressView()

            case .loaded(let movie):
                content(for: movie)

            case .failed:
                errorView(viewModel.loadState.userMessage)
            }
        }
        .task {
            await viewModel.load()
        }
        .ignoresSafeArea(edges: .top)
        .toolbarBackground(.hidden, for: .navigationBar)
    }

    private func content(for movie: MovieDetail) -> some View {
        ScrollView {
            VStack {
                RemoteImage(url: movie.posterURL)
                VStack(alignment: .leading, spacing: 16){
                    Text(movie.title)
                        .font(.title2)
                        .bold()

                    HStack(spacing: 8) {
                        Image(systemName: "star.fill")
                        Text(movie.voteAverage.description)
                        Text("(\(movie.voteCount))")
                    }
                    .foregroundStyle(.secondary)

                    Text(movie.overview)
                }
                .padding()
            }
        }
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
            Text(message)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button("Reintentar") { Task { await viewModel.retry() } }
                .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(32)
    }

}
