//
//  SeriesUseCase.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import Foundation
import UIKit

protocol SeriesUseCaseProtocol {
    func getSeries(at page: Int) async throws -> [SeriesEntity]
    func fetchImage(from urlString: String) async throws -> UIImage
}

final class SeriesUseCase: SeriesUseCaseProtocol {
    let repository: SeriesRepositoryProtocol
    let imageUseCase: ImageUseCaseProtocol
    
    init(repository: SeriesRepositoryProtocol, imageUseCase: ImageUseCaseProtocol) {
        self.repository = repository
        self.imageUseCase = imageUseCase
    }
    
    func getSeries(at page: Int) async throws -> [SeriesEntity] {
        let seriesResults: [SeriesResult] = try await repository.getSeries(at: page)
        let seriesEntities: [SeriesEntity] = seriesResults.map { $0.asSeriesEntity() }
        return seriesEntities
    }
    
    func fetchImage(from urlString: String) async throws -> UIImage {
        try await imageUseCase.fetchImage(from: urlString)
    }
}
