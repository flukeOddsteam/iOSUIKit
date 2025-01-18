//
//  DSBottomSheetMenuListMessageViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/2/23.
//

import UIKit

public struct DSBottomSheetMenuListMessageViewModel {
    var title: String
    var listItem: [DSBottomSheetMenuListMessageItem] = []
    
    public init(title: String,
                listItem: [DSBottomSheetMenuListMessageItem] = []) {
        self.title = title
        self.listItem = listItem
    }
}

public struct DSBottomSheetMenuListMessageItem {
    var icon: DSIcons?
    var title: String
    
    public init(icon: DSIcons? = DSIcons.icon24OutlinePlaceholder, title: String) {
        self.icon = icon
        self.title = title
    }
}
