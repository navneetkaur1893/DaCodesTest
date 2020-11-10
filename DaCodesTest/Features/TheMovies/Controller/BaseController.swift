//
//  BaseController.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import UIKit

enum CollectionState: String {
    case loading
    case error
    case success
    case validation
    case noConnection
    case empty
}

class BaseController: UIViewController, UICollectionViewDelegate {
    
    var isRefresh: Bool = true
    var state: CollectionState = .success
    var globalErrorView: ErrorView?
    var globalLoadingView: UIView?
    
    lazy var collectionView: UICollectionView = {
        var collectionView: UICollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        if self.isRefresh {
            collectionView.addSubview(self.refreshController)
        }
        return collectionView
    }()
    
    lazy var refreshController: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return controller
    }()
    
    @objc func refresh() {}
    
    private func showLoading() {
        globalErrorView?.removeFromSuperview()
        if let loadingView = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as? LoadingView {
            self.globalLoadingView = loadingView
            view.addSubview(loadingView)
            loadingView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 80)
            loadingView.startAnimation()
        }
    }
    private func showError() {
        globalLoadingView?.removeFromSuperview()
        if let errorView = Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)?.first as? ErrorView {
            self.globalErrorView = errorView
            self.globalErrorView?.delegate = self
            view.addSubview(errorView)
            errorView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 120)
        }
    }
    
    // Methods can be call by inherited controller.
    func showLoadingView() {
        showLoading()
    }
    
    func removeLoadingView() {
        globalLoadingView?.removeFromSuperview()
    }
    
    func showErrorView() {
        showError()
    }
    
    func removeErrorView() {
        globalErrorView?.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: UICollectionViewDataSource
extension BaseController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension BaseController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}


extension BaseController: ErrorViewDelegate {
    func didTappedErrorViewRefreshButton() {
        refresh()
    }
}
