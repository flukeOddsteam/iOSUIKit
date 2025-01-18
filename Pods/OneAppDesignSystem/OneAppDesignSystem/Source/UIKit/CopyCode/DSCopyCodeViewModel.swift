//
//  DSCopyCodeViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 30/9/2567 BE.
//

import Foundation

public struct DSCopyCodeViewModel {
    public var title: String
    public var value: String
    public var ratio: CGFloat
    public var onClick: (() -> Void)?
    
    public init(
        title: String,
        value: String,
        ratio: CGFloat = 1.0,
        onClick: (() -> Void)? = nil
    ) {
        self.title = title
        self.value = value
        self.ratio = ratio
        self.onClick = onClick
    }
}
