//
//  SeriesViewController.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import SwiftUI
import AlamofireAPIClient

final class SeriesViewController<ViewModel: SeriesViewModelProtocol>: UIViewController {
    
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
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
        
        Task {
            do {
                print(try await MarvelAPIClient<SeriesEndPoint, SeriesData>().request(SeriesEndPoint()))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
