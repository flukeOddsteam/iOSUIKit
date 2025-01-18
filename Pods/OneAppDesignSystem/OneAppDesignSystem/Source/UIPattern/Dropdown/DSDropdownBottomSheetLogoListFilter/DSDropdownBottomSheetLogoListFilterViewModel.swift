//
//  DSDropdownBottomSheetLogoListFilterViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/5/24.
//

public struct DSDropdownBottomSheetLogoListFilterViewModel {
    public let tagId: Int
    public let title: String

    /// Displayed text on the dropdown as a selected value
    ///
    /// After inital the dropdown, use ``DSDropdownBottomSheetLogoListFilter/set(text:)``
    /// to update displayed text.
    ///
    /// The user of the dropdown have to make sure that the data provided
    /// to ``DSDropdownBottomSheetLogoListFilterDataSource/data(for:filter:)``
    /// and display text keep in sync by update its data model and displayed
    /// text. otherwise the dropdown will show the incorrect selected state
    public let text: String
    public let helperText: String?
    public let state: DSDropdownBottomSheetLogoListFilterState
    public let bottomSheet: DSBottomSheetLogoListFilterViewAppearance

    public init(
        tagId: Int,
        title: String,
        text: String,
        helperText: String?,
        state: DSDropdownBottomSheetLogoListFilterState,
        bottomSheet: DSBottomSheetLogoListFilterViewAppearance
    ) {
        self.tagId = tagId
        self.title = title
        self.text = text
        self.helperText = helperText
        self.state = state
        self.bottomSheet = bottomSheet
    }
}
