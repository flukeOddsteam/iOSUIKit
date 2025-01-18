//
//  BottomSheetDropDownFilterViewModel.swift
//  OneApp
//
//  Created by TTB on 22/11/2566 BE.
//  Copyright © 2566 BE TTB. All rights reserved.
//

import Foundation

public struct DSBottomSheetDropdownFilterViewModel {
    
    public struct DSBottomSheetItem {
        public var icon: DSIcons?
        public var title: String
        public var firstText: String?
        public var secondText: String?
        public var isEmptyItem: Bool = false
        
        public init(icon: DSIcons? = DSIcons.icon36OutlineProductAllFree, title: String, firstText: String?, secondText: String?, isEmptyItem: Bool = false) {
            self.icon = icon
            self.title = title
            self.firstText = firstText
            self.secondText = secondText
            self.isEmptyItem = isEmptyItem
        }
    }

    public struct EmptyViewModel {
        let style: DSEmptyAndErrorStateStyle
        let description: String

        public init(style: DSEmptyAndErrorStateStyle, description: String) {
            self.style = style
            self.description = description
        }
    }
    
    public var title: String
    public var searchTextFieldPlaceholder: String
    public var searchTextFieldTitleToolBar: String
    public var leftIcon: DSIcons?
    public var selectedIndex: Int?
    public var listItem: [DSBottomSheetItem] = []
    public var emptyViewModel: EmptyViewModel
    public var isDisplayMaxHeight: Bool
    
    public init(title: String, searchTextFieldPlaceholder: String, searchTextFieldTitleToolBar: String, leftIcon: DSIcons? = nil, selectedIndex: Int? = nil, listItem: [DSBottomSheetItem] = [], emptyViewModel: EmptyViewModel, isDisplayMaxHeight: Bool = false) {
        self.title = title
        self.searchTextFieldPlaceholder = searchTextFieldPlaceholder
        self.searchTextFieldTitleToolBar = searchTextFieldTitleToolBar
        self.leftIcon = leftIcon
        self.selectedIndex = selectedIndex
        self.listItem = listItem
        self.emptyViewModel = emptyViewModel
        self.isDisplayMaxHeight = isDisplayMaxHeight
    }
}
