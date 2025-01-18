//
//  KcsLandingViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/3/2567 BE.
//

import UIKit
import OneAppDesignSystem

private enum KcsLandingMenu: Int, CaseIterable {
    case uiKit

    var title: String {
        switch self {
        case .uiKit:
            return "UI Kit"
        }
    }

    var viewController: UIViewController.Type {
        switch self {
        case .uiKit:
            return KcsUIKitFlowViewController.self
        }
    }
}

public final class KcsLandingViewController: UIViewController {

    @IBOutlet weak var navBar: DSNavBar!
    @IBOutlet weak var listAction: DSListActionView!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupListAction()
    }
}

// MARK: - ListActionViewDelegate
extension KcsLandingViewController: ListActionViewDelegate {
    public func listActionView(_ view: DSListActionView, didSelectRowAt index: Int) {
        guard let menu = KcsLandingMenu(rawValue: index) else {
            return
        }
        let viewControllerType = menu.viewController

        let scene = viewControllerType.init(nibName: String(describing: viewControllerType.self), bundle: .dsBundle)
        navigationController?.pushViewController(scene, animated: true)
    }
}

// MARK: - DSNavBarDelegate
extension KcsLandingViewController: DSNavBarDelegate {
    public func navBarBackButtonDidTapped(_ view: DSNavBar) {
        navigationController?.popViewController(animated: true)
    }
}

private extension KcsLandingViewController {
    func setupNavigationBar() {
        navBar.setup(
            title: "Kitchensink V.2",
            style: .backButtonOnly,
            theme: .light
        )
        navBar.delegate = self
    }

    func setupListAction() {
        listAction.setup(style: .listActionIcons(viewModels: KcsLandingMenu.allCases.map {
            ListActionIconViewModel(
                text: $0.title,
                rightIcon: DSIcons.icon24OutlineChevronRight
            )
        }))

        listAction.delegate = self
    }
}
