//
//  String+toMD5.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation
import CryptoKit

extension String {
    func toMD5() -> Self {
        let data: Data = data(using: .utf8) ?? .init()
        let hash: Insecure.MD5.Digest = Insecure.MD5.hash(data: data)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
