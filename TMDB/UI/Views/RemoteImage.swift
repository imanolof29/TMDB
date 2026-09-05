//
//  RemoteImage.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import SwiftUI

struct RemoteImage: View {
    
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable().aspectRatio(contentMode: .fit)
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

