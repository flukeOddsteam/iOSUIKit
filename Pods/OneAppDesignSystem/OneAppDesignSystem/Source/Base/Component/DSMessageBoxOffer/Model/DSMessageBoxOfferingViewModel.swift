//
//  DSMessageBoxOfferingViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/1/2567 BE.
//

import UIKit

public struct DSMessageBoxOfferingViewModel {
    public var title, description, primaryButtonTitle, secondaryButtonTitle: String?
    public var backgroundImage: DSMessageBoxOfferingBackgroundImageType
    
    public init(
        title: String,
        description: String,
        primaryButtonTitle: String? = nil,
        secondaryButtonTitle: String? = nil,
        backgroundImage: DSMessageBoxOfferingBackgroundImageType
    ) {
        self.title = title
        self.description = description
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.backgroundImage = backgroundImage
    }
}
