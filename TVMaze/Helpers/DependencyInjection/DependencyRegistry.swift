//
//  DependencyRegistry.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct DependencyRegistry {
    // MARK: - Properties
    static let `default`: DependencyRegistry = DependencyRegistry()
    
    //MARK: - Private Init
    private init() {
        
    }
    
    func MoviesViewModelInstance() -> MoviesViewModel {
        let instance = MoviesViewModel(movieRepository: MovieRepository(onlineService: MovieService(), offlineStore: MovieStore()))
        
        return instance
    }
}