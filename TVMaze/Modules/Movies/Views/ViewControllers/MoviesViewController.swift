//
//  MoviesViewController.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import UIKit

class MoviesViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var moviesTable: UITableView!
    
    // MARK: - Properties
    let viewModel = DependencyRegistry.default.MoviesViewModelInstance()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMoviesTable()
        moviesTable.refreshControl?.beginRefreshing()
        loadMovies()
    }
    
    // MARK: - Methods
    func configureMoviesTable() {
        moviesTable.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        //enable pull refresh
        moviesTable.refreshControl = UIRefreshControl()
        moviesTable.refreshControl?.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        
        moviesTable.registerCell(ofType: MovieCell.self)
    }
    
    @objc func refreshMovies() {
        loadMovies()
    }
    
    func loadMovies() {
        viewModel.getMovies(success: { [weak self] movies in
            DispatchQueue.main.async {
                self?.moviesTable.refreshControl?.endRefreshing()
                self?.moviesTable.reloadData()
            }
        }, failure: { error in
            if let error = error {
                print(error)
            }
            else {
                print("unknown error while loading movies")
            }
        })
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTable.dequeueCell() as MovieCell
        
        let movieCellViewModel = MovieCellViewModel(movie: viewModel.movies[indexPath.row])
        cell.setup(viewModel: movieCellViewModel)
        
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showMovieDetails", sender: self)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailsViewController {
            if let selectedIndex = moviesTable.indexPathForSelectedRow, viewModel.movies.count > selectedIndex.row {
                vc.viewModel = MovieDetailsViewModel(movie: viewModel.movies[selectedIndex.row])
                
                moviesTable.deselectRow(at: selectedIndex, animated: true)
            }
        }
        else {
            print("Couldn't open movie details")
            // TODO: - Handle
        }
    }
}
