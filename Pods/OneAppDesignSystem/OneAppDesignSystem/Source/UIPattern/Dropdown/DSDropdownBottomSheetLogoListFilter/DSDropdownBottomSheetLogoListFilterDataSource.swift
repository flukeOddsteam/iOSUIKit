//
//  DSDropdownBottomSheetLogoListFilterDataSource.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/5/24.
//

/// DataSource protocol for dropdown
public protocol DSDropdownBottomSheetLogoListFilterDataSource: AnyObject {

    /// Implement for provide dropdown item.
    /// 
    /// - Parameters:
    ///   - dropdown: dropdown that ask the data from the dataSource
    ///   - text: filter text from the search textfield
    ///
    /// Dropdown will ask data for checking if it have the item when
    /// calling ``DSDropdownBottomSheetLogoListFilter/presentBottomSheetDropdown()``
    /// and when dropdown layout the bottom sheet screen
    ///
    /// Using filter `text` to filter and return the data
    func data(
        for dropdown: DSDropdownBottomSheetLogoListFilter,
        filter text: String
    ) -> DSDropdownBottomSheetLogoListFilterData?
}

/// Class for holding data for display as a selectable item on
/// the bottom sheet dropdown
///
/// Support two sections.
/// - LogoSection: for grid layout with ``DSClickableSelection``
/// - ListSection: for normal list item as a ``DSListActionIconTableViewCell``
///
/// Each section will contain title and items. The item will identify
/// by its `id`. See ``DSBottomSheetLogoListFilterItemLogoDisplayable``
///
/// This class provide the default filtered method for using by the
/// ``DSDropdownBottomSheetLogoListFilterDataSource/data(for:filter:)``
/// which will return only ListSection and filtered by checking if
/// the item label contain the filter text case insensitive.
///
/// Inherite this class and override filtered method if need the
/// different filter behaviour
open class DSDropdownBottomSheetLogoListFilterData {

    /// Grid based selectable item with logo image and label
    public var logoSection: DSBottomSheetLogoListFilterSection?

    /// List based selectable item with only label
    public var listSection: DSBottomSheetLogoListFilterSection?

    public init(
        logoSection: DSBottomSheetLogoListFilterSection?,
        listSection: DSBottomSheetLogoListFilterSection?
    ) {
        self.logoSection = logoSection
        self.listSection = listSection
    }

    /// First selected item from both logoSection and listSection consecutively
    public var selectedItem: DSBottomSheetLogoListFilterItemLogoDisplayable? {
        [
            logoSection.map { $0.selectedItems },
            listSection.map { $0.selectedItems }
        ]
        .compactMap { $0 }
        .flatMap { $0 }
        .first
    }

    /// Default filtered method for using by the
    /// ``DSDropdownBottomSheetLogoListFilterDataSource/data(for:filter:)``
    /// which will return only ListSection and filtered by checking if
    /// the item label contain the filter text case insensitive.
    ///
    /// Inherite this class and override filtered method if need the
    /// different filter behaviour
    open func filtered(_ text: String) -> DSDropdownBottomSheetLogoListFilterData {
        DSDropdownBottomSheetLogoListFilterData(
            logoSection: logoSection.map { section in
                DSBottomSheetLogoListFilterSection(
                    title: section.title,
                    items: text == "" ? section.items : []
                )
            },
            listSection: listSection.map { section in
                DSBottomSheetLogoListFilterSection(
                    title: section.title,
                    items: section.items.filter {
                        text == "" || $0.label.range(of: text, options: .caseInsensitive) != nil
                    }
                )
            }
        )
    }
}

open class DSBottomSheetLogoListFilterSection {
    public var title: String
    public var items: [DSBottomSheetLogoListFilterItemLogoDisplayable]

    public var selectedItems: [DSBottomSheetLogoListFilterItemLogoDisplayable] {
        items.filter { $0.isSelected }
    }

    public init(
        title: String,
        items: [DSBottomSheetLogoListFilterItemLogoDisplayable]
    ) {
        self.title = title
        self.items = items
    }
}
