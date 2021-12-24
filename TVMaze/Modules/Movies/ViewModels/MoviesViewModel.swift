//
//  MoviesViewModel.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct MoviesViewModel {
    //MARK: - Properties
    let movieRepository: MovieRepositoryProtocol
    private(set) var movies = [Movie]()
    
    //MARK: - Methods
    func getMovies(success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void) {
        movieRepository.getMovies(success: { movies in
            success(movies)
        }, failure: { error in
            failure(error)
        })
    }
    
}
