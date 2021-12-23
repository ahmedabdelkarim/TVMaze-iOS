//
//  MovieOfflineStore.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct MovieStore: MovieOfflineStoreProtocol {
    func getMovies(success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: - fetch offline from CoreData
    }
    
    func updateMovies(with movies: [Movie], success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: - update offline in CoreData
    }
}
