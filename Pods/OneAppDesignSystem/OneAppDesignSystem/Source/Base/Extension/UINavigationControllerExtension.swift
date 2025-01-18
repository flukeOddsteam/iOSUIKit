//
//  UINavigationControllerExtension.swift
//  OneAppDesignSystem
//
//  Created by TTB on 11/12/24.
//

import Foundation
import UIKit

// MARK: - Internal UINavigationController
extension UINavigationController {
    func popViewControllerWithHandler(
        animated: Bool = true,
        completion: @escaping () -> Void
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }

    func popToViewControllerHandler(
        viewController: UIViewController,
        animated: Bool = true,
        completion: @escaping () -> Void
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func pushViewControllerHandler(
        viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
