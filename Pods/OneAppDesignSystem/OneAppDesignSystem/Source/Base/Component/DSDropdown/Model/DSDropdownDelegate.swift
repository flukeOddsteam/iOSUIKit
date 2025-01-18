//
//  DSDropdownDelegate.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/11/2566 BE.
//

import UIKit

/// Delegate for DSDropdown
public protocol DSDropdownDelegate: AnyObject {
    func dropdown(_ view: DSDropdown, didSelectAt index: Int, withTagId id: Int)
    func dropdownDidTapped(_ view: DSDropdown, withTagId id: Int)
    func dropdownDidCancel(_ view: DSDropdown, withTagId id: Int)
}

public extension DSDropdownDelegate {
    func dropdownDidTapped(_ view: DSDropdown, withTagId id: Int) { }
    func dropdownDidCancel(_ view: DSDropdown, withTagId id: Int) { }
}
