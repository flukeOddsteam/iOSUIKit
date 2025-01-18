//
//  DSMultipleTextFieldViewModel.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 5/2/2567 BE.
//

import Foundation

public struct DSMultipleTextFieldViewModel {
    public var type: DSMultipleTextFieldType
    public var state: DSMultipleTextFieldState
    public var helperText: String?
    public var primaryViewModel: DSMultipleTextFieldComponentViewModel
    public var secondaryViewModel: DSMultipleTextFieldComponentViewModel?
    public var tertiaryViewModel: DSMultipleTextFieldComponentViewModel?

    public init(
        type: DSMultipleTextFieldType,
        state: DSMultipleTextFieldState,
        helperText: String? = nil,
        primaryViewModel: DSMultipleTextFieldComponentViewModel,
        secondaryViewModel: DSMultipleTextFieldComponentViewModel? = nil,
        tertiaryViewModel: DSMultipleTextFieldComponentViewModel? = nil
    ) {
        self.type = type
        self.state = state
        self.helperText = helperText
        self.primaryViewModel = primaryViewModel
        self.secondaryViewModel = secondaryViewModel
        self.tertiaryViewModel = tertiaryViewModel
    }
}
