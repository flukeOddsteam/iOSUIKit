//
//  DSMultipleTextFieldAmountViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/2/2567 BE.
//

import Foundation

public struct DSMultipleTextFieldComponentViewModel {
    public let title: String
    public let preFillValue: String?
    public let suffixText: String?
    public let maxLenght: Int?
    public let formatType: DSTextFieldAmountFormatType

    public init(
        title: String,
        preFillValue: String? = nil,
        suffixText: String? = nil,
        maxLenght: Int? = nil,
        formatType: DSTextFieldAmountFormatType
    ) {
        self.title = title
        self.preFillValue = preFillValue
        self.suffixText = suffixText
        self.maxLenght = maxLenght
        self.formatType = formatType
    }
}
