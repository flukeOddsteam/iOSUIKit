//
//  DSDropdownStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/11/2566 BE.
//

import Foundation

/// Enum DSDropdown style
public enum DSDropdownStyle {
    /// Normal style have 1 title and maximum 2 line
    case normal
    /// Account style have image and bold title and normal text 2 line
    case account
    /// ActionIconValue have title, value, description(optional) and rightIcon
    case actionIconValue
}

extension DSDropdownStyle {
    func value<T>(normal: T, account: T, actionIconValue: T) -> T {
        switch self {
        case .normal:
            return normal
        case .account:
            return account
        case .actionIconValue:
            return actionIconValue
        }
    }
}
