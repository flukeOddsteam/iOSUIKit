//
//  DSFilterPillState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 19/4/2566 BE.
//

import UIKit

public enum DSFilterPillState {
    case `default`
    case active
    case disable
}

protocol FilterPillStateAppearance {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
}

// MARK: - FilterPillStateAppearance
extension DSFilterPillState: FilterPillStateAppearance {
    var backgroundColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightBackground
        case .active:
            return DSColor.componentDarkBackground
        case .disable:
            return DSColor.componentDisableBackground
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightLabel
        case .active:
            return DSColor.componentDarkDefault
        case .disable:
            return DSColor.componentDisableDefault
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutline
        case .active:
            return .clear
        case .disable:
            return DSColor.componentDisableOutline

        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .active:
            return .zero
        case .default, .disable:
            return 1
        }
    }
}
