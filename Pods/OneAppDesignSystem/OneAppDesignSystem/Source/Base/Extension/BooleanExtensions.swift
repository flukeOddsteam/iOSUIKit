//
//  BooleanExtensions.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 6/2/2566 BE.
//

import Foundation

extension Bool {
    var revert: Bool {
        return !self
    }
    
    var isFalse: Bool {
        return self == false
    }
    
    var isTrue: Bool {
        return self == true
    }
}
