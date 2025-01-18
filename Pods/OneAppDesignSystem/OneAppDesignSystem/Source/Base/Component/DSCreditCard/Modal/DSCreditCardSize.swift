//
//  DSCreditCardSize.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/1/2567 BE.
//

import UIKit

public enum DSCreditCardSize {
    case small
    case xSmall
    case large
}

extension DSCreditCardSize {
    var cgSize: CGSize {
        switch self {
        case .xSmall:
            return CGSize(width: 40, height: 25)
        case .small:
            return CGSize(width: 80, height: 50)
        case .large:
            return CGSize(width: 257, height: 163)
        }
    }

    var radius: CGFloat {
        switch self {
        case .xSmall, .small:
            return 2
        case .large:
            return 8
        }
    }

    var placeholder: UIImage {
        switch self {
        case .xSmall:
            return SvgIcons.creditCardPlaceholderSmall.image
        case .small:
            return SvgIcons.creditCardPlaceholderXSmall.image
        case .large:
            return SvgIcons.creditCardPlaceholderLarge.image
        }
    }

    var virtualImage: UIImage {
        switch self {
        case .xSmall:
            return SvgIcons.virtualCardXSmall.image
        case .small:
            return SvgIcons.virtualCardSmall.image
        case .large:
            return SvgIcons.virtualCardLarge.image
        }
    }
}
