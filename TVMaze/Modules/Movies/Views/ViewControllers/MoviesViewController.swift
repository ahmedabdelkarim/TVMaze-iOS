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
    @IBOutlet weak var emptyStateView: UIView!
    
    // MARK: - Properties
    let viewModel = DependencyRegistry.default.MoviesViewModelInstance()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchText = "spider man" // initial search text to show something when loaded
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureMoviesTable()
        moviesTable.refreshControl?.beginRefreshing()
        loadMovies(for: searchText)
    }
    
    // MARK: - Methods
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by movie name"
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func configureMoviesTable() {
        moviesTable.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        // enable pull refresh
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "AccentColor")
        moviesTable.refreshControl = refreshControl
        moviesTable.refreshControl?.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        
        moviesTable.registerCell(ofType: MovieCell.self)
    }
    
    @objc func refreshMovies() {
        loadMovies(for: searchText)
    }
    
    func loadMovies(for searchText: String) {
        viewModel.getMovies(for: searchText, success: { [weak self] movies in
            DispatchQueue.main.async {
                self?.moviesTable.refreshControl?.endRefreshing()
                self?.moviesTable.reloadData()
                
                self?.emptyStateView.isHidden = !movies.isEmpty
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

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // here can handle each change in search text
        // print(searchController.searchBar.text)
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            self.searchText = searchText
            loadMovies(for: searchText)
        }
    }
}
