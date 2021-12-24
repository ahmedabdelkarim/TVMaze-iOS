//
//  MovieOnlineService.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct MovieService: MovieOnlineServiceProtocol {
    func getMovies(success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: - fetch online using ApiClient
        HttpClient().perform(request: MoviesRequests.getMovies, responseType: [MovieListResponse].self, success: { response in
            // mapping
            let movies = response.body?.map {
                Movie(name: $0.show.name)
            }
            
            success(movies ?? [])
        }, failure: { error in
            failure(error)
        })
    }
}
