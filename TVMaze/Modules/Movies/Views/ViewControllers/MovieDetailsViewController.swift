//
//  MovieDetailsViewController.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 25/12/2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: MovieDetailsViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMovieDetails()
    }
    
    // MARK: - Methods
    func showMovieDetails()  {
        guard let viewModel = viewModel, let movie = viewModel.movie else {
            return
        }
        
        if let summary = movie.summary {
            // summary repeated for testing
            summaryLabel.attributedText = (summary + summary + summary + summary + summary).htmlAttributedString
        }
        else {
            summaryLabel.text = "No summary"
        }
        
        // load image (show medium temp until original loaded)
        movie.getMediumImage(success: { [weak self] image in
            DispatchQueue.main.async {
                self?.movieImageView.image = image
                self?.loadOriginalImage()
            }
        }, failure: {  [weak self] in
            self?.loadOriginalImage()
        })
    }
    
    func loadOriginalImage() {
        guard let viewModel = viewModel, let movie = viewModel.movie else {
            return
        }
        
        movie.getOriginalImage(success: { [weak self] image in
            // waiting here is to demonstrate loading of original image
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.movieImageView.image = image
            }
        }, failure: {
            print("failed to download original image for movie: \(movie.name)")
        })
    }
}
