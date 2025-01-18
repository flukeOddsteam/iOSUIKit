//
//  DSDropdownState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/11/2566 BE.
//

import Foundation

/// Enum DSDropdown state
public enum DSDropdownState {
    /// Normal State before being pressed
    case idle
    /// State when being pressed and focused on Dropdown field
    case focus
    /// State when being selected an option on ButtomSheet Dropdown
    case selected
    /// State error with alert icon and error message below Dropdown field
    case error(errorMessage: String)
    /// State disable Dropdown field
    case disable
}
