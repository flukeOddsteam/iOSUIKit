//
//  DSMenuListDescriptionActionViewModel.swift
//
//  Created by TTB on 6/6/2566 BE.
//

import Foundation

public struct DSMenuListDescriptionActionViewModel {
    public var title: String
    public var ghostButtonIcon: DSIcons
    public var ghostButtonText: String
    public var iconSize: DSMenuListDescriptionActionViewModel.IconSize
    public var items: [DSMenuListDescriptionActionViewModel.ActionItems]
    public var presentationType: DSMenuListDescriptionActionViewModel.PresentationType
    
    public init(
        title: String,
        ghostButtonIcon: DSIcons = .icon24OutlinePlus,
        ghostButtonText: String,
        iconSize: DSMenuListDescriptionActionViewModel.IconSize,
        items: [DSMenuListDescriptionActionViewModel.ActionItems],
        presentationType: DSMenuListDescriptionActionViewModel.PresentationType
    ) {
        self.title = title
        self.ghostButtonIcon = ghostButtonIcon
        self.ghostButtonText = ghostButtonText
        self.iconSize = iconSize
        self.items = items
        self.presentationType = presentationType
    }
}
public extension DSMenuListDescriptionActionViewModel {
    struct ActionItems {
        public var titleText: String
        public var descriptionText: String?
        public var leftIcon: DSIcons
        
        public init(
            titleText: String,
            descriptionText: String,
            leftIcon: DSIcons
        ) {
            self.titleText = titleText
            self.descriptionText = descriptionText
            self.leftIcon = leftIcon
        }
    }
    
    enum IconSize {
        case medium
        case large
    }
    
    enum PresentationType: Equatable {
        case dynamic
        case fullPage
    }
}
