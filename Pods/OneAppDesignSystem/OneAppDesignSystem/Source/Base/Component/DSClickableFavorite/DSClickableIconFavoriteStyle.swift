//
//  DSClickableIconFavoriteStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/4/2566 BE.
//

import UIKit

public enum DSClickableIconFavoriteStyle {
    case `default`
    case selected
}

protocol ClickableIconFavoriteStyleAppearance {
    var iconImage: UIImage { get }
}

// MARK: - ClickableIconFavoriteStyleAppearance
extension DSClickableIconFavoriteStyle: ClickableIconFavoriteStyleAppearance {
    var iconImage: UIImage {
        switch self {
        case .default:
            return DSIcons.icon24Outlineheart.image
        case .selected:
            return DSIcons.icon24SolidHeart.image
        }
    }
}
