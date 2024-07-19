//
//  SeriesDetailEndPoint.swift
//  Marvel
//
//  Created by Ahmed Yamany on 19/07/2024.
//

import Foundation

class SeriesDetailEndPoint: MarvelAPIEndPointDecorator {
    
    init(seriesId: Int) {
        super.init(path: "series/\(seriesId)", method: .get)
    }
}
