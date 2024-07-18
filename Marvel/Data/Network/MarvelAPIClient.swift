//
//  MarvelAPIClient.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation
import AlamofireAPIClient

struct MarvelAPIError: AlamofireAPIClientError, LocalizedError {
    let code: String
    let message: String
    
    var errorDescription: String? {
        message
    }
}

class MarvelAPIClient<
    EndpointType: MarvelAPIEndPoint,
    ResponseType: Codable
>: AlamofireAPIClient<EndpointType, MarvelAPIReponse<ResponseType>, MarvelAPIError> {}


struct MarvelAPIReponse<ResponseData: Codable>: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: ResponseData?
}
