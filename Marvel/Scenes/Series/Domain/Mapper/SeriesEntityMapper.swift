//
//  SeriesEntityMapper.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation

protocol SeriesEntityMapper {
    func asSeriesEntity() -> SeriesEntity
}

extension SeriesResult: SeriesEntityMapper {
    func asSeriesEntity() -> SeriesEntity {
        let id: UUID = UUID(uuidString: String(self.id ?? UUID().hashValue)) ?? UUID()
        let title: String = self.title ?? ""
        let rate: String = self.rating?.rawValue ?? ""
        let year: String = String(endYear ?? startYear ?? 0)
        return SeriesEntity(
            id: id,
            title: title,
            rate: rate,
            year: year
        )
    }
}
