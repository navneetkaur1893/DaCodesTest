//
//  MoviesListCell.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import UIKit

class MoviesListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: CachedImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    var movieModel: MoviesList! {
        didSet {
            // Set movie information
            movieNameLabel.text = movieModel.title
            
            let dateString = movieModel.releaseDate ?? "-"
            movieDateLabel.text = CommonLogic.changeDateFormat(into: .d_MMM_YYYY, dateString: dateString)
            
            if let rating = movieModel.voteAverage {
                movieRatingLabel.text = "\(rating)"
            } else {
                movieRatingLabel.text = "N/A"
            }
            
            // Set movie thumbnail
            if let poster = movieModel.posterPath {
                let imageURLString = URLBuilder.getImageURL(imageURL: poster)
                imageView.loadImage(urlString: imageURLString)
            } else {
                imageView?.image = UIImage(named: Images.noImage)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setCornerRadius(with: 10)
    }
}
