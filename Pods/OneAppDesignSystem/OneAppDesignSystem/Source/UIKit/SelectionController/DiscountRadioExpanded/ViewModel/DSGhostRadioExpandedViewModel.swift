//
//  DSGhostRadioExpandedViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/9/2567 BE.
//

import Foundation

/// Struct DSGhostRadioExpandedViewModel
public struct DSGhostRadioExpandedViewModel {
    /// The text to be displayed as the title of the ghost radio option.
    public var title: String
    /// An icon to be displayed on the right side of the component
    public var rightIcon: DSIcons?
    /// An icon to be displayed on the left side of the component
    public var leftIcon: DSIcons?
    
    public init(
        title: String,
        rightIcon: DSIcons? = nil,
        leftIcon: DSIcons? = nil
    ) {
        self.title = title
        self.rightIcon = rightIcon
        self.leftIcon = leftIcon
    }
}
