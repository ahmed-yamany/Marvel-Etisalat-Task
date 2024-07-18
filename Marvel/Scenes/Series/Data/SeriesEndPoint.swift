//
//  SeriesEndPoint.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation
import APIClient

class SeriesEndPoint: MarvelAPIEndPointDecorator {
    init(offset: Int) {
        super.init(path: "series")
        let queries: Parameters = [
            "limit": 15,
            "offset": offset
        ]
        self.updateQueries(with: queries)
    }
}
