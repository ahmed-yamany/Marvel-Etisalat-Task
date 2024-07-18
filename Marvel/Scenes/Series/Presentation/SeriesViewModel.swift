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
        sections = [SeriesCollectionViewSection(), SeriesCollectionViewSection()]
    }

    func viewDidLoad() {
        Task {
            do {
                sections = try await useCase.getSeries()
            } catch {
                
            }
        }
    }
}
