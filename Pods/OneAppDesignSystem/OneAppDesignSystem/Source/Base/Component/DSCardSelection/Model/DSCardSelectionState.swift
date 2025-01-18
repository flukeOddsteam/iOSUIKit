//
//  DSCardSelectionState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/11/2567 BE.
//

import UIKit

enum DSCardSelectionState: Equatable {
    case `default`
    case selected
    case disable
}

extension DSCardSelectionState {
    var backgroundColor: UIColor {
        switch self {
        case .default, .selected:
            return DSColor.componentLightBackground
        case .disable:
            return DSColor.componentDisableBackgroundPrimary
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutlinePrimary
        case .selected:
            return DSColor.componentLightOutlineActive
        case .disable:
            return DSColor.componentDisableOutline
        }
    }
    
    var labelColor: UIColor {
        switch self {
        case .default, .selected:
            return DSColor.componentLightDefault
        case .disable:
            return DSColor.componentDisableDefault
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .selected:
            return 2.0
        default:
            return 1.0
        }
    }
    
    var isShadowHidden: Bool {
        switch self {
        case .default, .selected:
            return false
        case .disable:
            return true
        }
    }
}
