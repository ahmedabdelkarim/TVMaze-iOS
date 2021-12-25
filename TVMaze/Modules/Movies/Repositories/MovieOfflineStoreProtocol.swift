//
//  MovieOfflineStoreProtocol.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

protocol MovieOfflineStoreProtocol {
    func getMovies(for searchText: String, success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void)
    func storeMovies(_ movies: [Movie], success: @escaping () -> Void, failure: @escaping (Error?) -> Void)
}
