//
//  SelectionCheckboxAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/10/22.
//

import UIKit

protocol SelectionCheckboxAppearance {
    var titleColor: UIColor { get }
    var isUserInteractonEnabled: Bool { get }
}

extension DSSelectionCheckboxState: SelectionCheckboxAppearance {
    var titleColor: UIColor {
        switch self {
        case .default, .checked:
            return DSColor.componentLightDefault
        case .disableUnchecked, .disableChecked:
            return DSColor.componentDisableDefault
        }
    }
    
    var isUserInteractonEnabled: Bool {
        switch self {
        case .default, .checked:
            return true
        case .disableUnchecked, .disableChecked:
            return false
        }
    }
}
