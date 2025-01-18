//
//  DSSelectionRadioCardAccordionState+ViewAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 1/11/24.
//

import UIKit

protocol RadioCardAccordionViewAppearance {
    var radioCardAccordionCornerRadius: CGFloat { get }
    var radioCardAccordionBorderWidth: CGFloat { get }
    var radioCardAccordionBorderColor: UIColor { get }
    var radioCardAccordionBackgroundColor: UIColor { get }
    var radioCardAccordionShadowEnabled: Bool { get }
    var avatarCardShadowEnabled: Bool { get }
}

extension DSSelectionRadioCardAccordionState: RadioCardAccordionViewAppearance {
    var radioCardAccordionCornerRadius: CGFloat {
        return 12
    }
    
    var radioCardAccordionBorderWidth: CGFloat {
        switch self {
        case .default, .disableUnselected:
            return 1
        case .selected, .disableSelected:
            return 2
        }
    }
    
    var radioCardAccordionBorderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutlinePrimary
        case .selected:
            return DSColor.componentLightOutlineActive
        case .disableUnselected:
            return DSColor.componentDisableOutline
        case .disableSelected:
            return DSColor.componentDisableOutline
        }
    }
    
    var radioCardAccordionShadowEnabled: Bool {
        switch self {
        case .default, .selected:
            return true
        case .disableUnselected, .disableSelected:
            return false
        }
    }
    
    var avatarCardShadowEnabled: Bool {
        switch self {
        case .default, .selected:
            return true
        case .disableUnselected, .disableSelected:
            return false
        }
    }
    
    var radioCardAccordionBackgroundColor: UIColor {
        return DSColor.componentLightBackground
    }
}
