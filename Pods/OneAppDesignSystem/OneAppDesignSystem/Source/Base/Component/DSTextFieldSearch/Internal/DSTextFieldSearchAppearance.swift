//
//  DSTextFieldSearchAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/11/22.
//

import UIKit

protocol DSTextFieldSearchAppearance {
    var textFont: UIFont { get }
    var textColor: UIColor { get }
    var borderColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var isUserInteractonEnabled: Bool { get }
}

extension DSTextFieldSearchState: DSTextFieldSearchAppearance {
    var textFont: UIFont {
        switch self {
        case .focus, .disable, .filled:
            return DSFont.paragraphMedium ?? FontFamily.OneApp.regular.font(size: 16.0)
        case .default, .disableEmpty:
            return DSFont.placeholder ?? FontFamily.OneApp.regular.font(size: 16)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightPlaceholder
        case .focus, .filled:
            return DSColor.componentLightDefault
        case .disable:
            return DSColor.componentLightLabel
        case .disableEmpty:
            return DSColor.componentLightPlaceholder
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .default, .filled:
            return DSColor.componentLightOutline
        case .focus:
            return DSColor.componentLightOutlineInputFocus
        case .disable:
            return DSColor.componentDisableOutline
        case .disableEmpty:
            return DSColor.componentDisableOutline
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .default, .filled:
            return DSColor.componentLightBackground
        case .focus:
            return DSColor.componentLightBackground
        case .disable:
            return DSColor.componentDisableBackground
        case .disableEmpty:
            return DSColor.componentDisableBackground
        }
    }
    
    var isUserInteractonEnabled: Bool {
        switch self {
        case .default, .focus, .filled:
            return true
        case .disable, .disableEmpty:
            return false
        }
    }
}
