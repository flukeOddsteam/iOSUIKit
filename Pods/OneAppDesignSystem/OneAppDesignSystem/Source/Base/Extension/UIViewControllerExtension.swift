//
//  UIViewControllerExtension.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/3/2567 BE.
//

import UIKit

extension UIViewController {
    func presentBottomSheet(viewController: PanModalPresentable.LayoutType) {
        if let navigationController {
            navigationController.presentPanModal(viewController)
        } else {
            presentPanModal(viewController)
        }
    }
}
