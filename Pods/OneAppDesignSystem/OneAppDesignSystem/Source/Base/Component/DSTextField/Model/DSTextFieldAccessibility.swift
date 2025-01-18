//
//  DSTextFieldAccessibility.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/1/2567 BE.
//

import Foundation

public struct DSTextFieldAccessibility {
    public var id: String?
    public var textFieldId: String?
    public var helperTextViewId: String?
    public var titleLabelId: String?
    public var clickAbleIconViewId: String?
    public var doneButtonId: String?

    public init(
        id: String? = nil,
        textFieldId: String? = nil,
        helperTextViewId: String? = nil,
        titleLabelId: String? = nil,
        clickAbleIconViewId: String? = nil,
        doneButtonId: String? = nil
    ) {
        self.id = id
        self.textFieldId = textFieldId
        self.helperTextViewId = helperTextViewId
        self.titleLabelId = titleLabelId
        self.clickAbleIconViewId = clickAbleIconViewId
        self.doneButtonId = doneButtonId
    }
}
