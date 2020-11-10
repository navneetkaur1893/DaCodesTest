//
//  LoadingView.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func startAnimation() {
        activityIndicator.startAnimating()
    }
}
