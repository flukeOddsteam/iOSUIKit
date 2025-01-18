//
//  DSCheckboxListMessageExpandableState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/4/2566 BE.
//

import UIKit

public enum DSCheckboxListMessageExpandableState {
    case expand
    case collapse
    
    mutating func switched() {
        self = self == .collapse ? .expand : .collapse
    }
}
