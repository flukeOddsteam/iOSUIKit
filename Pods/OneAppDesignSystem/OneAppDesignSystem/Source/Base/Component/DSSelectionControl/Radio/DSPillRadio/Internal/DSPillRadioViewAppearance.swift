//
//  DSPillRadioViewAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/10/22.
//

import Foundation
import UIKit

protocol DSPillRadioAppearance {
    var textColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var backgroundColor: UIColor { get }
    var isUserInteractonEnabled: Bool { get }
}

extension DSPillRadioState: DSPillRadioAppearance {
    var textColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightLabel
        case .selected:
            return DSColor.componentDarkDefault
        case .disable:
            return DSColor.componentDisableDefault
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutline
        case .selected:
            return .clear
        case .disable:
            return DSColor.componentDisableOutline
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .default, .disable:
            return 1
        case .selected:
            return 0
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightBackground
        case .selected:
            return DSColor.componentDarkBackground
        case .disable:
            return DSColor.componentDisableBackground
        }
    }
    
    var isUserInteractonEnabled: Bool {
        switch self {
        case .default, .selected:
            return true
        case .disable:
            return false
        }
    }
}
