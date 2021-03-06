//
//  MovieRepository.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct MovieRepository: MovieRepositoryProtocol {
    let onlineService: MovieOnlineServiceProtocol?
    let offlineStore: MovieOfflineStoreProtocol?
    
    init(onlineService: MovieOnlineServiceProtocol?, offlineStore: MovieOfflineStoreProtocol?) {
        self.onlineService = onlineService
        self.offlineStore = offlineStore
    }
    
    func getMovies(for searchText: String, success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void) {
        // try fetch online, if failed try fetch offline
        onlineService?.getMovies(for: searchText, success: { movies in
            success(movies)
            
            // update offline store if exists
            offlineStore?.storeMovies(movies, success: {
                // TODO: - handle
            }, failure: { error in
                if let error = error {
                    print(error)
                }
                // TODO: - handle
            })
        }, failure: { error in
            // if no offline store exists
            guard let offlineStore = offlineStore else {
                failure(error)
                return
            }
            
            // use offline store if exists
            offlineStore.getMovies(for: searchText, success: { movies in
                success(movies)
            }, failure: { error in
                failure(error)
            })
        })
    }
}
