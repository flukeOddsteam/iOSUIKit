//
//  DSBottomSheetMenuListDescriptionViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/3/2566 BE.
//

import UIKit

public struct DSBottomSheetMenuListDescriptionViewModel {
    public let title: String
    public let description: String?
    public let imageStyle: DSBottonSheetMenuListDescriptionImageStyle
    
    public init(title: String,
                description: String? = nil,
                imageStyle: DSBottonSheetMenuListDescriptionImageStyle) {
        self.title = title
        self.description = description
        self.imageStyle = imageStyle
    }
}
