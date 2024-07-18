//
//  MarvelAPIEndPoint.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation
import APIClient

protocol MarvelAPIEndPoint: APIEndPoint {
    var path: String { get }
}

extension MarvelAPIEndPoint {
    var url: String { "\("https://gateway.marvel.com:443/v1/public/")\(path)" }
}
