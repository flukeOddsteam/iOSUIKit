//
//  DSAmountRadioCardExpandableViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/9/2567 BE.
//

import UIKit

public struct DSAmountRadioCardExpandableViewModel {
    public var isSelected: Bool
    public var isEnabled: Bool
    public var title: String
    public var ghostButton: GhostButton?
    public var remark: Remark?
    public var textField: TextFieldAmount

    public init(
        isSelected: Bool,
        isEnabled: Bool,
        title: String,
        ghostButton: GhostButton? = nil,
        remark: Remark? = nil,
        textField: TextFieldAmount
    ) {
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.title = title
        self.ghostButton = ghostButton
        self.remark = remark
        self.textField = textField
    }
}

public extension DSAmountRadioCardExpandableViewModel {

    struct Remark {
        public var title: String
        public var isShowSymbol: Bool
        public var bullets: [String]

        public init(
            title: String,
            isShowSymbol: Bool? = nil,
            bullets: [String]
        ) {
            self.title = title
            self.isShowSymbol = isShowSymbol ?? (bullets.count > 1)
            self.bullets = bullets
        }
    }

    struct TextFieldAmount {
        public var titleText: String
        public var state: DSTextFieldAmountState
        public var type: DSTextFieldAmountType
        public var errorEmptyAmountText: String
        public var textFieldValue: String
        public var helperText: String
        public var placeholder: String
        public var feeText: String
        public var suffixText: String
        public var maxLength: Int?

        public init(
            titleText: String,
            state: DSTextFieldAmountState,
            type: DSTextFieldAmountType,
            errorEmptyAmountText: String,
            textFieldValue: String = "",
            helperText: String = "",
            placeholder: String = "0.00",
            feeText: String = "",
            suffixText: String = "",
            maxLength: Int? = nil
        ) {
            self.titleText = titleText
            self.state = state
            self.type = type
            self.errorEmptyAmountText = errorEmptyAmountText
            self.textFieldValue = textFieldValue
            self.helperText = helperText
            self.placeholder = placeholder
            self.feeText = feeText
            self.suffixText = suffixText
            self.maxLength = maxLength
        }
    }

    enum GhostButton {
        case textOnly(String)
        case iconRight(String, UIImage)
        case iconLeft(String, UIImage)
    }
}
