//
//  MoviesRequests.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

enum MoviesRequests: HttpRequest {
    case getMovies
    
    var url: String {
        switch self {
            case .getMovies:
                return RequestUrls.baseUrl + "shows?q=spider"
        }
    }
    
    var method: HttpMethod {
        switch self {
            case .getMovies:
                return .get
        }
    }
}
