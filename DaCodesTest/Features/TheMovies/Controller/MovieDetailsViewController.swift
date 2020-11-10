//
//  MovieDetailsViewController.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import UIKit

class MovieDetailsViewController: BaseController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    lazy var viewModel: MovieDetailsViewModel = MovieDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Method calling.
        customizeUI()
        setupViewModel()
        viewModel.fetchMovieDetails()
    }
    
    private func customizeUI() {
        self.tableView.tableFooterView = UIView()
    }
    
    override func refresh() {
        viewModel.fetchMovieDetails()
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
                //self?.state = state
                
                switch state {
                case .loading:
                    DispatchQueue.main.async {
                        self?.showLoadingView()
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.refreshController.endRefreshing()
                        self?.removeLoadingView()
                        self?.tableView.reloadData()
                    }
                case .error:
                    DispatchQueue.main.async {
                        self?.refreshController.endRefreshing()
                        self?.tableView.reloadData()
                        self?.showErrorView()
                    }
                default:
                    return
                }
            }
        }
    }
}

// MARK: - Table view data source
extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.MoviePosterCell, for: indexPath) as? MoviePosterCell else { return UITableViewCell() }
            
            // Configure the cell...
            cell.posterImage = viewModel.movieDetails?.posterPath
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.MovieDetailsCell, for: indexPath) as? MovieDetailsCell else { return UITableViewCell() }
            
            // Configure the cell...
            cell.titleLabel.text = viewModel.getTitle(at: indexPath)
            cell.valueLabel.text = viewModel.getValue(at: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let height: CGFloat = 80.0
        let width: CGFloat = self.tableView.frame.width
        let title = viewModel.getHeaderTitle()
        return CommonLogic.returnHeaderView(height, width, title)
    }
}
