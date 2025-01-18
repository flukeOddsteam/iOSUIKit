//
//  DSContentListGhostActionModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2565 BE.
//

import Foundation

public struct DSContentListGhostActionModel {
    public var title: String
    public var rightIcon: DSIcons
    
    public init(title: String, rightIcon: DSIcons) {
        self.title = title
        self.rightIcon = rightIcon
    }
}
