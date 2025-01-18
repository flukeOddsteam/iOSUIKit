//
//  DSSelectionRadioCardAccordionState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 1/11/24.
//

import Foundation

/// Declare DSSelectionRadioCardAccordionAction to be type of action for SelectionRadio field.
public typealias DSSelectionRadioCardAccordionAction = ((_ currentState: DSSelectionRadioCardAccordionState) -> Void)

/// Enum SelectionRadio state
public enum DSSelectionRadioCardAccordionState {
    /// Normal State before being tapped on.
    case `default`
    /// State when being tapped on SelectionRadio field.
    case selected
    /// State disable SelectionRadio field.
    case disableUnselected
    /// State disable Selectioned Radio field.
    case disableSelected
}
