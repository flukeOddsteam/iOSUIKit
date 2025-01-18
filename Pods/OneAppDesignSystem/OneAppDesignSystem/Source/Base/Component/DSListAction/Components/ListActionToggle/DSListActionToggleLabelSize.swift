//
//  DSListActionToggleStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/6/2567 BE.
//

import UIKit

/// Enum DSListActionToggle style
public enum DSListActionToggleLabelSize {
    /// Bold style of DSListActionToggle.
    case large
    /// Regular style of DSListActionToggle.
    case small
}

protocol DSListActionToggleAppearance {
    var titleStyle: UIFont? { get }
    var titleColor: UIColor { get }
}

extension DSListActionToggleLabelSize: DSListActionToggleAppearance {
    var titleStyle: UIFont? {
        switch self {
        case .large:
            return DSFont.h3
        case .small:
            return DSFont.labelList
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .large:
            return DSColor.componentLightDefault
        case .small:
            return DSColor.componentLightLabel
        }
    }
}
