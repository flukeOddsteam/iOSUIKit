//
//  DSDatePickerAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/1/23.
//

import UIKit

protocol DSDatePickerAppearance {
    var contentViewBorderColor: UIColor { get }
    var contentViewBackgroundColor: UIColor { get }
    var transparentButtonisUserInteractionEnabled: Bool { get }
}

extension DSTextFieldDatePickerState: DSDatePickerAppearance {
    var contentViewBorderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutline
        case .selected:
            return DSColor.componentLightOutline
        case .focus:
            return DSColor.componentLightOutlineInputFocus
        case .error:
            return DSColor.componentLightError
        case .disable:
            return DSColor.componentDisableOutline
        }
    }
    
    var contentViewBackgroundColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightBackground
        case .selected:
            return DSColor.componentLightBackground
        case .focus:
            return DSColor.componentLightBackground
        case .error:
            return DSColor.componentLightBackground
        case .disable:
            return DSColor.componentDisableBackground
        }
    }
    
    var transparentButtonisUserInteractionEnabled: Bool {
        switch self {
        case .default:
            return true
        case .selected:
            return true
        case .focus:
            return true
        case .error:
            return true
        case .disable:
            return false
        }
    }
}
