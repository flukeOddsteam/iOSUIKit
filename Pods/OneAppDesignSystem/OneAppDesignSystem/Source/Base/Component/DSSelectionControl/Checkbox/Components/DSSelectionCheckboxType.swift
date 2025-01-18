//
//  DSSelectionCheckboxType.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/5/2567 BE.
//

import UIKit

/// Enum DSSelectionCheckbox type
public enum DSSelectionCheckboxType {
    /// Default type of DSSelectionCheckbox.
    case `default`
    /// Soft label type of DSSelectionCheckbox.
    case softLabel
}

protocol SelectionCheckboxTypeAppearance {
    var titleSize: UIFont? { get }
}

extension DSSelectionCheckboxType: SelectionCheckboxTypeAppearance {
    var titleSize: UIFont? {
        switch self {
        case .default:
            return DSFont.placeholder
        case .softLabel:
            return DSFont.subtitle
        }
    }
}
