//
//  MovieResponses.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct MovieListResponse: Decodable {
    let score: Float
    let show: MovieResponse
}

struct MovieResponse: Decodable {
    let id: Int
    let name: String
}
