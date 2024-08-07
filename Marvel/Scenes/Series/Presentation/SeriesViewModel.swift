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
    var searchText: String { get set }
    var loaderState: CurrentValueSubject<Bool, Never> { get }
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
    @Published var searchText: String = ""
    var sectionsPublisher: AnyPublisher<[SeriesCollectionViewSection], Never> { $sections.eraseToAnyPublisher() }
    var loaderState: CurrentValueSubject<Bool, Never> = .init(false)
    
    private var lastGetSeriesTask: Task<(), Never>?
    private var lastSeriesDetailTask: Task<(), Never>?
    private var searchTextCancellable: Cancellable?
    private let coordinator: SeriesCoordinatorProtocol
    private let useCase: SeriesUseCaseProtocol
    
    init(coordinator: SeriesCoordinatorProtocol, useCase: SeriesUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        sinkOnSearchText()
    }
    
    private func getSeries() {
        lastGetSeriesTask?.cancel()
        loaderState.send(true)
        lastGetSeriesTask = Task {
            do {
                let seriesEntities = try await useCase.getSeries(contains: searchText, at: paginationOffset)
                let seriesSections = seriesEntities.map { $0.asSeriesCollectionViewSection(delegate: self) }
                sections.append(contentsOf: seriesSections)
            } catch {
                print(error.localizedDescription)
            }
            loaderState.send(false)
        }
    }
    
    private func sinkOnSearchText() {
        searchTextCancellable = $searchText
            .debounce(for: 1.5, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else {
                    Logger.log("\(self.debugDescription) deallocated", category: \.default, level: .info)
                    return
                }
                paginationOffset = 0
                sections.removeAll()
                getSeries()
            }
    }
}

extension SeriesViewModel: SeriesCollectionViewSectionDelegate {
    func seriesCollectionViewSection(_ section: SeriesCollectionViewSection, didDisplaySectionAt index: Int) {
        let willDisplayLast5Series: Bool = index == sections.count - 5
        if willDisplayLast5Series {
            paginationOffset += 1
        }
        
        fetchImage(for: section)
    }
    
    func seriesCollectionViewSectionPrepareForPrefetching(_ section: SeriesCollectionViewSection) {
        fetchImage(for: section)
    }
    
    func seriesCollectionViewSection(_ section: SeriesCollectionViewSection, didExpandSeriesDetailsAt index: Int) {
        let seriesId = section.entity.seriesId
        lastGetSeriesTask?.cancel()
        lastSeriesDetailTask = Task {
            do {
                let detailEntity = try await useCase.getSeriesDetail(by: seriesId)
                section.updateDetails(with: detailEntity)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchImage(for section: SeriesCollectionViewSection) {
        Task {
            do {
                let image = try await useCase.fetchImage(from: section.entity.imageUrl)
                section.updateThumbnail(with: image)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
