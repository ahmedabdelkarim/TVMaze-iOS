//
//  MoviesViewController.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import UIKit

class MoviesViewController: UIViewController {
    // MARK: - Outlets
    
    
    // MARK: - Properties
    let viewModel = DependencyRegistry.default.MoviesViewModelInstance()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovies()
    }
    
    // MARK: - Methods
    func loadMovies() {
        viewModel.getMovies(success: { movies in
            print(movies)
        }, failure: { error in
            print(error)
        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
