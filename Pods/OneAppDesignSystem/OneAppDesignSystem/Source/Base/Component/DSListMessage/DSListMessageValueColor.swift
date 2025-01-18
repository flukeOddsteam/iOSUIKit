//
//  DSListMessageValueColor.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/10/24.
//

import UIKit

public enum DSListMessageValueColor {
    case navy
    case red
    case green
}

extension DSListMessageValueColor {
    var textColor: UIColor {
        switch self {
        case .navy:
            return DSColor.componentLightDefault
        case .red:
            return DSColor.componentLightOutcome
        case .green:
            return DSColor.componentLightIncome
        }
    }
}
