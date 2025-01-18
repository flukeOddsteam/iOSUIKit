//
//  DSListActionViewModels.swift
//  OneAppDesignSystem
//
//  Created by TTB on 26/1/23.
//

import Foundation
import UIKit

public struct ListActionIconViewModel {
    public var text: String
    var textStyle: DSListActionIconTitleStyle
    var leftIcon: DSIcons?
    var rightIcon: DSIcons?
    var hideLeftIcon: IconHiddenStyle
    var hideRightIcon: IconHiddenStyle
    
    public init(text: String,
                textStyle: DSListActionIconTitleStyle = .h3,
                leftIcon: DSIcons? = nil,
                rightIcon: DSIcons? = nil,
                hideLeftIcon: IconHiddenStyle = .all,
                hideRightIcon: IconHiddenStyle = .all) {
        self.text = text
        self.textStyle = textStyle
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.hideLeftIcon = hideLeftIcon
        self.hideRightIcon = hideRightIcon
    }
}

public struct ListActionIconSpotViewModel {
    public var text: String
    var textStyle: DSListActionIconTitleStyle
    var leftImage: DSIllusIcons
    var rightIcon: DSIcons?
    var hideRightIcon: IconHiddenStyle
    
    public init(text: String,
                textStyle: DSListActionIconTitleStyle = .h3,
                leftImage: DSIllusIcons,
                rightIcon: DSIcons? = nil,
                hideRightIcon: IconHiddenStyle = .all) {
        self.text = text
        self.textStyle = textStyle
        self.leftImage = leftImage
        self.rightIcon = rightIcon
        self.hideRightIcon = hideRightIcon
    }
}

public struct ListActionToggleViewModel {
    var text: String
    var leftIcon: DSIcons?
    var state: DSToggleState
    var description: String?
    var labelSize: DSListActionToggleLabelSize
    
    public init(text: String, leftIcon: DSIcons? = nil, state: DSToggleState = .offActive, description: String? = nil, labelSize: DSListActionToggleLabelSize = .large) {
        self.text = text
        self.leftIcon = leftIcon
        self.state = state
        self.description = description
        self.labelSize = labelSize
    }
}

public struct DSIconValue {
    public let icon: DSIcons
    public let color: UIColor
    
    public init(icon: DSIcons,
                color: UIColor = DSColor.componentLightDefault) {
        self.icon = icon
        self.color = color
    }
}

public struct ListActionMenuViewModel {
    var label: String
    var iconValue: DSIconValue?
    var value: String?
    var labelDesc: String?
    var leftIcon: DSListActionMenuImageType?
    var rightIcon: DSIcons
    var pill: DSCollectionPillViewModel?
    var ratio: CGFloat?

    public init(label: String,
                iconValue: DSIconValue? = nil,
                value: String? = nil,
                labelDesc: String? = nil,
                leftIcon: DSListActionMenuImageType? = nil,
                pill: DSCollectionPillViewModel? = nil,
                ratio: CGFloat? = 1) {
        self.label = label
        self.iconValue = iconValue
        self.value = value
        self.labelDesc = labelDesc
        self.leftIcon = leftIcon
        self.rightIcon = DSIcons.icon24OutlineChevronRight
        self.pill = pill
        self.ratio = ratio
    }
}

public struct DSListActionAvatarFavoriteViewModel {
    var avatarImage: UIImage?
    var label: String
    var isFavorite: Bool
    
    public init(avatarImage: UIImage? = nil, label: String, isFavorite: Bool = false) {
        self.avatarImage = avatarImage
        self.label = label
        self.isFavorite = isFavorite
    }
}

public struct DSListActionAvatarGhostViewModel {
    var avatarImage: UIImage?
    var label: String
    var primaryButtonImage: UIImage
    var secondaryButtonImage: UIImage?
    
    public init(avatarImage: UIImage? = nil,
                label: String,
                primaryButtonImage: UIImage,
                secondaryButtonImage: UIImage? = nil) {
        self.avatarImage = avatarImage
        self.label = label
        self.primaryButtonImage = primaryButtonImage
        self.secondaryButtonImage = secondaryButtonImage
    }
}

public struct DSListActionIconValueViewModel {
    var text: String
    var valueText: String
    var secondaryText: String?
    var textStyle: DSListActionIconTitleStyle
    var leftIcon: DSIcons?
    var rightIcon: DSIcons?
    var hideLeftIcon: IconHiddenStyle
    var hideRightIcon: IconHiddenStyle
    var ratio: CGFloat
    
    public init(text: String,
                valueText: String,
                secondaryText: String? = nil,
                textStyle: DSListActionIconTitleStyle = .h3,
                leftIcon: DSIcons? = nil,
                rightIcon: DSIcons? = nil,
                hideLeftIcon: IconHiddenStyle = .all,
                hideRightIcon: IconHiddenStyle = .all,
                ratio: CGFloat = 1) {
        self.text = text
        self.valueText = valueText
        self.secondaryText = secondaryText
        self.textStyle = textStyle
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.hideLeftIcon = hideLeftIcon
        self.hideRightIcon = hideRightIcon
        self.ratio = ratio
    }
}
