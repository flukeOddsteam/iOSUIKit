//
//  DSOfferingCardViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 25/4/2567 BE.
//

import UIKit

public struct DSOfferingCardViewModel {
    public struct BackgroundImageViewModel {
        public var title: String
        public var description: String?
        public var imageType: DSOfferingCardViewModel.ImageType

        public init(
            title: String,
            description: String? = nil,
            imageType: DSOfferingCardViewModel.ImageType
        ) {
            self.title = title
            self.description = description
            self.imageType = imageType
        }
    }

    public struct ImageLeftViewModel {
        public var title: String
        public var description: String?
        public var amount: String?
        public var pill: DSPillViewModel
        public var iconType: IconImageLeftType
        public var imageType: ImageType
        public var textSize: TextSize

        public init(
            title: String,
            description: String? = nil,
            amount: String? = nil,
            pill: DSPillViewModel,
            iconType: IconImageLeftType,
            imageType: ImageType,
            textSize: TextSize = .medium
        ) {
            self.title = title
            self.description = description
            self.amount = amount
            self.pill = pill
            self.iconType = iconType
            self.imageType = imageType
            self.textSize = textSize
        }
    }
}

extension DSOfferingCardViewModel {
    public enum ImageType {
        case image(UIImage)
        case url(URL?, placeholder: UIImage?, cacheable: Bool)
    }

    public enum IconImageLeftType {
        case creditCard
        case icon

        internal var shouldDisplayCreditCard: Bool {
            switch self {
            case .creditCard:
                return true
            case .icon:
                return false
            }
        }

        internal var shouldDisplayImageIcon: Bool {
            switch self {
            case .creditCard:
                return false
            case .icon:
                return true
            }
        }
    }

    public enum TextSize {
        case medium
        case small

        var titleFont: UIFont? {
            switch self {
            case .medium:
                return DSFont.h3
            case .small:
                return DSFont.h4
            }
        }

        var descriptionFont: UIFont? {
            switch self {
            case .medium:
                return DSFont.paragraphSmall
            case .small:
                return DSFont.paragraphXSmall
            }
        }
    }
}
