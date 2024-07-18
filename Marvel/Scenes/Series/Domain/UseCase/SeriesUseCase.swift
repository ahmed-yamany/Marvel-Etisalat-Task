//
//  SeriesUseCase.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import Foundation

protocol SeriesUseCaseProtocol {
    func getSeries() async throws -> [SeriesEntity]
}

final class SeriesUseCase: SeriesUseCaseProtocol {
    let repository: SeriesRepositoryProtocol
    
    init(repository: SeriesRepositoryProtocol) {
        self.repository = repository
    }
    
    func getSeries() async throws -> [SeriesEntity] {
        let seriesResults = try await repository.getSeries()
        let seriesEntities = seriesResults.map { $0.asSeriesEntity() }
        return seriesEntities
    }
}
