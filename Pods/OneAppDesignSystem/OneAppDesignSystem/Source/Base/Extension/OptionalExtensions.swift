//
//  OptionalExtensions.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import Foundation

extension Optional {
    
    var isNull: Bool {
        self == nil
    }
    
    var isNotNull: Bool {
        self != nil
    }
}

extension Optional where Wrapped == String {
    var unwrapped: String {
        self ?? ""
    }

    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }

    var isNotNilAndNotEmpty: Bool {
        guard let self = self else { return false }
        return self.isNotEmpty
    }

    func idConcatenation(_ row: String) -> String {
        guard let self, self.isNotEmpty else { return "" }
        return self + "_" + row
    }
}

extension Optional where Wrapped == [Any] {
    var unwrapped: [Any] {
        return self ?? []
    }
}

extension Optional where Wrapped == Bool {
    var trueIfNil: Bool {
        return self ?? true
    }
    
    var falseIfNil: Bool {
        return self ?? false
    }
}
