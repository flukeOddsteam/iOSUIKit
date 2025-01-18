//
//  SelectionRadioAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/9/2565 BE.
//

import UIKit

protocol SelectionRadioAppearance {
    var titleColor: UIColor { get }
    var isUserInteractonEnabled: Bool { get }
}

extension DSSelectionRadioState: SelectionRadioAppearance {
    var titleColor: UIColor {
        switch self {
        case .default, .selected, .disableSelected:
            return DSColor.componentLightDefault
        case .disableUnselected:
            return DSColor.componentDisableDefault
        }
    }
    
    var isUserInteractonEnabled: Bool {
        switch self {
        case .default, .selected:
            return true
        case .disableUnselected, .disableSelected:
            return false
        }
    }
}
