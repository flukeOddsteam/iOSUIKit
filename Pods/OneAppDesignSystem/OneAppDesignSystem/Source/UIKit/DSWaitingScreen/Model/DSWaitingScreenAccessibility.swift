//
//  DSWaitingScreenAccessibility.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 14/2/2567 BE.
//

import Foundation

public struct DSWaitingScreenAccessibility {
    public var titleId: String?
    public var descriptionId: String?
    public var ghostButtonId: String?
    public var ghostButtonLabelId: String?
    public var bottomSheetAccessibility: BottomSheetAccessibility?

    public init(
        titleId: String? = nil,
        descriptionId: String? = nil,
        ghostButtonId: String? = nil,
        ghostButtonLabelId: String? = nil,
        bottomSheetAccessibility: BottomSheetAccessibility? = nil
    ) {
        self.titleId = titleId
        self.descriptionId = descriptionId
        self.ghostButtonId = ghostButtonId
        self.ghostButtonLabelId = ghostButtonLabelId
        self.bottomSheetAccessibility = bottomSheetAccessibility
    }

}

extension DSWaitingScreenAccessibility {

    public struct BottomSheetAccessibility {
        public var titleId: String?
        public var descriptionId: String?
        public var primaryButtonId: String?
        public var primaryButtonLabelId: String?
        public var ghostButtonId: String?
        public var ghostButtonLabelId: String?
        public var closeButtonId: String?

        public init(
            titleId: String? = nil,
            descriptionId: String? = nil,
            primaryButtonId: String? = nil,
            primaryButtonLabelId: String? = nil,
            ghostButtonId: String? = nil,
            ghostButtonLabelId: String? = nil,
            closeButtonId: String? = nil
        ) {
            self.titleId = titleId
            self.descriptionId = descriptionId
            self.primaryButtonId = primaryButtonId
            self.ghostButtonId = ghostButtonId
            self.closeButtonId = closeButtonId
            self.primaryButtonLabelId = primaryButtonLabelId
            self.ghostButtonLabelId = ghostButtonLabelId
        }
    }
}
