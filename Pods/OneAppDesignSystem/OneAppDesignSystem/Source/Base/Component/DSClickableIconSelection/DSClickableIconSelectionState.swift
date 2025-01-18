//
//  DSClickableIconSelectionState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/3/2566 BE.
//

import UIKit

public enum DSClickableIconSelectionState {
    case `default`
    case activated
    case selected
}

protocol ClickableIconSelectionAppearance {
    var defaultBackgroundColor: UIColor { get }
    var defaultBorderWidth: CGFloat { get }
    var onPressedBackgroundColor: UIColor { get }
    var onPressedBorderWidth: CGFloat { get }
    var isShowSelectedView: Bool { get }
    
    func defaultBorderColor(shape: DSClickableIconSelectionShape) -> UIColor
    func onPressedBorderColor(shape: DSClickableIconSelectionShape) -> UIColor
}

extension DSClickableIconSelectionState: ClickableIconSelectionAppearance {
    var defaultBackgroundColor: UIColor {
        DSColor.componentLightBackground
    }
    
    var defaultBorderWidth: CGFloat {
        switch self {
        case .default:
            return 1
        case .activated, .selected:
            return 2
        }
    }
    
    func defaultBorderColor(shape: DSClickableIconSelectionShape) -> UIColor {
        switch self {
        case .default:
            if shape == .rectangle {
                return DSColor.componentLightOutlineSecondary
            }
            return DSColor.componentLightOutlineClickable
        case .activated, .selected:
            return DSColor.componentLightOutlineActive
        }
    }
    
    var onPressedBackgroundColor: UIColor {
        DSColor.componentLightBackgroundOnPress
    }
    
    var onPressedBorderWidth: CGFloat {
        switch self {
        case .default:
            return 1
        case .activated, .selected:
            return 2
        }
    }
    
    func onPressedBorderColor(shape: DSClickableIconSelectionShape) -> UIColor {
        switch self {
        case .default:
            if shape == .rectangle {
                return DSColor.componentLightOutlineSecondary
            }
            return DSColor.componentLightOutlineClickable
        case .activated, .selected:
            if shape == .rectangle {
                return DSColor.componentLightOutlineActiveOnPress
            }
            return DSColor.componentPrimaryBackgroundOnPress
        }
    }
    
    var disableBackgroundColor: UIColor {
        return DSColor.componentDisableOutline
    }
    
    var isShowSelectedView: Bool {
        switch self {
        case .default, .activated:
            return false
        case .selected:
            return true
        }
    }
}
