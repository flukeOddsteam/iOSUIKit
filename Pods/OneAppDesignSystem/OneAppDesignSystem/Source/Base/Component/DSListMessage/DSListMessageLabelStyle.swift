//
//  DSListMessageLabelStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/2/2567 BE.
//

import UIKit

public enum DSListMessageLabelStyle {
    case regular
    case bold
    case medium
}

extension DSListMessageLabelStyle {
    var font: UIFont? {
        switch self {
        case .regular:
            return DSFont.labelList
        case .bold:
            return DSFont.h3
        case .medium:
            return DSFont.labelListMedium
        }
    }

    var textColor: UIColor {
        switch self {
        case .regular:
            return DSColor.componentLightLabel
        case .bold:
            return DSColor.componentLightDefault
        case .medium:
            return DSColor.componentLightLabel
        }
    }
}
