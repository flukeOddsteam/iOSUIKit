//
//  DSFilterPillViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 19/4/2566 BE.
//

import Foundation

public struct DSFilterPillViewModel {
    var title: String
    var state: DSFilterPillState
    var isDisplayRemoveIcon: Bool
    
    public init(title: String, state: DSFilterPillState, isDisplayRemoveIcon: Bool) {
        self.title = title
        self.state = state
        self.isDisplayRemoveIcon = state == .active ? isDisplayRemoveIcon : false
    }
}
