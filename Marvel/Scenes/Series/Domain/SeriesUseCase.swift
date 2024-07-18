//
//  SeriesUseCase.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import Foundation

protocol SeriesUseCaseProtocol {
    func getSeries() async throws -> [SeriesCollectionViewSection]
}

final class SeriesUseCase: SeriesUseCaseProtocol {
    func getSeries() async throws -> [SeriesCollectionViewSection] {
        [
        ]
    }
}
