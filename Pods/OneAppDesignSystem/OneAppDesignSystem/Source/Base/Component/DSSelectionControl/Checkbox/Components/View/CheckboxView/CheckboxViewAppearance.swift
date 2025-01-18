//
//  CheckboxViewAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/10/22.
//

import UIKit

protocol CheckboxViewAppearance {
    var checkboxBorderWidth: CGFloat { get }
    var checkboxBorderColor: UIColor { get }
    var checkboxBackgroundColor: UIColor { get }
    var checkIconAppear: Bool { get }
}

extension DSSelectionCheckboxState: CheckboxViewAppearance {
    var checkboxBorderWidth: CGFloat {
        switch self {
        case .default, .disableUnchecked:
            return 2
        case .checked, .disableChecked:
            return 0
        }
    }
    
    var checkboxBorderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightDefault
        case .disableUnchecked:
            return DSColor.componentDisableOutline
        case .checked, .disableChecked:
            return .clear
        }
    }
    
    var checkboxBackgroundColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightBackground
        case .checked:
            return DSColor.componentPrimaryBackground
        case .disableUnchecked:
            return DSColor.componentDisableBackground
        case .disableChecked:
            return DSColor.componentDisableOutline
        }
    }
    
    var checkIconAppear: Bool {
        switch self {
        case .default, .disableUnchecked:
            return true
        case .checked, .disableChecked:
            return false
        }
    }
}
