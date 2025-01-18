//
//  SelectionRadioCardAccordionAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 1/11/24.
//

import UIKit

protocol SelectionRadioCardAccordionAppearance {
    var titleColor: UIColor { get }
    var isUserInteractonEnabled: Bool { get }
}

extension DSSelectionRadioCardAccordionState: SelectionRadioCardAccordionAppearance {
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
