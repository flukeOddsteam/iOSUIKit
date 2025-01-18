//
//  PreviewFileFullScreenErrorViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/3/2567 BE.
//

import UIKit

protocol PreviewFileFullScreenErrorDelegate: AnyObject {
    func previewFileFullScreenErrorDidSelectPrimaryButton(
        _ viewController: PreviewFileFullScreenErrorViewController
    )
}

final class PreviewFileFullScreenErrorViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var primaryButton: DSPrimaryButton!

    weak var delegate: PreviewFileFullScreenErrorDelegate?

    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Action
extension PreviewFileFullScreenErrorViewController {
    @IBAction func primaryButtonDidTapped(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.previewFileFullScreenErrorDidSelectPrimaryButton(self)
        }
    }
}

// MARK: - Private
private extension PreviewFileFullScreenErrorViewController {
    func setupUI() {
        titleLabel.font = DSFont.h2
        titleLabel.textColor = DSColor.componentLightDefault
        
        descriptionLabel.font = DSFont.paragraphMedium
        descriptionLabel.textColor = DSColor.componentLightDesc

        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        iconImageView.image = viewModel.image
        iconImageView.tintAdjustmentMode = .normal

        primaryButton.largePrimaryText(text: viewModel.titleButton)

        view.backgroundColor = DSColor.pageLightBackground
    }
}

// MARK: - ViewModel
extension PreviewFileFullScreenErrorViewController {
    struct ViewModel {
        let image: UIImage
        let title: String?
        let description: String?
        let titleButton: String
    }
}
