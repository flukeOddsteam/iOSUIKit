//
//  TabbarSegmentedButtonState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/9/2565 BE.
//

import UIKit

enum SegmentedStateOfTheme {
    case light(TabBarSegmentedButtonState)
    case dark(TabBarSegmentedButtonState)
}

enum TabBarSegmentedButtonState {
    case `default`
    case highlighted
}

protocol TabBarSegmentedButtonAppearance {
    var backgroundColor: UIColor { get }
    var titleColor: UIColor { get }
}

extension SegmentedStateOfTheme: TabBarSegmentedButtonAppearance {
    var backgroundColor: UIColor {
        switch self {
        case .light(let state):
            switch state {
            case .default:
                return DSColor.componentLightBackground
            case .highlighted:
                return DSColor.componentCustomBackgroundBackgroundInformativeSpecial
            }
        case .dark(let state):
            switch state {
            case .default:
                return DSColor.pageDarkBackground
            case .highlighted:
                return DSColor.componentLightBackground
            }
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .light(let state):
            switch state {
            case .default:
                return DSColor.componentLightDefault
            case .highlighted:
                return DSColor.componentCustomBackgroundDefault
            }
        case .dark(let state):
            switch state {
            case .default:
                return DSColor.pageDarkComponentGhostDefault
            case .highlighted:
                return DSColor.componentLightDefault
            }
        }
    }
}
