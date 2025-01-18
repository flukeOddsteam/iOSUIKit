//
//  DSClickableIconGeneralIconTheme.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/2/2567 BE.
//

import UIKit

public enum DSClickableIconGeneralIconTheme {
    case light
    case dark
}

extension DSClickableIconGeneralIconTheme {
    var highlightBackground: UIColor {
        switch self {
        case .light:
            return DSColor.componentLightBackgroundOnPress
        case .dark:
            return DSColor.componentDarkBackgroundOnPress
        }
    }

    var defaultBackground: UIColor {
        return .clear
    }

    var iconActiveTintColor: UIColor {
        switch self {
        case .light:
            return DSColor.componentLightDefault
        case .dark:
            return DSColor.componentDarkDefault
        }
    }

    var iconDisableTintColor: UIColor {
        return DSColor.componentDisableDefault
    }
}
