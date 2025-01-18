//
//  DSBottomSheetListActionIconValueModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/11/2566 BE.
//

import Foundation

public struct DSBottomSheetListActionIconValueViewModel {
    public var title: String
    public var leftIcon: DSIcons?
    public var selectedIndex: Int?
    public var listItem: [DSListActionIconValueViewModel] = []
    
    public init(
        title: String,
        leftIcon: DSIcons? = nil,
        selectedIndex: Int? = nil,
        listItem: [DSListActionIconValueViewModel] = []
    ) {
        self.title = title
        self.leftIcon = leftIcon
        self.selectedIndex = selectedIndex
        self.listItem = listItem
    }
}
