//
//  MovieOnlineServiceProtocol.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

protocol MovieOnlineServiceProtocol {
    func getMovies(success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void)
}
