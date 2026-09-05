//
//  MovieCardView.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import SwiftUI

struct MovieCardView: View {
    
    let movie: Movie
    
    var body: some View {
        HStack {
            if movie.backdropURL != nil {
                AsyncImage(url: movie.backdropURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .frame(width: 100, height: 150)
                    case .failure:
                        EmptyView()
                    }
                }
            }
            VStack(alignment: .leading){
                Text(movie.title)
                HStack(spacing: 8){
                    Image(systemName: "star.fill")
                    Text(movie.voteAverage.description)
                    Text(movie.voteCount.description)
                }
                Spacer()
                
            }
        }
    }
}
