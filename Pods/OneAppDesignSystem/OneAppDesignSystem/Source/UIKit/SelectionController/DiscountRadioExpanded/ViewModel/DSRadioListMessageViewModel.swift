//
//  DSRadioListMessageViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/9/2567 BE.
//

import Foundation

/// Struct DSRadioListMessageViewModel
public struct DSRadioListMessageViewModel {
    /// The type of the list message (small or accent)
    public var type: ListMessageType
    /// The view model containing the content of the list item
    public var viewModel: ListItemViewModel
    
    public init(
        type: ListMessageType,
        viewModel: ListItemViewModel
    ) {
        self.type = type
        self.viewModel = viewModel
    }
}

extension DSRadioListMessageViewModel {
    public enum ListMessageType {
        case small
        case accent
    }
    
    public struct ListItemViewModel {
        public var title: String
        public var value: String
        public var subValue: String?
        public var ratio: CGFloat
        
        public init(
            title: String,
            value: String,
            subValue: String? = nil,
            ratio: CGFloat = 1.0
        ) {
            self.title = title
            self.value = value
            self.subValue = subValue
            self.ratio = ratio
        }
    }
}
