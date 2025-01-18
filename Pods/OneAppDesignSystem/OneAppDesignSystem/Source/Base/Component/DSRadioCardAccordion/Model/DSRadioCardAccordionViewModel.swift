//
//  DSRadioCardAccordionViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 31/10/24.
//

import UIKit

public struct DSRadioCardAccordionViewModel {
    public var tagId: Int
    public var title: String
    public var value: String?
    public var description: String?
    public var state: DSSelectionRadioCardAccordionState
    public var isExpanded: Bool

    public init(
        tagId: Int = 0,
        title: String,
        value: String? = nil,
        description: String? = nil,
        state: DSSelectionRadioCardAccordionState = .default,
        isExpanded: Bool
    ) {
        self.tagId = tagId
        self.title = title
        self.value = value
        self.description = description
        self.state = state
        self.isExpanded = isExpanded
    }
}
