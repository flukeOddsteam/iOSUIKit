//
//  BottomSheetLogoListFilterDelegate.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/5/24.
//

protocol BottomSheetLogoListFilterDelegate: AnyObject {
    func bottomSheetWillDismiss(_ viewController: BottomSheetLogoListFilter)
    func bottomSheetDidDismiss(_ viewController: BottomSheetLogoListFilter)
    func bottomSheet(
        _ viewController: BottomSheetLogoListFilter,
        didSelect item: DSBottomSheetLogoListFilterItemLabelDisplayable
    )
}

extension BottomSheetLogoListFilterDelegate {
    func bottomSheetWillDismiss(_ viewController: BottomSheetLogoListFilter) {}
    func bottomSheetDidDismiss(_ viewController: BottomSheetLogoListFilter) {}
    func bottomSheet(
        _ viewController: BottomSheetLogoListFilter,
        didSelect item: DSBottomSheetLogoListFilterItemLabelDisplayable
    ) {}
}
