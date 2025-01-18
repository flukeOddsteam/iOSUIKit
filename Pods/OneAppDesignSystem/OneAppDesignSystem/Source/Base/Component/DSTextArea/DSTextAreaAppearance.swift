//
//  DSTextAreaAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/12/22.
//

import UIKit

protocol DSTextAreaAppearance {
    var textColor: UIColor { get }
    var borderColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var isUserInteractionEnabled: Bool { get }
    var helperTextIsError: Bool { get }
}

extension DSTextAreaState: DSTextAreaAppearance {
    var textColor: UIColor {
        switch self {
        case .default, .focus, .filled, .error:
            return DSColor.componentLightDefault
        case .disable:
            return DSColor.componentLightLabel
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutline
        case .focus:
            return DSColor.componentLightOutlineInputFocus
        case .filled:
            return DSColor.componentLightOutline
        case .error:
            return DSColor.componentLightError
        case .disable:
            return DSColor.componentDisableOutline
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightBackground
        case .focus:
            return DSColor.componentLightBackground
        case .filled:
            return DSColor.componentLightBackground
        case .error:
            return DSColor.componentLightBackground
        case .disable:
            return DSColor.componentDisableBackground
        }
    }
    
    var isUserInteractionEnabled: Bool {
        switch self {
        case .default, .focus, .filled, .error:
            return true
        case .disable:
            return false
        }
    }
    
    var helperTextIsError: Bool {
        switch self {
        case .default, .focus, .filled, .disable:
            return false
        case .error:
            return true
        }
    }
}
