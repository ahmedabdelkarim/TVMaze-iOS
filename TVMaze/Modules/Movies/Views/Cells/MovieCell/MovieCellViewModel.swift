//
//  MovieCellViewModel.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 25/12/2021.
//

import Foundation

class MovieCellViewModel {
    // MARK: - Properties
    private(set) var movie: Movie!
    
    // MARK: - Init
    init(movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Methods
    func openMovieLink() {
        Actions.openLink(self.movie.url)
    }
}
