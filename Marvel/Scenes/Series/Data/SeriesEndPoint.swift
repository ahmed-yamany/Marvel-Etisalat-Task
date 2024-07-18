//
//  SeriesEndPoint.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation
import APIClient

class SeriesEndPoint: MarvelAPIEndPointDecorator {
    init() {
        super.init(path: "series")
    }
}
