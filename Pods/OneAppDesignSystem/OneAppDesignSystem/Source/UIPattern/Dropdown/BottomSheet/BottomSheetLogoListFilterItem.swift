//
//  BottomSheetLogoListFilterItem.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/5/24.
//

enum BottomSheetLogoListFilterItem {
    case header(text: String)
    case divider
    /// Grid based layout with ``DSClickableSelection`` for each item
    ///
    /// Currently, each row will have 4 items.
    /// See ``LogoTableViewCell``
    case logo(items: [DSBottomSheetLogoListFilterItemLogoDisplayable])
    case action(item: DSBottomSheetLogoListFilterItemLabelDisplayable)
}

public protocol DSBottomSheetLogoListFilterItemLabelDisplayable {
    var id: String { get }
    var label: String { get }
    var isSelected: Bool { get }
}

public protocol DSBottomSheetLogoListFilterItemLogoDisplayable: DSBottomSheetLogoListFilterItemLabelDisplayable {
    var imageURL: String { get }
}
