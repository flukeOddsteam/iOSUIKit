//
//  DSPreviewFileRouter.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 20/3/2567 BE.
//

import Foundation

protocol DSPreviewFileRouterInterface {
    func gotoEditFileNameScreen(resource: DSPreviewFileResource) -> DSPreviewEditFileNameViewController
    func gotoFullScreenErrorScreen(viewModel: PreviewFileFullScreenErrorViewController.ViewModel)
}

struct DSPreviewFileRouter {
    weak var viewController: DSPreviewFileViewController?

    init(viewController: DSPreviewFileViewController) {
        self.viewController = viewController
    }
}

extension DSPreviewFileRouter: DSPreviewFileRouterInterface {
    func gotoEditFileNameScreen(resource: DSPreviewFileResource) -> DSPreviewEditFileNameViewController {
        viewController?.view.setTransition(type: .push, subtype: .fromRight)
        let nibName = String(describing: DSPreviewEditFileNameViewController.self)
        let scene = DSPreviewEditFileNameViewController(
            nibName: nibName,
            bundle: .dsBundle
        )
        scene.resource = resource
        scene.delegate = viewController
        scene.modalPresentationStyle = .overFullScreen

        viewController?.present(scene, animated: false)
        return scene
    }
    
    func gotoFullScreenErrorScreen(viewModel: PreviewFileFullScreenErrorViewController.ViewModel) {
        let nibName = String(describing: PreviewFileFullScreenErrorViewController.self)
        let scene = PreviewFileFullScreenErrorViewController(
            nibName: nibName,
            bundle: .dsBundle
        )
        scene.viewModel = viewModel
        scene.modalPresentationStyle = .overFullScreen
        scene.delegate = viewController
        viewController?.present(scene, animated: true)
    }
}
