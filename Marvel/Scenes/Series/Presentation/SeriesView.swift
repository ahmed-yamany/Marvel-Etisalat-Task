//
//  SeriesView.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import UIKit
import CompositionalLayoutableSection
import Combine

class SeriesView: UIView, CompositionalLayoutProvider {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    lazy var compositionalDelegate = CompositionalLayoutDelegate(provider: self)
    lazy var compositionalDataSource = CompositionalLayoutDataSource(provider: self)
    lazy var compositionalPrefetchDataSource = CompositionalLayoutDataSourcePrefetching(provider: self)
    
    var sectionsCancellable: Cancellable!
    let viewModel: any SeriesViewModelProtocol
    
    init(viewModel: any SeriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        addSubview(collectionView)
        collectionView.delegate = compositionalDelegate
        collectionView.dataSource = compositionalDataSource
        collectionView.prefetchDataSource = compositionalPrefetchDataSource
        sinkOnSections()
        updateView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sinkOnSections() {
        sectionsCancellable = viewModel.sectionsPublisher.sink {[weak self] sections in
            guard let self else { return }
            compositionalLayoutSections = sections
            updateCompositionalLayout(for: collectionView)
        }
    }
    
    private func updateView() {
        backgroundColor = .mlBackground
        collectionView.backgroundColor = .mlBackground
    }
}
