//
//  SeriesDetailEntityMapper.swift
//  Marvel
//
//  Created by Ahmed Yamany on 19/07/2024.
//

import Foundation

protocol SeriesDetailEntityMapper {
    func asSeriesDetailEntity() -> SeriesDetailEntity
}

extension SeriesResult: SeriesDetailEntityMapper {
    func asSeriesDetailEntity() -> SeriesDetailEntity {
        let id = self.id ?? UUID().hashValue
        return SeriesDetailEntity(
            id: id,
            description: description ?? ""
        )
    }
}
