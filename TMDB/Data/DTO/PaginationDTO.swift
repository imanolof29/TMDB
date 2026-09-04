//
//  PaginationDTO.swift
//  TMDB
//
//  Created by Imanol Ortiz on 04/09/2026.
//

import Foundation

struct PaginationDTO<T: Decodable>: Decodable, Sendable {
    let results: T
    let page: Int
}
