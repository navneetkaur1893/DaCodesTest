//
//  ErrorView.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import UIKit

protocol ErrorViewDelegate: class {
    func didTappedErrorViewRefreshButton()
}

class ErrorView: UIView {
    
    @IBOutlet weak var titleButton: UIButton!
    
    weak var delegate: ErrorViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func tappedErroButton(_ sender: Any) {
        delegate?.didTappedErrorViewRefreshButton()
    }
    
    func configureWith(name: String) {
        titleButton.setTitle(name, for: .normal)
    }
}

