//
//  DSClickableIconGeneralStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2566 BE.
//

import UIKit

public enum DSClickableIconGeneralStyle {
    case light
    case dark
}

extension DSClickableIconGeneralStyle {
    var textColor: UIColor {
        switch self {
        case .light:
            return DSColor.componentLightDefault
        case .dark:
            return DSColor.pageLightBackground
        }
    }
}
