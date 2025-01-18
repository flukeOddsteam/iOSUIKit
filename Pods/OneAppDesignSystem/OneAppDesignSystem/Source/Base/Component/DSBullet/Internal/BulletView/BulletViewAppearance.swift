//
//  BulletViewAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/1/23.
//

import UIKit

protocol DSBulletViewAppearance {
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var backgroundColor: UIColor { get }
    var circleViewSize: CGFloat { get }
    var contentViewSize: CGFloat { get }
}

extension DSBulletViewStyle: DSBulletViewAppearance {
    var borderColor: UIColor {
        switch self {
        case .primaryNevy, .primaryGrey, .primaryWhite, .remarkGrey, .remarkWhite:
            return .clear
        case .secondary:
            return DSColor.componentSummaryDesc
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .primaryNevy, .primaryGrey, .primaryWhite, .remarkGrey, .remarkWhite:
            return 0
        case .secondary:
            return 1
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .primaryNevy:
            return DSColor.componentSummaryDefault
        case .primaryGrey:
            return DSColor.componentSummaryDesc
        case .primaryWhite:
            return .white
        case .secondary:
            return .clear
        case .remarkGrey:
            return DSColor.componentSummaryDesc
        case .remarkWhite:
            return .white
        }
    }
    
    var circleViewSize: CGFloat {
        switch self {
        case .primaryNevy, .primaryGrey, .primaryWhite, .secondary:
            return 6
        case .remarkGrey, .remarkWhite:
            return 4
        }
    }
    
    var contentViewSize: CGFloat {
        switch self {
        case .primaryNevy, .primaryGrey, .primaryWhite, .secondary:
            return 24
        case .remarkGrey, .remarkWhite:
            return 12
        }
    }
}
