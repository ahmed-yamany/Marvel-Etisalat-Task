//
//  SeriesUseCase.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import Foundation
import UIKit

protocol SeriesUseCaseProtocol {
    func getSeries(contains title: String, at page: Int) async throws -> [SeriesEntity]
    func fetchImage(from urlString: String) async throws -> UIImage
    func getSeriesDetail(by id: Int) async throws -> SeriesDetailEntity?
}

final class SeriesUseCase: SeriesUseCaseProtocol {
    private var seriesDetailCache: [SeriesDetailEntity] = []
    
    let repository: SeriesRepositoryProtocol
    let imageUseCase: ImageUseCaseProtocol
    
    init(repository: SeriesRepositoryProtocol, imageUseCase: ImageUseCaseProtocol) {
        self.repository = repository
        self.imageUseCase = imageUseCase
    }
    
    func getSeries(contains title: String, at page: Int) async throws -> [SeriesEntity] {
        let seriesResults: [SeriesResult] = try await repository.getSeries(at: page)
        var seriesEntities = seriesResults.map { $0.asSeriesEntity() }
            
        if !title.isEmpty {
            seriesEntities = seriesEntities.filter {$0.title.contains(title)}
        }
        
        return seriesEntities
    }
    
    func fetchImage(from urlString: String) async throws -> UIImage {
        try await imageUseCase.fetchImage(from: urlString)
    }
    
    func getSeriesDetail(by id: Int) async throws -> SeriesDetailEntity? {
        if let seriesDetailEntity = seriesDetailCache.first(where: {$0.id == id}) {
            return seriesDetailEntity
        } else {
            return try await repository.getSeriesDetails(id: id)?.asSeriesDetailEntity()
        }
    }
}
