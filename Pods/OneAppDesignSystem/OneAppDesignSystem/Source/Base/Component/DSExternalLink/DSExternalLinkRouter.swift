//
//  DSExternalLinkRouter.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/4/2566 BE.
//

import UIKit

protocol DSExternalLinkRouterProtocol {
    func dismiss(completion: @escaping () -> Void)
}

struct DSExternalLinkRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - DSExternalLinkRouterProtocol
extension DSExternalLinkRouter: DSExternalLinkRouterProtocol {
    func dismiss(completion: @escaping () -> Void) {
        viewController?.dismiss(animated: true, completion: completion)
    }
}
