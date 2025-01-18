//
//  DSDropdownFilterDelegate.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/11/2566 BE.
//  Copyright © 2566 BE TTB. All rights reserved.
//

import Foundation

/// Delegate for DSDropdownFilter
public protocol DSDropdownFilterDelegate: AnyObject {
    func dropdown(_ view: DSDropdownFilter, didSelectAt index: Int, withTagId id: Int)
    func dropdownDidTapped(_ view: DSDropdownFilter, withTagId id: Int)
    func dropdownDidCancel(_ view: DSDropdownFilter, withTagId id: Int)
    func dropdownDidFilter(
        _ view: DSDropdownFilter,
        filteredText: String?,
        filteredItem: ListActionIconViewModel,
        withTagId id: Int
    ) -> Bool
}

public extension DSDropdownFilterDelegate {
    func dropdownDidTapped(_ view: DSDropdownFilter, withTagId id: Int) { }

    func dropdownDidCancel(_ view: DSDropdownFilter, withTagId id: Int) { }

    func dropdownDidFilter(
        _ view: DSDropdownFilter,
        filteredText: String?,
        filteredItem: ListActionIconViewModel,
        withTagId id: Int
    ) -> Bool {
        guard let filteredText = filteredText,
              filteredText.isNotEmpty
        else {
            return true
        }
        return filteredItem.text.range(
            of: filteredText,
            options: [
                .caseInsensitive,
                    .diacriticInsensitive
            ]
        ) != nil
    }
}
