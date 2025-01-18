//
//  DSMessageBoxOfferingAccessibility.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/1/2567 BE.
//

import Foundation

public struct DSMessageBoxOfferingAccessibility {
    public var id, titleId, descriptionId, primaryButtonId, primaryButtonTitleId, secondaryButtonId, secondaryButtonTitleId: String?
    
    public init(
        id: String? = nil,
        titleId: String? = nil,
        descriptionId: String? = nil,
        primaryButtonId: String? = nil,
        primaryButtonTitleId: String? = nil,
        secondaryButtonId: String? = nil,
        secondaryButtonTitleId: String? = nil
    ) {
        self.id = id
        self.titleId = titleId
        self.descriptionId = descriptionId
        self.primaryButtonId = primaryButtonId
        self.primaryButtonTitleId = primaryButtonTitleId
        self.secondaryButtonId = secondaryButtonId
        self.secondaryButtonTitleId = secondaryButtonTitleId
    }
}
