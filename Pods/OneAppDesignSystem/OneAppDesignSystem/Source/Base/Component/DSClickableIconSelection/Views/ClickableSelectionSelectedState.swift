//
//  ClickableSelectionSelectedState.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 8/3/2566 BE.
//

import UIKit

enum ClickableSelectionSelectedState {
    case `default`
    case onPressed
    case disable
}

protocol ClickableSelectionSelectedAppearance {
    var backgroundColor: UIColor { get }
}

// MARK: - ClickableSelectionSelectedAppearance
extension ClickableSelectionSelectedState: ClickableSelectionSelectedAppearance {
    var backgroundColor: UIColor {
        switch self {
        case .default:
            return DSColor.componentLightOutlineActive
        case .onPressed:
            return DSColor.componentPrimaryBackgroundOnPress
        case .disable:
            return DSColor.componentDisableOutline
        }
    }
}
