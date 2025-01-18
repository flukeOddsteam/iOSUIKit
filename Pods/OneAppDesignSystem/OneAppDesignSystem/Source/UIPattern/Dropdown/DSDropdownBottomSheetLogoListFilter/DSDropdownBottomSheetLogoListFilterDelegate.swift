//
//  DSDropdownBottomSheetLogoListFilterDelegate.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/5/24.
//

/// Delegate protocol for handle dropdown events
public protocol DSDropdownBottomSheetLogoListFilterDelegate: AnyObject {

    /// Implement to handle tap event when user tap on the dropdown
    /// 
    /// Usually, the implementation is prepare dataSource and then
    /// calling dropdown to open the bottom sheet screen with
    /// ``DSDropdownBottomSheetLogoListFilter/presentBottomSheetDropdown()``
    func dropdownDidTap(_ dropdown: DSDropdownBottomSheetLogoListFilter)

    /// Implement to handle select event when user select the item
    /// on the bottom sheet screen
    ///
    /// Normally, the implementation is to validate selected value, update
    /// data model, and then update the dropdown state.
    ///
    /// Use ``DSDropdownBottomSheetLogoListFilter/set(text:)`` to update
    /// dropdown displayed text.
    /// Use ``DSDropdownBottomSheetLogoListFilter/updateLayout(state:isAnimate:)``
    /// to update the dropdown state, e.g. ``DSDropdownBottomSheetLogoListFilterState/selected``,
    /// ``DSDropdownBottomSheetLogoListFilterState/error(message:)``.
    func dropdown(
        _ dropdown: DSDropdownBottomSheetLogoListFilter,
        didSelect item: DSBottomSheetLogoListFilterItemLabelDisplayable
    )

    /// Implement to handle when the bottom sheet start dismissing
    ///
    /// When user not select the item and dismiss the bottom sheet,
    /// the dropdown will restore state to its prevoius state before
    /// calling this method
    ///
    /// see [stateBeforeFocus](x-source-tag://stateBeforeFocus)
    func dropdownWillDismiss(_ dropdown: DSDropdownBottomSheetLogoListFilter)

    /// Implement to handle when the bottom sheet dismissed
    func dropdownDidDismiss(_ dropdown: DSDropdownBottomSheetLogoListFilter)
}

public extension DSDropdownBottomSheetLogoListFilterDelegate {
    func dropdownWillDismiss(_ dropdown: DSDropdownBottomSheetLogoListFilter) {}
    func dropdownDidDismiss(_ dropdown: DSDropdownBottomSheetLogoListFilter) {}
}
