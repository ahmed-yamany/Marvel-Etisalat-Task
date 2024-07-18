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
    
    func viewDidLoad()
}

@MainActor
final class SeriesViewModel: SeriesViewModelProtocol {
    @Published var sections: [SeriesCollectionViewSection] = []
    var sectionsPublisher: AnyPublisher<[SeriesCollectionViewSection], Never> { $sections.eraseToAnyPublisher() }
    
    private let coordinator: SeriesCoordinatorProtocol
    private let useCase: SeriesUseCaseProtocol
    
    init(coordinator: SeriesCoordinatorProtocol, useCase: SeriesUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func viewDidLoad() {
        Task {
            do {
                let seriesEntities = try await useCase.getSeries()
                let seriesSections = seriesEntities.map { $0.asSeriesCollectionViewSection(delegate: self) }
                sections = seriesSections
            } catch {
                
            }
        }
    }
}

extension SeriesViewModel: SeriesCollectionViewSectionDelegate {
    func seriesCollectionViewSection(_ section: SeriesCollectionViewSection, didDisplaySectionAt index: Int) {
        if index == sections.count - 5 {
            print(index)
        }
    }
}
