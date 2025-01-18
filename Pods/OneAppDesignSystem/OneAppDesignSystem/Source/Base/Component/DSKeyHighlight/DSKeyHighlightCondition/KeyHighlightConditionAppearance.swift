//
//  KeyHighlightConditionAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/9/2567 BE.
//

import UIKit

protocol KeyHighlightConditionAppearance {
    var iconColor: UIColor { get }
    var titleColor: UIColor { get }
}

extension DSKeyHighlightConditionState: KeyHighlightConditionAppearance {
    var iconColor: UIColor {
        switch self {
        case .correct:
            return DSColor.componentLightSuccess
        case .incorrect:
            return DSColor.componentLightError
        case .waiting:
            return DSColor.componentDisableDefault
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .correct:
            return DSColor.componentLightLabel
        case .incorrect:
            return DSColor.componentLightError
        case .waiting:
            return DSColor.componentLightLabelXSoft
        }
    }
}
