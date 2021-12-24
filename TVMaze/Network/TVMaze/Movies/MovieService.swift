//
//  MovieOnlineService.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct MovieService: MovieOnlineServiceProtocol {
    func getMovies(success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void) {
        // fetch online using HttpClient
        HttpClient().perform(request: MoviesRequests.getMovies, responseType: [MovieResponse].self, success: { response in
            // mapping
            let movies = response.body?.map {
                Movie(id: $0.id,
                      name: $0.name,
                      url: $0.url,
                      summary: $0.summary,
                      runtime: $0.runtime,
                      premiered: $0.premiered,
                      averageRating: $0.averageRating,
                      mediumImage: $0.mediumImage,
                      originalImage: $0.originalImage)
            }
            
            success(movies ?? [])
        }, failure: { error in
            failure(error)
        })
    }
}
