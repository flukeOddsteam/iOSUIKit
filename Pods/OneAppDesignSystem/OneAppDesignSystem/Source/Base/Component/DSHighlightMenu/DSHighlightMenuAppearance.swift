//
//  DSHighlightMenuAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/9/2567 BE.
//

import UIKit

protocol DSHighlightMenuAppearance {
    var imageSize: CGFloat { get }
    var backgroundColor: UIColor { get }
    var isShadowHidden: Bool { get }
    var textSpacing: CGFloat { get }
}

extension DSHighlightMenuType {
    var imageSize: CGFloat {
        switch self {
        case .image:
            return 48.0
        case .icon:
            return 24.0
        }
    }
    
    var textSpacing: CGFloat {
        switch self {
        case .image:
            return 16.0
        case .icon:
            return 8.0
        }
    }
}

extension DSHighlightMenuState {
    var backgroundColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightBackground
        case .onPress:
            return DSColor.componentLightBackgroundOnPress
        }
    }
    
    var isShadowHidden: Bool {
        switch self {
        case .default:
            return true
        case .onPress:
            return false
        }
    }
}

struct DSHighlightMenuAppearanceImplement: DSHighlightMenuAppearance {
    
    let type: DSHighlightMenuType
    let state: DSHighlightMenuState
    
    var imageSize: CGFloat {
        return type.imageSize
    }
    
    var textSpacing: CGFloat {
        return type.textSpacing
    }
    
    var backgroundColor: UIColor {
        return state.backgroundColor
    }
    
    var isShadowHidden: Bool {
        return state.isShadowHidden
    }
}
