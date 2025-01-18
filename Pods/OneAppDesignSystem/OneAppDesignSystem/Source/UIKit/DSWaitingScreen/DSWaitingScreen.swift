//
//  DSWaitingScreen.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/2/2567 BE.
//

import UIKit

/**
 Custom component DSWaitingScreen for Design System

 ```
    override func viewDidLoad() {
        super.viewDidLoad()
        let bottomSheetPhrase = DSWaitingScreenViewModel.BottomSheetPhrase(
            title: "Heading, Keep it short (1 line)",
            description: "Try to keep this short, as much as possible maximum 4 lines ",
            primaryButtonTitle: "Primary",
            ghostButtonTitle: "Ghost"
        )
        let screenPhrase = DSWaitingScreenViewModel.ScreenPhrase(
            title: "Title",
            subtitle: "Loading",
            ghostButtonTitle: "Ghost"
        )

        let viewModel = DSWaitingScreenViewModel(
                screenPhrase: screenPhrase,
                bottomSheetPhrase: bottomSheetPhrase,
                mediaType: .image(DSIcon.icon48OutlineSomething)
        )

        DSWaitingScreen.show(viewModel: viewModel, delegate: self)
 }
 ```
 */

public struct DSWaitingScreen {

    private static weak var controller: DSWaitingScreenInterface?

    /// Display DSWaitingScreen
    ///
    /// Parameter for show DSWaitingScreen
    /// - Parameter viewModel: The viewModel of DSWaitingScreen that contains phrase and media type.
    /// - Parameter delegate: The delegate of DSWaitingScreen for receive event on screen.
    @discardableResult
    public static func show(
        viewModel: DSWaitingScreenViewModel,
        delegate: DSWaitingScreenDelegate? = nil
    ) -> DSWaitingScreenInterface {
        guard let rootViewController = UIApplication.getRootViewController() else {
            fatalError("Could not found root viewController")
        }

        return show(
            viewModel: viewModel,
            viewController: rootViewController,
            delegate: delegate
        )
    }

    /// Display DSWaitingScreen
    ///
    /// Parameter for show DSWaitingScreen
    /// - Parameter viewModel: The viewModel of DSWaitingScreen that contains phrase and media type.
    /// - Parameter delegate: The delegate of DSWaitingScreen for receive event on screen.
    /// - Parameter accessibility: The accessibility of DSWaitingScreen.
    /// - Parameter viewController: The viewController of DSWaitingScreen for present waiting screen viewcontroller.
    @discardableResult
    public static func show(
        viewModel: DSWaitingScreenViewModel,
        accessibility: DSWaitingScreenAccessibility? = nil,
        viewController: UIViewController,
        delegate: DSWaitingScreenDelegate? = nil
    ) -> DSWaitingScreenInterface {

        let scene = DSWaitingScreenViewController()

        scene.viewModel = viewModel
        scene.accessibility = accessibility
        scene.delegate = delegate

        scene.modalPresentationStyle = .overFullScreen

        let navigationController = UINavigationController(rootViewController: scene)
        navigationController.setNavigationBarHidden(
            true,
            animated: false
        )
        navigationController.modalPresentationStyle = .overFullScreen

        controller = scene

        viewController.present(
            navigationController,
            animated: true
        )
        return scene
    }

    public static func hide() {
        controller?.close()
        controller = nil
    }

    public static func createInstance(
        viewModel: DSWaitingScreenViewModel,
        accessibility: DSWaitingScreenAccessibility? = nil,
        delegate: DSWaitingScreenDelegate? = nil
    ) -> DSWaitingScreenViewController {
        let nibName = String(describing: DSWaitingScreenViewController.self)
        let scene = DSWaitingScreenViewController(
            nibName: nibName,
            bundle: .dsBundle
        )
        scene.viewModel = viewModel
        scene.accessibility = accessibility
        scene.delegate = delegate

        return scene
    }
}
