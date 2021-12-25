//
//  MoviesRequests.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

enum MoviesRequests: HttpRequest {
    case getMovies(searchText: String)
    
    var url: String {
        switch self {
            case .getMovies(let searchText):
                return RequestUrls.baseUrl + "shows?q=\(searchText)"
        }
    }
    
    var method: HttpMethod {
        switch self {
            case .getMovies:
                return .get
        }
    }
}
