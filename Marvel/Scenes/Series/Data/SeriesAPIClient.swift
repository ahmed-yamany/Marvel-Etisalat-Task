//
//  SeriesAPIClient.swift
//  Marvel
//
//  Created by Ahmed Yamany on 19/07/2024.
//

import Foundation

protocol SeriesAPIClientProtocol {
    func getSeries(at page: Int) async throws -> [SeriesResult]
}

class SeriesAPIClient: MarvelAPIClient<SeriesEndPoint, SeriesData>, SeriesAPIClientProtocol {
    func getSeries(at page: Int) async throws -> [SeriesResult] {
        try await self.request(SeriesEndPoint(offset: page)).data.asSeriesResults()
    }
}
