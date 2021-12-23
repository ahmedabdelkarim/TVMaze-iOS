//
//  MovieOfflineStoreProtocol.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

protocol MovieOfflineStoreProtocol {
    func getMovies(success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void)
    func updateMovies(with movies: [Movie], success: @escaping () -> Void, failure: @escaping (Error?) -> Void)
}
