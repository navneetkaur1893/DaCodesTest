//
//  MoviePosterCell.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import UIKit

class MoviePosterCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: CachedImageView!
    
    var posterImage: String? {
        didSet {
            // Set movie thumbnail
            if let poster = posterImage {
                let imageURLString = URLBuilder.getImageURL(imageURL: poster)
                posterImageView.loadImage(urlString: imageURLString)
            } else {
                posterImageView.image = UIImage(named: Images.noImage)
            }
        }
    }
}
