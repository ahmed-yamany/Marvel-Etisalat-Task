//
//  SeriesViewController.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import SwiftUI
import Combine

final class SeriesViewController: UIViewController {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    var loaderCancellable: Cancellable?
    
    let viewModel: any SeriesViewModelProtocol
    
    init(viewModel: any SeriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.marvel
        view = SeriesView(viewModel: viewModel)
        viewModel.viewDidLoad()
        addSearchBar()
        bindLoaderState()
    }
    
    private func addSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
    }
    
    private func bindLoaderState() {
        loaderCancellable = viewModel.loaderState.sink { [weak self] loading in
            guard let self else { return }
            if loading {
                startLoading()
            } else {
                stopLoading()
            }
        }
    }
    
    private func startLoading() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        activityIndicator.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}

extension SeriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}
