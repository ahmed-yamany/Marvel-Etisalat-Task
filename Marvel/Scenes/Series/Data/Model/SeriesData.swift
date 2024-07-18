//
//  SeriesData.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation

struct SeriesData: Codable {
    let offset, limit, total, count: Int
    let results: [SeriesResult]
}
