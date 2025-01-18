//
//  DSDropdownAccessibility.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/11/2566 BE.
//

import Foundation
/// Enum DSDropdown style
public enum DSDropdownStlyeAccessibilityIdentifier {
    case normal(titleLabelId: String, textFieldId: String)
    case account(accountTitleLabelId: String,
                 accountFirstLabelId: String,
                 accountSecondLabelId: String,
                 accountThirdLabelId: String)
    case actionIconValue(titleLabelId: String, textFieldId: String)
}
