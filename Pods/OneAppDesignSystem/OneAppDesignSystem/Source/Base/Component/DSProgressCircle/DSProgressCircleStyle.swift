//
//  DSProgressCircleStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/3/2566 BE.
//

import UIKit

public enum DSProgressCircleStyle {
    case small
    case medium
    case large
}

protocol ProgressCircleStyleAppearance {
    var titleFont: UIFont? { get }
    var containerSize: CGSize { get }
    var iconSize: CGSize { get }
    var lineWidth: CGFloat { get }
    var contentPadding: CGFloat { get }
    var shouldHiddenIcon: Bool { get }
}

extension DSProgressCircleStyle: ProgressCircleStyleAppearance {
    var titleFont: UIFont? {
        switch self {
        case .small:
            return DSFont.labelInput
        case .medium:
            return DSFont.h3
        case .large:
            return DSFont.h1
        }
    }
    
    var containerSize: CGSize {
        switch self {
        case .small:
            return CGSize(width: 48, height: 48)
        case .medium:
            return CGSize(width: 80, height: 80)
        case .large:
            return CGSize(width: 160, height: 160)

        }
    }
    
    var iconSize: CGSize {
        switch self {
        case .small:
            return .zero
        case .medium:
            return CGSize(width: 36, height: 36)
        case .large:
            return CGSize(width: 48, height: 48)
        }
    }
    
    var shouldHiddenIcon: Bool {
        switch self {
        case .small:
            return true
        case .medium:
            return false
        case .large:
            return false
        }
    }
    
    var lineWidth: CGFloat {
        switch self {
        case .small:
            return 5
        case .medium:
            return 10
        case .large:
            return 16
        }
    }
    
    var contentPadding: CGFloat {
        switch self {
        case .small:
            return 5
        case .medium:
            return 10
        case .large:
            return 30
        }
    }
}
