//
//  SeriesResultMapper.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation


protocol SeriesResultMapper {
    func asSeriesResults() -> [SeriesResult]
}

extension SeriesData: SeriesResultMapper {
    func asSeriesResults() -> [SeriesResult] {
        self.results
    }
}
