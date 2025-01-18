//
//  DSTextFieldAmountAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 18/1/2566 BE.
//

import UIKit

protocol DSTextFieldAmountAppearance {
    var textColor: UIColor { get }
    var borderColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var isUserInteractionEnabled: Bool { get }
    var helperTextIsError: Bool { get }
}

extension DSTextFieldAmountState: DSTextFieldAmountAppearance {
    var textColor: UIColor {
        switch self {
        case .default, .focus, .error:
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
        case .error:
            return DSColor.componentLightError
        case .disable:
            return DSColor.componentDisableOutline
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .default, .focus, .error:
            return DSColor.componentLightBackground
        case .disable:
            return DSColor.componentDisableBackground
        }
    }
    
    var isUserInteractionEnabled: Bool {
        switch self {
        case .default, .focus, .error:
            return true
        case .disable:
            return false
        }
    }
    
    var helperTextIsError: Bool {
        switch self {
        case .default, .focus, .disable:
            return false
        case .error:
            return true
        }
    }
}
