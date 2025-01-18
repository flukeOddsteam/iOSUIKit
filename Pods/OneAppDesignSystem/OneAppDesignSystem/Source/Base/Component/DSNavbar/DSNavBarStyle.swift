//
//  DSNavBarStype.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/4/2566 BE.
//

import UIKit

public enum DSNavBarStyle {
    case titleOnly
    case backButtonOnly
    case closeButtonOnly
    case backButtonWithSingleClickable(icon: UIImage)
    case backButtonWithMultipleClickable(primaryIcon: UIImage, secondaryIcon: UIImage, isHideBackButton: Bool? = false)
    case backButtonWithGhost(title: String)
}

extension DSNavBarStyle {
    var isBackButtonHidden: Bool {
        switch self {
        case .closeButtonOnly, .titleOnly:
            return true
        case .backButtonWithMultipleClickable(_, _, let isHideBackButton):
            return isHideBackButton ?? false
        default:
            return false
        }
    }
    
    var isPrimaryIconHidden: Bool {
        switch self {
        case .backButtonWithSingleClickable, .backButtonWithMultipleClickable:
            return false
        default:
            return true
        }
    }
    
    var isSecondaryIconHidden: Bool {
        switch self {
        case .backButtonWithMultipleClickable:
            return false
        default:
            return true
        }
    }
    
    var isCloseButtonHidden: Bool {
        switch self {
        case .closeButtonOnly:
            return false
        default:
            return true
        }
    }
    
    var isGhostButtonHidden: Bool {
        switch self {
        case .backButtonWithGhost:
            return false
        default:
            return true
        }
    }

    var isRightStackViewHidden: Bool {
        switch self {
        case .titleOnly:
            return true
        default:
            return false
        }
    }

    var leftContainerViewHidden: Bool {
        switch self {
        case .titleOnly:
            return true
        default:
            return false
        }
    }
}
