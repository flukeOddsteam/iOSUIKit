//
//  KcsUIKitFlowViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/5/2567 BE.
//

import UIKit
import OneAppDesignSystem

private enum UIKitMenu: Int, CaseIterable {
    case waitingScreen

    var title: String {
        switch self {
        case .waitingScreen:
            return "Waiting Screen"
        }
    }
    
    var viewController: UIViewController.Type {
        switch self {
        case .waitingScreen:
            return KcsWaitingScreenViewController.self
        }
    }
}

final class KcsUIKitFlowViewController: UIViewController {
    @IBOutlet weak var navBar: DSNavBar!
    @IBOutlet weak var listAction: DSListActionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupListAction()
    }
}

// MARK: - ListActionViewDelegate
extension KcsUIKitFlowViewController: ListActionViewDelegate {
    func listActionView(_ view: DSListActionView, didSelectRowAt index: Int) {
        let menu = UIKitMenu.allCases[index]
        let viewControllerType = menu.viewController
        
        let scene = viewControllerType.init(nibName: String(describing: viewControllerType.self), bundle: .dsBundle)
        navigationController?.pushViewController(scene, animated: true)
    }
}

// MARK: - DSNavBarDelegate
extension KcsUIKitFlowViewController: DSNavBarDelegate {
    func navBarBackButtonDidTapped(_ view: DSNavBar) {
        navigationController?.popViewController(animated: true)
    }
}

private extension KcsUIKitFlowViewController {
    func setupNavigationBar() {
        navBar.setup(title: "UI Kit", style: .backButtonOnly, theme: .light)
        navBar.delegate = self
    }
    
    func setupListAction() {
        listAction.setup(style: .listActionIcons(viewModels: UIKitMenu.allCases.map {
            ListActionIconViewModel(text: $0.title, rightIcon: DSIcons.icon24OutlineChevronRight)
        }))
        
        listAction.delegate = self
    }
}
