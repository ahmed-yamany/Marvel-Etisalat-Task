//
//  Array+replaceOrAppend.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation

extension Array {
    mutating func replaceOrAppend(_ item: Element, by keyPath: KeyPath<Element, some Equatable>) {
        if let index = firstIndex(where: { $0[keyPath: keyPath] == item[keyPath: keyPath]}) {
            self[index] = item
        } else {
            self.append(item)
        }
    }
    
    mutating func replaceOrAppend(contentsOf items: [Element], by keyPath: KeyPath<Element, some Equatable>) {
        for item in items {
            self.replaceOrAppend(item, by: keyPath)
        }
    }
}
