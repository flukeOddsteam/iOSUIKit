//
//  RadioViewAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/9/2565 BE.
//

import UIKit

protocol RadioViewAppearance {
	var iconBorderWidth: CGFloat { get }
	var iconBorderColor: UIColor { get }
	var iconBackgroundColor: UIColor { get }
}

extension DSSelectionRadioState: RadioViewAppearance {
	var iconBorderWidth: CGFloat {
		switch self {
		case .default, .disableUnselected:
			return 2
        case .selected, .disableSelected:
			return 5
		}
	}
	
	var iconBorderColor: UIColor {
		switch self {
		case .default:
			return DSColor.componentLightDefault
        case .disableUnselected, .disableSelected:
			return DSColor.componentDisableOutline
		case .selected:
			return DSColor.componentLightOutlineActive
		}
	}
	
	var iconBackgroundColor: UIColor {
		switch self {
		case .default, .selected:
			return DSColor.componentLightBackground
        case .disableUnselected, .disableSelected:
			return DSColor.componentDisableBackground
		}
	}
}
