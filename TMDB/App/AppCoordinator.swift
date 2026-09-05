//
//  AppCoordinator.swift
//  TMDB
//
//  Created by Imanol Ortiz on 05/09/2026.
//

import Foundation
import Observation
import SwiftUI

enum TMDBRoute: Hashable {
    case home
    case movieDetail(id: Int)
}

@MainActor
@Observable
class AppCoordinator {
    
    var homePath = NavigationPath()
    
    func showAssetDetail(movieID: Int) {
        homePath.append(TMDBRoute.movieDetail(id: movieID))
    }
    
}
