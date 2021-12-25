//
//  MovieCell.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 25/12/2021.
//

import UIKit

class MovieCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var premieredLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    // MARK: - Properties
    private(set) var viewModel: MovieCellViewModel?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // set cell inner spacing
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    // MARK: - Methods
    func setup(viewModel: MovieCellViewModel) {
        self.viewModel = viewModel
        
        guard let movie = viewModel.movie else {
            return
        }
        
        // display name
        nameLabel.text = movie.name
        
        // display rating
        if let rating = movie.averageRating {
            ratingLabel.text = "\(rating)"
            ratingView.isHidden = false
        }
        else {
            ratingView.isHidden = true
        }
        
        // display premiered
        premieredLabel.text = movie.premiered
        
        // display runtime
        if let runtime = movie.runtime {
            runtimeLabel.text = "\(runtime)"
        }
        else {
            runtimeLabel.text = "n/a"
        }
        
        // load image
        movieImageView.image = nil
        movie.getMediumImage(success: { [weak self] image in
            DispatchQueue.main.async {
                self?.movieImageView.image = image
            }
        }, failure: {
            print("failed to download medium image for movie: \(movie.name)")
        })
    }
    
    // MARK: - Private Methods
    
    // MARK: - Actions
    @IBAction func linkButtonTapped(_ sender: Any) {
        viewModel?.openMovieLink()
    }
}
