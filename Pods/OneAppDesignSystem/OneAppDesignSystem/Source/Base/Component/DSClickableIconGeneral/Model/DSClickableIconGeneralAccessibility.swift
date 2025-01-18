//
//  DSClickableIconGeneralAccessibility.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2566 BE.
//

import Foundation

public struct DSClickableIconGeneralAccessibility {
    public let viewId: String?
    public let containerId: String?
    public let iconImageViewId: String?
    public let titleId: String?

    public init(viewId: String? = nil,
                containerId: String? = nil,
                iconImageViewId: String? = nil,
                titleId: String? = nil) {
        self.viewId = viewId
        self.containerId = containerId
        self.iconImageViewId = iconImageViewId
        self.titleId = titleId
    }
}
