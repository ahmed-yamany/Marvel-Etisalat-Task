//
//  SeriesViewModel.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import SwiftUI
import Combine
import CompositionalLayoutableSection

@MainActor
protocol SeriesViewModelProtocol: ObservableObject {
    var sectionsPublisher: AnyPublisher<[SeriesCollectionViewSection], Never> { get }
    var paginationOffset: Int { get set }
    
    func viewDidLoad()
}

@MainActor
final class SeriesViewModel: SeriesViewModelProtocol {
    @Published var sections: [SeriesCollectionViewSection] = []
    @Published var paginationOffset: Int = 0 {
        didSet {
            getSeries()
        }
    }
    
    var sectionsPublisher: AnyPublisher<[SeriesCollectionViewSection], Never> { $sections.eraseToAnyPublisher() }
    
    private let coordinator: SeriesCoordinatorProtocol
    private let useCase: SeriesUseCaseProtocol
    
    init(coordinator: SeriesCoordinatorProtocol, useCase: SeriesUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        getSeries()
    }
    
    private func getSeries() {
        Task {
            do {
                let seriesEntities = try await useCase.getSeries(at: paginationOffset)
                let seriesSections = seriesEntities.map { $0.asSeriesCollectionViewSection(delegate: self) }
                sections.append(contentsOf: seriesSections)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension SeriesViewModel: SeriesCollectionViewSectionDelegate {
    func seriesCollectionViewSection(_ section: SeriesCollectionViewSection, didDisplaySectionAt index: Int) {
        let willDisplayLast5Series: Bool = index == sections.count - 5
        if willDisplayLast5Series {
            paginationOffset += 1
        }
        
        fetchUpdateImage(for: section)
    }
    
    // prepare for prefetching
    func seriesCollectionViewSectionPrefetchItems(_ section: SeriesCollectionViewSection) {
        fetchUpdateImage(for: section)
    }
    
    private func fetchUpdateImage(for section: SeriesCollectionViewSection) {
        Task {
            do {
                // by the way all series image is not available
                let image = try await useCase.fetchImage(from: section.entity.imageUrl)
                section.updateThumbnail(with: image)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
