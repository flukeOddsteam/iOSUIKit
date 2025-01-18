//
//  DSErrorFullPageViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 30/4/2567 BE.
//

import UIKit

public protocol DSErrorFullPageEventDelegate: AnyObject {
    func errorFullPageDidDismiss(_ viewController: DSErrorFullPageViewController)
}

public typealias DSErrorFullPageAction = () -> Void
public final class DSErrorFullPageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ghostButton: DSGhostButton!
    @IBOutlet weak var primaryButton: DSPrimaryButton!

    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!
    public var viewModel: DSErrorFullPageViewModel!

    public var primaryAction: DSErrorFullPageAction?
    public var ghostAction: DSErrorFullPageAction?

    public weak var delegate: DSErrorFullPageEventDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    public func dismiss() {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            self.delegate?.errorFullPageDidDismiss(self)
        }
    }
}

// MARK: - Action
extension DSErrorFullPageViewController {
    @IBAction func primaryButtonDidTapped(_ sender: Any) {
        primaryAction?()
    }

    @IBAction func ghostButtonDidTapped(_ sender: Any) {
        ghostAction?()
    }
}

// MARK: - Private
private extension DSErrorFullPageViewController {
    func setupUI() {
        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.font = DSFont.h2
        titleLabel.text = viewModel.title

        descriptionLabel.textColor = DSColor.componentLightDesc
        descriptionLabel.font = DSFont.paragraphSmall
        descriptionLabel.text = viewModel.description

        primaryButton.largePrimaryText(
            text: viewModel.primaryButtonTitle ?? ""
        )

        primaryButton.isHidden = viewModel.primaryButtonTitle.isNilOrEmpty
        primaryButton.setAccessibilityIdentifier(
            id: "primary_button_id",
            titleLabelId: nil
        )
        ghostButton.largeGhostText(
            text: viewModel.ghostButtonTitle ?? ""
        )

        ghostButton.isHidden = viewModel.ghostButtonTitle.isNilOrEmpty

        imageWidthConstraint.constant = viewModel.mediaDisplayType.imageSize.width
        imageHeightConstraint.constant = viewModel.mediaDisplayType.imageSize.height
        topImageConstraint.constant = viewModel.mediaDisplayType.topPadding
        view.layoutIfNeeded()

        imageView.tintAdjustmentMode = .normal
        switch viewModel.imageType {
        case .image(let image):
            imageView.image = image
        case .url(let url, let placeholder, let cacheable):
            imageView.setImage(
                with: url,
                placeHolder: placeholder,
                cacheable: cacheable
            )
        }
    }
}
