//
//  BottomSheetDropDownViewModel.swift
//  OneApp
//
//  Created by TTB on 31/8/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import Foundation

public struct DSBottomSheetDropdownViewModel {
    
    public struct DSBottomSheetItem {
        public var icon: DSIcons?
        public var title: String
        public var firstText: String?
        public var secondText: String?
        
        public init(icon: DSIcons? = DSIcons.icon36OutlineProductAllFree, title: String, firstText: String?, secondText: String?) {
            self.icon = icon
            self.title = title
            self.firstText = firstText
            self.secondText = secondText
        }
    }
    
    public var title: String
    public var leftIcon: DSIcons?
    public var selectedIndex: Int?
    public var listItem: [DSBottomSheetItem] = []
    
    public init(title: String, leftIcon: DSIcons? = nil, selectedIndex: Int? = nil, listItem: [DSBottomSheetItem] = []) {
        self.title = title
        self.leftIcon = leftIcon
        self.selectedIndex = selectedIndex
        self.listItem = listItem
    }
}
