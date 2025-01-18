//
//  DSSelectionRadioState+ViewAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/10/2565 BE.
//

import UIKit

protocol RadioCardViewAppearance {
    var radioCardCornerRadius: CGFloat { get }
    var radioCardBorderWidth: CGFloat { get }
    var radioCardBorderColor: UIColor { get }
    var radioCardBackgroundColor: UIColor { get }
    var radioCardShadowEnabled: Bool { get }
    var avatarCardShadowEnabled: Bool { get }
}

extension DSSelectionRadioState: RadioCardViewAppearance {
    var radioCardCornerRadius: CGFloat {
        return 12
    }
    
    var radioCardBorderWidth: CGFloat {
        switch self {
        case .default, .disableUnselected:
            return 1
        case .selected, .disableSelected:
            return 2
        }
    }
    
    var radioCardBorderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutline
        case .selected:
            return DSColor.componentLightOutlineActive
        case .disableUnselected:
            return DSColor.componentLightOutline
        case .disableSelected:
            return DSColor.componentDisableOutline
        }
    }
    
    var radioCardShadowEnabled: Bool {
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
    
    var radioCardBackgroundColor: UIColor {
        DSColor.componentLightBackground
    }
}
