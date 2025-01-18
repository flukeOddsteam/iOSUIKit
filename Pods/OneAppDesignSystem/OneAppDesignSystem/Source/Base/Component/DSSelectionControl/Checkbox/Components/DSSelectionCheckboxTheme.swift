//
//  DSSelectionCheckboxTheme.swift
//  OneAppDesignSystem
//
//  Created by ttb on 21/5/2567 BE.
//

import UIKit

/// Enum DSSelectionCheckbox type
public enum DSSelectionCheckboxTheme {
    /// Light theme of DSSelectionCheckbox.
    case light
    /// Dark theme of DSSelectionCheckbox.
    case dark
}

protocol SelectionCheckboxThemeAppearance {
    var backgroundColor: UIColor { get }
}

extension DSSelectionCheckboxTheme: SelectionCheckboxThemeAppearance {
    var backgroundColor: UIColor {
        switch self {
        case .light:
            return DSColor.componentLightBackground
        case .dark:
            return DSColor.pageDarkBackground
        }
    }
}
