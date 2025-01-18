//
//  DSClickableIconGeneralIconSize.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/2/2567 BE.
//

import Foundation

public enum DSClickableIconGeneralIconSize {
    case small
    case medium
    case large
}

extension DSClickableIconGeneralIconSize {
    var iconSize: CGSize {
        switch self {
        case .small:
            return CGSize(width: 16, height: 16)
        case .medium:
            return CGSize(width: 24, height: 24)
        case .large:
            return CGSize(width: 36, height: 36)
        }
    }

    var containerSize: CGSize {
        switch self {
        case .small:
            return CGSize(width: 24, height: 24)
        case .medium:
            return CGSize(width: 40, height: 40)
        case .large:
            return CGSize(width: 52, height: 52)
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .small:
            return 12
        case .medium:
            return 20
        case .large:
            return 26
        }
    }
}
