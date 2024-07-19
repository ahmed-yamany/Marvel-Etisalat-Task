//
//  SeriesRepositoryFactory.swift
//  Marvel
//
//  Created by Ahmed Yamany on 19/07/2024.
//

import Foundation

struct SeriesRepositoryFactory {
    static func make() -> SeriesRepositoryProtocol {
        let seriesClient = SeriesAPIClient()
        let seriesDetailClient = SeriesDetailAPIClient()
        return SeriesRepository(
            seriesApiClient: seriesClient,
            seriesDetailAPIClient: seriesDetailClient
        )
    }
}
