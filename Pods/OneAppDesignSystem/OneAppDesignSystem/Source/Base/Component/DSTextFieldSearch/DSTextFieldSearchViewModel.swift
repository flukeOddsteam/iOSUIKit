//
//  DSTextFieldSearchViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/5/24.
//

public struct DSTextFieldSearchViewModel {
    public let placeholder: String
    public let text: String
    public let state: DSTextFieldSearchState
    public let helperText: String
    public let keyboardToolBarDismissButtonLabel: String

    public init(
        placeholder: String,
        text: String = "",
        state: DSTextFieldSearchState = .default,
        helperText: String = "",
        keyboardToolBarDismissButtonLabel: String
    ) {
        self.placeholder = placeholder
        self.text = text
        self.state = state
        self.helperText = helperText
        self.keyboardToolBarDismissButtonLabel = keyboardToolBarDismissButtonLabel
    }
}
