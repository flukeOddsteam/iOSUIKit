//
//  DSPreviewFilePresenter.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 21/3/2567 BE.
//

import Foundation

protocol DSPreviewFilePresenterInterface {
    func contentDidLoadMaximumExceed()
}

protocol DSPreviewFileViewInterface: AnyObject {
    func displayFullScreenError(viewModel: PreviewFileFullScreenErrorViewController.ViewModel)
}

struct DSPreviewFilePresenter {
    weak var view: DSPreviewFileViewInterface?
    
    init(view: DSPreviewFileViewInterface) {
        self.view = view
    }
}

extension DSPreviewFilePresenter: DSPreviewFilePresenterInterface {
    func contentDidLoadMaximumExceed() {
        let viewModel = PreviewFileFullScreenErrorViewController.ViewModel(
            image: SvgIcons.previewFileExceedLimit.image,
            title: PreviewFilePhrase.errorLoadingFullScreenTitle.localize(),
            description: PreviewFilePhrase.errorLoadingFullScreenSubTitle.localize(),
            titleButton: PreviewFilePhrase.okButton.localize()
        )

        view?.displayFullScreenError(viewModel: viewModel)
    }
}
