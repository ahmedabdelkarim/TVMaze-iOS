//
//  MovieRepositoryProtocol.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

protocol MovieRepositoryProtocol {
    init(onlineService: MovieOnlineServiceProtocol?, offlineStore: MovieOfflineStoreProtocol?)
    
    func getMovies(success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void)
}
