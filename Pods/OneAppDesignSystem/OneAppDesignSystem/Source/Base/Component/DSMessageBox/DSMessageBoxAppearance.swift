//
//  DSMessageBoxAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/12/22.
//

import UIKit

protocol DSMessageBoxAppearance {
    var borderColor: UIColor { get }
    var iconColor: UIColor { get }
    var iconImage: UIImage { get }
    var backgroundColor: UIColor { get }
}

extension DSMessageBoxStyle: DSMessageBoxAppearance {
    var borderColor: UIColor {
        switch self {
        case .error:
            return DSColor.componentErrorOutlineIcon
        case .warning:
            return DSColor.componentWarningOutlineIcon
        case .informative:
            return DSColor.componentinformativeOutlineIcon
        }
    }
    
    var iconColor: UIColor {
        switch self {
        case .error:
            return DSColor.componentErrorOutlineIcon
        case .warning:
            return DSColor.componentWarningOutlineIcon
        case .informative:
            return DSColor.componentinformativeOutlineIcon
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .error:
            return DSIcons.icon24OutlineInfo.image
        case .warning:
            return DSIcons.icon24OutlineInfo.image
        case .informative:
            return DSIcons.icon24OutlineInfo.image
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .error:
            return DSColor.componentErrorBackground
        case .warning:
            return DSColor.componentWarningBackground
        case .informative:
            return DSColor.componentinformativeBackground
        }
    }
}
