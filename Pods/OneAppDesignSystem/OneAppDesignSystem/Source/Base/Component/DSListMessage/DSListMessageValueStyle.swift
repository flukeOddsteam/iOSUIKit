//
//  DSListMessageValueStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/9/24.
//

import UIKit

public enum DSListMessageValueStyle {
    case regular
    case bold
    case medium
}

extension DSListMessageValueStyle {
    var font: UIFont? {
        switch self {
        case .regular:
            return DSFont.labelList
        case .bold:
            return DSFont.valueList
        case .medium:
            return DSFont.valueListMedium
        }
    }
}
