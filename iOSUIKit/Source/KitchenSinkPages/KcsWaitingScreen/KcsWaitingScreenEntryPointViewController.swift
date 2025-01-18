//
//  KcsWaitingScreenEntryPointViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/4/2567 BE.
//

import UIKit
import OneAppDesignSystem

final class KcsWaitingScreenEntryPointViewController: UIViewController {
    @IBOutlet weak var navBar: DSNavBar!
    @IBOutlet weak var listAction: DSListActionView!

    private var viewModels = KcsWaitingScreenEntryPointMenu.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupListAction()
    }
}
// MARK: - ListActionViewDelegate
extension KcsWaitingScreenEntryPointViewController: ListActionViewDelegate {
    func listActionView(_ view: DSListActionView, didSelectRowAt index: Int) {
        let menu = viewModels[index]
        let viewController = KcsWaitingScreenViewController(
            nibName: "KcsWaitingScreenViewController",
            bundle: .dsBundle
        )

        viewController.entryPointMenu = menu

        navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
}

// MARK: - DSNavBarDelegate
extension KcsWaitingScreenEntryPointViewController: DSNavBarDelegate {
    func navBarBackButtonDidTapped(_ view: DSNavBar) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension KcsWaitingScreenEntryPointViewController {
    func setupNavigationBar() {
        navBar.setup(title: "Waiting Screen", style: .backButtonOnly, theme: .light)
        navBar.delegate = self
    }

    func setupListAction() {
        listAction.setup(style: .listActionIcons(viewModels: viewModels.map {
            ListActionIconViewModel(text: $0.title, rightIcon: DSIcons.icon24OutlineChevronRight)
        }))

        listAction.delegate = self
    }
}

enum KcsWaitingScreenEntryPointMenu: Int, CaseIterable {
    case `internal`
    case external

    var title: String {
        switch self {
        case .internal:
            return "Internal"
        case .external:
            return "External"
        }
    }
}
