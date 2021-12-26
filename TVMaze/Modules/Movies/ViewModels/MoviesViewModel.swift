//
//  MoviesViewModel.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

class MoviesViewModel {
    // MARK: - Properties
    let movieRepository: MovieRepositoryProtocol?
    private(set) var movies = [Movie]()
    
    // MARK: - Init
    init(movieRepository: MovieRepositoryProtocol?) {
        self.movieRepository = movieRepository
    }
    
    // MARK: - Methods
    func getMovies(for searchText: String, success: @escaping ([Movie]) -> Void, failure: @escaping (Error?) -> Void) {
        movieRepository?.getMovies(for: searchText, success: { movies in
            self.movies = movies
            success(movies)
        }, failure: { error in
            failure(error)
        })
    }
    
    func clearMovies(done: () -> Void) {
        self.movies = []
        done()
    }
}
