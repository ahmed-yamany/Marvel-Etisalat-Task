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
        
        var imageUrl: String = ""
        if let thumbnail,
           let path = thumbnail.path,
           let imageExtension = thumbnail.thumbnailExtension {
            imageUrl = "\(path).\(imageExtension)"
        }
        
        return SeriesEntity(
            id: id,
            seriesId: self.id ?? UUID().hashValue,
            title: title,
            rate: rate,
            year: year,
            imageUrl: imageUrl
        )
    }
}
