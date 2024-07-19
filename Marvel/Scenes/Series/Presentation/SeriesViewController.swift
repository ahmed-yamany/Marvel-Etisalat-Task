//
//  SeriesViewController.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import SwiftUI
import AlamofireAPIClient

final class SeriesViewController: UIViewController {
    
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
        view = SeriesView(viewModel: viewModel)
        viewModel.viewDidLoad()
        addSearchBar()
    }
    
    private func addSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
    }
}

extension SeriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}
