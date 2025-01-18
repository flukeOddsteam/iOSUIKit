//
//  DSListActionAccessibilityToggle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/5/2567 BE.
//

import Foundation

public struct DSListActionAccessibilityToggle {
    public var prefixListActionToggleId: String?
    public var prefixTitleLabelId: String?
    public var prefixToggleId: String?
    public var prefixDescriptionLabelId: String?
    public var prefixCircleViewId: String?

    public init(
        prefixListActionToggleId: String? = nil,
        prefixTitleLabelId: String? = nil,
        prefixToggleId: String? = nil,
        prefixDescriptionLabelId: String? = nil,
        prefixCircleViewId: String? = nil
    ) {
        self.prefixListActionToggleId = prefixListActionToggleId
        self.prefixTitleLabelId = prefixTitleLabelId
        self.prefixToggleId = prefixToggleId
        self.prefixDescriptionLabelId = prefixDescriptionLabelId
        self.prefixCircleViewId = prefixCircleViewId
    }
}
