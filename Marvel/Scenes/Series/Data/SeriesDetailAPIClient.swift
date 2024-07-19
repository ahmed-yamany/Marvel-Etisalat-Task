//
//  SeriesDetailAPIClient.swift
//  Marvel
//
//  Created by Ahmed Yamany on 19/07/2024.
//

import Foundation

protocol SeriesDetailAPIClientProtocol {
    func getSeriesDetails(id: Int) async throws -> SeriesResult?
}

class SeriesDetailAPIClient: MarvelAPIClient<SeriesDetailEndPoint, SeriesData>, SeriesDetailAPIClientProtocol {
    func getSeriesDetails(id: Int) async throws -> SeriesResult? {
        try await self.request(SeriesDetailEndPoint(seriesId: id)).data.results.first
    }
}
