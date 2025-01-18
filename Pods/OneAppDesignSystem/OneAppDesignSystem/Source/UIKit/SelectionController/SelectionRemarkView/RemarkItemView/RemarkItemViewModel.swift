//
//  RemarkItemViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 30/8/2567 BE.
//

import Foundation

public struct RemarkItemViewModel {
    var title: String
    var isShowBullet: Bool
    
    public init(title: String, isShowBullet: Bool) {
        self.title = title
        self.isShowBullet = isShowBullet
    }
}
