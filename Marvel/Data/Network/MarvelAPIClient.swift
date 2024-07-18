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
