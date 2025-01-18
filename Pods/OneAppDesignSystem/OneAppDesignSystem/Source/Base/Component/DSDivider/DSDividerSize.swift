//
//  DSDividerSize.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/3/2566 BE.
//

import UIKit

public enum DSDividerSize {
    case large
    case small
}

// MARK: - DividerAppearance
extension DSDividerSize {
    var value: CGFloat {
        switch self {
        case .large:
            return 8
        case .small:
            return 1
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .large:
            return DSColor.componentDividerBackgroundBig
        case .small:
            return DSColor.componentDividerBackgroundSmall
        }
    }
}
