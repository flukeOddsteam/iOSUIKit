//
//  CollectionExtensions.swift
//  OneAppDesignSystem
//
//  Created by TTB on 11/11/2565 BE.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}
