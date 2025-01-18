//
//  DSButtonStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/11/2566 BE.
//

import Foundation

public enum DSButtonStyle {
    case primary
    case secondary
    case ghost
    case ghostDark
}

extension DSButtonStyle {
    func value<T>(primary: T, secondary: T, ghost: T, ghostDark: T) -> T {
        switch self {
        case .primary:
            return primary
        case .secondary:
            return secondary
        case .ghost:
            return ghost
        case .ghostDark:
            return ghostDark
        }
    }
}
