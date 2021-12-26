//
//  MovieOfflineStore.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct MovieStore: MovieOfflineStoreProtocol {
    func getMovies(for searchText: String, success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: - fetch from CoreData in background
    }
    
    func storeMovies(_ movies: [Movie], success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: - store in CoreData in background
    }
}
