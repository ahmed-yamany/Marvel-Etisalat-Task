//
//  SeriesEntity.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation

struct SeriesEntity: Identifiable, Equatable {
    let id: UUID
    let seriesId: Int
    let title: String
    let rate: String
    let year: String
    let imageUrl: String
}
