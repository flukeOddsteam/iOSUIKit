//
//  DSButtonSize.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/11/2566 BE.
//

import UIKit

enum DSButtonSize {
    case large
    case medium
    case small

    var iconImageSize: CGSize {
        switch self {
        case .large:
            return CGSize(width: DSButtonIconSizeConstant.large.rawValue, height: DSButtonIconSizeConstant.large.rawValue)
        case .medium:
            return CGSize(width: DSButtonIconSizeConstant.medium.rawValue, height: DSButtonIconSizeConstant.medium.rawValue)
        case .small:
            return CGSize(width: DSButtonIconSizeConstant.small.rawValue, height: DSButtonIconSizeConstant.small.rawValue)
        }
    }
}
