//
//  DSContentListAccessibility.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/1/2567 BE.
//

import Foundation

public struct DSContentListAccessibility {
    public var id: String?
    public var prefixContentBasicViewId: String?
    public var prefixLeftHeaderTitleLabelId: String?
    public var prefixRightHeaderTitleLabelId: String?
    public var prefixTitleLabelId: String?
    public var prefixStatusPillViewId: String?
    public var prefixStatusPillViewLabelId: String?
    public var prefixTagPillViewId: String?
    public var prefixDescriptionLabelId: String?
    public var prefixActionButtonId: String?
    public var prefixActionButtonLabelId: String?

    public init(
        id: String? = nil,
        prefixContentBasicViewId: String? = nil,
        prefixLeftHeaderTitleLabelId: String? = nil,
        prefixRightHeaderTitleLabelId: String? = nil,
        prefixTitleLabelId: String? = nil,
        prefixStatusPillViewId: String? = nil,
        prefixStatusPillViewLabelId: String? = nil,
        prefixTagPillViewId: String? = nil,
        prefixDescriptionLabelId: String? = nil,
        prefixActionButtonId: String? = nil,
        prefixActionButtonLabelId: String? = nil
    ) {
        self.id = id
        self.prefixContentBasicViewId = prefixContentBasicViewId
        self.prefixLeftHeaderTitleLabelId = prefixLeftHeaderTitleLabelId
        self.prefixRightHeaderTitleLabelId = prefixRightHeaderTitleLabelId
        self.prefixTitleLabelId = prefixTitleLabelId
        self.prefixStatusPillViewId = prefixStatusPillViewId
        self.prefixStatusPillViewLabelId = prefixStatusPillViewLabelId
        self.prefixTagPillViewId = prefixTagPillViewId
        self.prefixDescriptionLabelId = prefixDescriptionLabelId
        self.prefixActionButtonId = prefixActionButtonId
        self.prefixActionButtonLabelId = prefixActionButtonLabelId
    }
}
