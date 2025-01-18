//
//  DSDropdownBottomSheetLogoListFilterState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/5/24.
//

public enum DSDropdownBottomSheetLogoListFilterState: Equatable {
    /// Normal State before being pressed
    case idle
    /// State when being pressed and focused on Dropdown field
    case focus
    /// State when being selected an option on ButtomSheet Dropdown
    case selected
    /// State error with alert icon and error message below Dropdown field
    case error(message: String)
    /// State disable Dropdown field
    case disable
}
