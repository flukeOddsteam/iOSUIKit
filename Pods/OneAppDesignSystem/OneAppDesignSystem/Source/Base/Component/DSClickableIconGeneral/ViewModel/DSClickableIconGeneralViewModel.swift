//
//  DSClickableIconGeneralViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2566 BE.
//

import Foundation

public struct DSClickableIconGeneralViewModel {
    public let tagId: Int
    public let title: String?
    public let style: DSClickableIconGeneralStyle
    public let state: DSClickableIconGeneralState
    public let icon: DSClickableIconGeneralImageType

    public init(
        tagId: Int = .zero,
        title: String?,
        style: DSClickableIconGeneralStyle,
        state: DSClickableIconGeneralState,
        icon: DSClickableIconGeneralImageType
    ) {
        self.tagId = tagId
        self.title = title
        self.style = style
        self.state = state
        self.icon = icon
    }
}
