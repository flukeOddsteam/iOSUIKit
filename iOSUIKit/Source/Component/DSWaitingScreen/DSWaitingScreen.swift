//
//  POCWaitingScreen.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/2/2567 BE.
//

import UIKit
import OneAppDesignSystem

/**
 Custom component POCWaitingScreen for Design System

 ```
    override func viewDidLoad() {
        super.viewDidLoad()
        let bottomSheetPhrase = POCWaitingScreenViewModel.BottomSheetPhrase(
            title: "Heading, Keep it short (1 line)",
            description: "Try to keep this short, as much as possible maximum 4 lines ",
            primaryButtonTitle: "Primary",
            ghostButtonTitle: "Ghost"
        )
        let screenPhrase = POCWaitingScreenViewModel.ScreenPhrase(
            title: "Title",
            subtitle: "Loading",
            ghostButtonTitle: "Ghost"
        )

        let viewModel = POCWaitingScreenViewModel(
                screenPhrase: screenPhrase,
                bottomSheetPhrase: bottomSheetPhrase,
                mediaType: .image(DSIcon.icon48OutlineSomething)
        )

        POCWaitingScreen.show(viewModel: viewModel, delegate: self)
 }
 ```
 */

public struct POCWaitingScreen {

    private static weak var controller: POCWaitingScreenInterface?

    /// Display POCWaitingScreen
    ///
    /// Parameter for show POCWaitingScreen
    /// - Parameter viewModel: The viewModel of POCWaitingScreen that contains phrase and media type.
    /// - Parameter delegate: The delegate of POCWaitingScreen for receive event on screen.
    @discardableResult
    public static func show(
        viewModel: POCWaitingScreenViewModel,
        delegate: POCWaitingScreenDelegate? = nil
    ) -> POCWaitingScreenInterface {
        guard let rootViewController = UIApplication.getRootViewController() else {
            fatalError("Could not found root viewController")
        }

        return show(
            viewModel: viewModel,
            viewController: rootViewController,
            delegate: delegate
        )
    }

    /// Display POCWaitingScreen
    ///
    /// Parameter for show POCWaitingScreen
    /// - Parameter viewModel: The viewModel of POCWaitingScreen that contains phrase and media type.
    /// - Parameter delegate: The delegate of POCWaitingScreen for receive event on screen.
    /// - Parameter accessibility: The accessibility of POCWaitingScreen.
    /// - Parameter viewController: The viewController of POCWaitingScreen for present waiting screen viewcontroller.
    @discardableResult
    public static func show(
        viewModel: POCWaitingScreenViewModel,
        accessibility: POCWaitingScreenAccessibility? = nil,
        viewController: UIViewController,
        delegate: POCWaitingScreenDelegate? = nil
    ) -> POCWaitingScreenInterface {

        let scene = POCWaitingScreenViewController()

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
        viewModel: POCWaitingScreenViewModel,
        accessibility: POCWaitingScreenAccessibility? = nil,
        delegate: POCWaitingScreenDelegate? = nil
    ) -> POCWaitingScreenViewController {
        let nibName = String(describing: POCWaitingScreenViewController.self)
        let scene = POCWaitingScreenViewController(
            nibName: nibName,
            bundle: .dsBundle
        )
        scene.viewModel = viewModel
        scene.accessibility = accessibility
        scene.delegate = delegate

        return scene
    }
}
