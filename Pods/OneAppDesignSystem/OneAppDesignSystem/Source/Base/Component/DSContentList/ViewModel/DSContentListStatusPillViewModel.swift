//
//  DSContentListStatusPillViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import Foundation

public struct DSContentListStatusPillViewModel {
    public var style: DSPillStatusStyle
    public var title: String
    
    public init(style: DSPillStatusStyle, title: String) {
        self.title = title
        self.style = style
    }
}
