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
    
    func getMovies(success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: - fetch online, if failed fetch offline
    }
}
