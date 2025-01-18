//
//  DSClickableIconGeneralIconViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/2/2567 BE.
//

import Foundation

public struct DSClickableIconGeneralIconViewModel {
    public var tagId: Int
    public var state: DSClickableIconGeneralState
    public var theme: DSClickableIconGeneralIconTheme
    public var size: DSClickableIconGeneralIconSize
    public var imageType: DSClickableIconGeneralImageType
    public var isBadged: Bool

    public init(
        tagId: Int,
        state: DSClickableIconGeneralState,
        theme: DSClickableIconGeneralIconTheme,
        size: DSClickableIconGeneralIconSize,
        imageType: DSClickableIconGeneralImageType,
        isBadged: Bool
    ) {
        self.tagId = tagId
        self.state = state
        self.theme = theme
        self.size = size
        self.imageType = imageType
        self.isBadged = isBadged
    }
}
