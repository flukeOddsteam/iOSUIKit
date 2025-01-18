//
//  DSSelectionCheckboxState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/10/22.
//

import Foundation
import UIKit

/// Declare DSSelectionCheckboxAction to be type of action for Checkbox field.
public typealias DSSelectionCheckboxAction = ((_ currentState: DSSelectionCheckboxState) -> Void)

/// Enum DSSelectionCheckbox state
public enum DSSelectionCheckboxState {
    /// Normal state before checkbox be tapped on.
    case `default`
    /// State when being tapped on DSCheckboxView.
    case checked
    /// State disable of unchecked DSCheckboxView.
    case disableUnchecked
    /// State disable of checked DSCheckboxView.
    case disableChecked
}

protocol CheckBoxCardViewAppearance {
    var cardCornerRadius: CGFloat { get }
    var cardBorderWidth: CGFloat { get }
    var cardBorderColor: UIColor { get }
    var cardBackgroundColor: UIColor { get }
    var cardShadowEnabled: Bool { get }
}

extension DSSelectionCheckboxState: CheckBoxCardViewAppearance {
    var cardCornerRadius: CGFloat {
        return 12
    }
    
    var cardBorderWidth: CGFloat {
        switch self {
        case .default, .disableChecked, .disableUnchecked:
            return 1
        case .checked:
            return 2
        }
    }
    
    var cardBorderColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutline
        case .checked:
            return DSColor.componentLightOutlineActive
        case .disableChecked, .disableUnchecked:
            return DSColor.componentLightOutline
        }
    }
    
    var cardShadowEnabled: Bool {
        switch self {
        case .default, .checked:
            return true
        case .disableChecked, .disableUnchecked:
            return false
        }
    }
    
    var cardBackgroundColor: UIColor {
        DSColor.componentLightBackground
    }
}
