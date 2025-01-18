//
//  DSListExpandViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/3/2566 BE.
//

import UIKit

public enum DSListExpandTextStyle {
    case paragraphMedium
    case h3
    
    var font: UIFont? {
        switch self {
        case .paragraphMedium:
            return DSFont.paragraphMedium
        case .h3:
            return DSFont.h3
        }
    }
}

public enum DSListExpandType {
    case icon
    case spot
}

public struct DSListExpandViewModel {
    public var title: String
    public var image: DSListExpandImageType?
    public var textStyle: DSListExpandTextStyle
    public var type: DSListExpandType
    public var isDisplayDivider: Bool
    public var state: DSListExpandContentState

    public init(
        title: String,
        textStyle: DSListExpandTextStyle,
        image: DSListExpandImageType? = nil,
        type: DSListExpandType = .icon,
        isDisplayDivider: Bool = true,
        state: DSListExpandContentState = .collapse
    ) {
        self.title = title
        self.image = image
        self.textStyle = textStyle
        self.type = type
        self.isDisplayDivider = isDisplayDivider
        self.state = state
    }
}
