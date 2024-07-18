//
//  SeriesCollectionViewSectionMapper.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation

@MainActor
protocol SeriesCollectionViewSectionMapper {
    func asSeriesCollectionViewSection(delegate: SeriesCollectionViewSectionDelegate) -> SeriesCollectionViewSection
}

extension SeriesEntity: SeriesCollectionViewSectionMapper {
    func asSeriesCollectionViewSection(delegate: SeriesCollectionViewSectionDelegate) -> SeriesCollectionViewSection {
        SeriesCollectionViewSection(entity: self, seriesDelegate: delegate)
    }
}
