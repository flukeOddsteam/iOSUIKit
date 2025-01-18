//
//  DSRadioCardButtonViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/12/2566 BE.
//

import Foundation

public struct DSRadioCardButtonViewModel {
    public var title: String
    public var rightIcon: DSIcons?
    public var leftIcon: DSIcons?
    public var action: (() -> Void)?

    public init(
        title: String,
        rightIcon: DSIcons? = nil,
        leftIcon: DSIcons? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.rightIcon = rightIcon
        self.leftIcon = leftIcon
        self.action = action
    }
}
