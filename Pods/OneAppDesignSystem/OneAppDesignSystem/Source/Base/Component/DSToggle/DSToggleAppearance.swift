//
//  DSToggleAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/12/22.
//

import UIKit

protocol DSToggleAppearance {
    var backgroundColor: UIColor { get }
    var isUserInteractonEnabled: Bool { get }
    var leftConstaintPriority: UILayoutPriority { get }
    var rightConstaintPriority: UILayoutPriority { get }
}

extension DSToggleState: DSToggleAppearance {
    var backgroundColor: UIColor {
        switch self {
        case .onActive:
            return DSColor.componentToggleBackgroundActive
        case .offActive:
            return DSColor.componentToggleBackgroundDefault
        case .onDisable, .offDisable:
            return DSColor.componentToggleBackgroundDisable
        }
    }
    
    var isUserInteractonEnabled: Bool {
        switch self {
        case .onActive, .offActive:
            return true
        case .onDisable, .offDisable:
            return false
        }
    }
    
    var leftConstaintPriority: UILayoutPriority {
        switch self {
        case .onActive, .onDisable:
            return .defaultLow
        case .offActive, .offDisable:
            return .defaultHigh
        }
    }
    
    var rightConstaintPriority: UILayoutPriority {
        switch self {
        case .onActive, .onDisable:
            return .defaultHigh
        case .offActive, .offDisable:
            return .defaultLow
        }
    }
}
