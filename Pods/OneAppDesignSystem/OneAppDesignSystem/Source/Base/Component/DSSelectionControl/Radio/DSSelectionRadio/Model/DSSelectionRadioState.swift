//
//  DSSelectionRadioState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/9/2565 BE.
//

import Foundation

/// Declare DSSelectionRadioAction to be type of action for SelectionRadio field.
public typealias DSSelectionRadioAction = ((_ currentState: DSSelectionRadioState) -> Void)

/// Enum SelectionRadio state
public enum DSSelectionRadioState {
    /// Normal State before being tapped on.
	case `default`
    /// State when being tapped on SelectionRadio field.
	case selected
    /// State disable SelectionRadio field.
	case disableUnselected
    /// State disable Selectioned Radio field.
    case disableSelected
}
