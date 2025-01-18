//
//  DSTabBarConfiguration.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/10/2567 BE.
//

import Foundation

public struct DSTabBarConfiguration {
    public let isUseContentLayout: Bool

    public init(isUseContentLayout: Bool) {
        self.isUseContentLayout = isUseContentLayout
    }

    public static let `default` = DSTabBarConfiguration(isUseContentLayout: true)
}
