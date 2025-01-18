//
//  DSSelectItem.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/11/2566 BE.
//

import Foundation
/// Struct is used to store data of SelectedItem for DSDropdown field
public struct SelectedItem {
    public let text: String
    public let selectedIndex: Int?

    public init(text: String, selectedIndex: Int?) {
        self.text = text
        self.selectedIndex = selectedIndex
    }
}
