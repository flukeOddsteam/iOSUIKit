//
//  SelectionRemarkViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 30/8/2567 BE.
//

import Foundation

public struct SelectionRemarkViewModel {
    var title: String
    var isShowBullet: Bool
    var bulletItems: [String]
    
    public init(title: String, isShowBullet: Bool = true, bulletItems: [String]) {
        self.title = title
        self.isShowBullet = isShowBullet
        self.bulletItems = bulletItems
    }
}
