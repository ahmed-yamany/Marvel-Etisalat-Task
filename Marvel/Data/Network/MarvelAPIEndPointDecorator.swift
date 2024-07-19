//
//  MarvelAPIEndPointDecorator.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation
import APIClient

class MarvelAPIEndPointDecorator: MarvelAPIEndPoint {
    var path: String
    var method: APIHTTPMethod
    var query: Parameters?
    var body: Parameters? = [:]
    var headers: [String: String] = [:]
    
    init(path: String, method: APIHTTPMethod) {
        self.path = path
        self.method = method
        setDefaultHeaders()
        setDefaultQueries()
    }
    
    private func setDefaultHeaders() {
        headers["Content-Type"] = "application/json; charset=utf-8"
        headers["Date"] = Date.now.formatted()
    }
    
    private func setDefaultQueries() {
        let publicKey = "a31e1b00e3eee4171557ff81e27c9558"
        let privateKey = "a0796647e231ef8bef0d088a29d9aca35773e231"
        let timeStamp = String(Date.now.timeIntervalSince1970)
        let hash = String(timeStamp + privateKey + publicKey).toMD5()
        
        query = [
            "ts": timeStamp,
            "apikey": publicKey,
            "hash": hash
        ]
    }
    
    public func updateQueries(with queries: Parameters) {
        queries.forEach { key, value in
            self.query?[key] = value
        }
    }
}
