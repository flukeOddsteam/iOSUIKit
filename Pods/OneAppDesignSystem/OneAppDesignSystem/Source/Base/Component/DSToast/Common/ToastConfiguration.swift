//
//  ToastConfiguration.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/11/2565 BE.
//

import UIKit

private enum Constants {
    static let defaultVisibleDuration: TimeInterval = 4
    static let defaultAnimationDuration: TimeInterval = 0.2
}

protocol ToastConfigurationInterface {
    var visibleDuration: TimeInterval { get }
    var animationDuration: TimeInterval { get }
}

struct ToastConfiguration: ToastConfigurationInterface {
    var visibleDuration: TimeInterval
    var animationDuration: TimeInterval
    
    init(visibleDuration: TimeInterval = Constants.defaultVisibleDuration,
         animationDuration: TimeInterval = Constants.defaultAnimationDuration) {
        self.visibleDuration = visibleDuration
        self.animationDuration = animationDuration
    }
}
