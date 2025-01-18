//
//  DSNavBarTheme.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/4/2566 BE.
//

import UIKit

public enum DSNavBarTheme {
    case light
    case dark
}

protocol NavBarThemeAppearance {
    var backgroundColor: UIColor { get }
    var titleColor: UIColor { get }
    var clickableStyle: DSClickableIconBadge.ClickableIconStyle { get }
    var ghostButtonStyle: DSButtonStyle { get }
}

// MARK: - NavBarThemeAppearance
extension DSNavBarTheme: NavBarThemeAppearance {
    var backgroundColor: UIColor {
        switch self {
        case .dark:
            return DSColor.pageDarkBackground
        case .light:
            return DSColor.componentLightBackground
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .dark:
            return DSColor.pageDarkComponentGhostDefault
        case .light:
            return DSColor.pageLightTextDefault
        }
    }
    
    var clickableStyle: DSClickableIconBadge.ClickableIconStyle {
        switch self {
        case .dark:
            return .ghost
        case .light:
            return .normal
        }
    }
    
    var ghostButtonStyle: DSButtonStyle {
        switch self {
        case .light:
            return .ghost
        case .dark:
            return .ghostDark
        }
    }
}
