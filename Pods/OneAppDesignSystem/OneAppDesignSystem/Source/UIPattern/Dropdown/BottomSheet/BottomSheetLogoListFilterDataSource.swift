//
//  BottomSheetLogoListFilterDataSource.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/5/24.
//

protocol BottomSheetLogoListFilterDataSource: AnyObject {

    /// Implement for provide all items
    func items(
        for bottomSheet: BottomSheetLogoListFilter
    ) -> [BottomSheetLogoListFilterItem]

    /// Implement for provide filtered item
    ///
    /// This method call when reload data with search text
    func items(
        for bottomSheet: BottomSheetLogoListFilter,
        filter text: String
    ) -> [BottomSheetLogoListFilterItem]
}
