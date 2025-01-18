//
//  RadioExpandedAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/9/2567 BE.
//

import UIKit

enum RadioExpandedState {
    case `default`
    case selected
    case disable
}

protocol RadioExpandedAppearance {
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
}

extension RadioExpandedState: RadioExpandedAppearance {
    var borderColor: UIColor {
        switch self {
        case .default, .disable:
            return DSColor.componentLightOutlinePrimary
        case .selected:
            return DSColor.componentGhostDefault
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .default, .disable:
            return 1.0
        case .selected:
            return 2.0
        }
    }
}
