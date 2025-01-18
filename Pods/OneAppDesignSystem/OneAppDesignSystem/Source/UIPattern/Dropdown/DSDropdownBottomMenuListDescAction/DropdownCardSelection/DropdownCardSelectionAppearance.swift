//
//  DropdownCardSelectionAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/5/2567 BE.
//

import UIKit

protocol DropdownCardSelectionAppearance {
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var backgroundColor: UIColor { get }
    var isShadowHidden: Bool { get}
}

extension DropdownCardSelectionState: DropdownCardSelectionAppearance {
    var isShadowHidden: Bool {
        switch self {
        case .default, .selected:
            return false
        case .unselectOnPress, .selectedOnPress:
            return true
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .default, .unselectOnPress:
            return 1
        case .selected, .selectedOnPress:
            return 2
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutlineSecondary
        case .selected:
            return DSColor.componentLightOutlineActive
        case .unselectOnPress:
            return DSColor.componentLightOutlineSecondary
        case .selectedOnPress:
            return DSColor.componentLightOutlineActiveOnPress
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .default, .selected:
            return DSColor.componentLightBackground
        case .unselectOnPress, .selectedOnPress:
            return DSColor.componentLightBackgroundOnPress
        }
    }
}
