//
//  SeriesRepository.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation

protocol SeriesRepositoryProtocol {
    func getSeries(at page: Int) async throws -> [SeriesResult]
}

final class SeriesRepository: MarvelAPIClient<SeriesEndPoint, SeriesData>, SeriesRepositoryProtocol {
    
    func getSeries(at page: Int) async throws -> [SeriesResult] {
        try await self.request(SeriesEndPoint(offset: page)).data.asSeriesResults()
    }
}