//
//  DSCommonPaymentValueRadioState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/11/2567 BE.
//

import UIKit

public enum DSCommonPaymentValueRadioStyle {
    case general
    case cashBack
    case discount
    
    var color: UIColor {
        switch self {
        case .general:
            return DSColor.componentLightDefault
        case .cashBack:
            return DSColor.componentLightIncome
        case .discount:
            return DSColor.componentLightOutcome
        }
    }
}
