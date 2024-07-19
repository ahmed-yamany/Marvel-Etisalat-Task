//
//  SeriesRepository.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation

protocol SeriesRepositoryProtocol {
    func getSeries(at page: Int) async throws -> [SeriesResult]
    func getSeriesDetails(id: Int) async throws -> SeriesResult?
}

final class SeriesRepository: SeriesRepositoryProtocol {
    let seriesApiClient: SeriesAPIClientProtocol
    let seriesDetailAPIClient: SeriesDetailAPIClientProtocol
    
    init(
        seriesApiClient: SeriesAPIClientProtocol,
        seriesDetailAPIClient: SeriesDetailAPIClientProtocol
    ) {
        self.seriesApiClient = seriesApiClient
        self.seriesDetailAPIClient = seriesDetailAPIClient
    }
    
    func getSeries( at page: Int) async throws -> [SeriesResult] {
        try await seriesApiClient.getSeries(at: page)
    }
    
    func getSeriesDetails(id: Int) async throws -> SeriesResult? {
        try await seriesDetailAPIClient.getSeriesDetails(id: id)
    }
}
