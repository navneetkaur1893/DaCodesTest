//
//  MoviesListViewController.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/8/20.
//

import UIKit

class MoviesListViewController: BaseController {
    
    // MARK: Properties
    lazy var viewModel: MoviesListViewModel = MoviesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Method calling.
        customizeUI()
        setupViewModel()
        viewModel.fetchMoviewList()
    }
    
    private func customizeUI() {
        self.title = ScreenTitle.Peliculas
        isRefresh = true
        view.addSubview(collectionView)
        self.collectionView.register(UINib(nibName: Cells.MoviesListCell, bundle: nil), forCellWithReuseIdentifier: Cells.MoviesListCell)
    }
    
    // MARK: Private methods
    //This method setups all the blocks to update value.
    /**
     All blocks provides values to perform next task accordingly
     
     # Available options
     - updateState (It provides the state of the response like loading, empty, success and error)
     */
    private func setupViewModel() {
        viewModel.updateState = { [weak self] (state) in
            DispatchQueue.main.async {
                self?.state = state
                
                switch state {
                case .loading:
                    DispatchQueue.main.async {
                        self?.showLoadingView()
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.refreshController.endRefreshing()
                        self?.removeLoadingView()
                        self?.collectionView.reloadData()
                    }
                case .error:
                    DispatchQueue.main.async {
                        self?.refreshController.endRefreshing()
                        self?.collectionView.reloadData()
                        self?.showErrorView()
                    }
                default:
                    return
                }
            }
        }
    }
    
    override func refresh() {
        viewModel.fetchMoviewList(pageId: 1)
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailsVC = segue.destination as? MovieDetailsViewController {
            movieDetailsVC.viewModel.movieId = viewModel.getSelectedMovieId()
        }
     }
}

// MARK: UICollectionViewDelegate
extension MoviesListViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.setSelectedMovieId(of: indexPath)
        self.performSegue(withIdentifier: SegueId.movieDetailsVC, sender: nil)
    }
}

// MARK: UICollectionViewDataSource
extension MoviesListViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.MoviesListCell, for: indexPath) as? MoviesListCell else { return UICollectionViewCell() }
        cell.movieModel = viewModel.getMovie(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        viewModel.checkForNextServiceCall(indexPath: indexPath)
    }
}

extension MoviesListViewController {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.view.frame.size.height / 2.5) - 25
        let width = (self.view.frame.size.width / 2) - 10
        return CGSize(width: width, height: height)
    }
}
