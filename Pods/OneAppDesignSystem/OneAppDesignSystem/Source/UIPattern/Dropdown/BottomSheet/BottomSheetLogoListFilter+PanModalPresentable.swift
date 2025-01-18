//
//  BottomSheetLogoListFilter+PanModalPresentable.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/5/24.
//

import UIKit

extension BottomSheetLogoListFilter: PanModalPresentable {

    func panModalWillDismiss() {
        delegate?.bottomSheetWillDismiss(self)
    }

    func panModalDidDismiss() {
        delegate?.bottomSheetDidDismiss(self)
    }

    var cornerRadius: CGFloat {
        DSRadius.radius24px.rawValue
    }

    var showDragIndicator: Bool {
        false
    }

    var isUserInteractionEnabled: Bool {
        true
    }

    var panScrollable: UIScrollView? {
        tableView
    }

    var shortFormHeight: PanModalHeight {
        .maxHeight
    }

    var longFormHeight: PanModalHeight {
        .maxHeight
    }

    var anchorModalToLongForm: Bool {
        true
    }

    var panModalBackgroundColor: UIColor {
        DSColor.otherBackgroundOverlayScreen
    }

    var topOffset: CGFloat {
        UIApplication.getStatusBarFrame().height + 16
    }
}
