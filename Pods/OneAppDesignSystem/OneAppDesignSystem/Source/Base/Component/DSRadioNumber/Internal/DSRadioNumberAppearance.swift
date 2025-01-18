//
//  DSRadioNumberAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/12/2565 BE.
//

import UIKit

protocol DSRadioNumberAppearance {
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
}

extension DSRadioNumberState: DSRadioNumberAppearance {
    var textColor: UIColor {
        switch self {
        case .`default`:
            return DSColor.componentLightDesc
        case .selected, .onPress:
            return DSColor.componentPrimaryDefault
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .`default`:
            return DSColor.componentPrimaryDefault
        case .onPress:
            return DSColor.componentPrimaryBackgroundOnPress
        case .selected:
            return DSColor.componentPrimaryBackground
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .`default`:
            return DSColor.componentLightOutline
        case .selected, .onPress:
            return UIColor.clear
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .`default`:
            return 1
        case .selected, .onPress:
            return 0
        }
    }
}
