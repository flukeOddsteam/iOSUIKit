//
//  DSLazyLoadingStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/3/2566 BE.
//

import UIKit

public enum DSLazyLoadingStyle {
    case light
    case dark
}

protocol LazyLoadingStyleAppearance {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
}

// MARK: - DSLazyLoadingStyleAppearance
extension DSLazyLoadingStyle: LazyLoadingStyleAppearance {
    var backgroundColor: UIColor {
        switch self {
        case .dark:
            return DSColor.otherBackgroundOverlayScreen
        case .light:
            return DSColor.componentLightBackground
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .dark:
            return DSColor.otherDefault
        case .light:
            return DSColor.componentLightDefault
        }
    }
}
