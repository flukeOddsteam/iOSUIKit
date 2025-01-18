//
//  DSTextFieldWithPlusMinusButtonStage.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/4/2566 BE.
//

import UIKit

public enum DSTextFieldWithPlusMinusButtonStage {
    case `default`
    case error
    case focus
    case filled
    case typing
    case disable(isEmpty: Bool = false)
}

extension DSTextFieldWithPlusMinusButtonStage {
    var textFieldColor: UIColor {
        switch self {
        case .disable(let isEmpty):
            if isEmpty {
                return DSColor.componentLightPlaceholder
            } else {
                return DSColor.componentLightLabel
            }
        case .error:
            return DSColor.componentLightDefault
        case .focus:
            return DSColor.componentLightDefault
        case .filled:
            return DSColor.componentLightDefault
        default:
            return DSColor.componentLightPlaceholder
        }
    }
    
    var textFieldBorderColor: UIColor {
        switch self {
        case .disable:
            return DSColor.componentDisableOutline
        case .error:
            return DSColor.componentLightError
        case .focus:
            return DSColor.componentLightOutlineInputFocus
        case .filled:
            return DSColor.componentLightOutline
        default:
            return DSColor.componentLightOutline
        }
    }
    
    var textFieldBackgroundColor: UIColor {
        switch self {
        case .disable:
            return DSColor.componentDisableBackground
        default:
            return DSColor.componentLightBackground
        }
    }
}
