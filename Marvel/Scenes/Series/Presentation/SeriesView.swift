//
//  SeriesView.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import UIKit
import CompositionalLayoutableSection
import Combine

class SeriesView<ViewModel: SeriesViewModelProtocol>: UICollectionView, CompositionalLayoutProvider {
    
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    lazy var compositionalDelegate = CompositionalLayoutDelegate(provider: self)
    lazy var compositionalDataSource = CompositionalLayoutDataSource(provider: self)
    lazy var compositionalPrefetchDataSource = CompositionalLayoutDataSourcePrefetching(provider: self)
    
    var sectionsCancellable: Cancellable!
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, collectionViewLayout: .init())
        
        delegate = compositionalDelegate
        dataSource = compositionalDataSource
        prefetchDataSource = compositionalPrefetchDataSource
        sinkOnSections()
        updateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sinkOnSections() {
        sectionsCancellable = viewModel.sectionsPublisher.sink {[weak self] sections in
            guard let self = self else { return }
            self.compositionalLayoutSections = sections
            self.updateCompositionalLayout(for: self)
        }
    }
    
    private func updateView() {
        backgroundColor = .mlBackground
    }
}
