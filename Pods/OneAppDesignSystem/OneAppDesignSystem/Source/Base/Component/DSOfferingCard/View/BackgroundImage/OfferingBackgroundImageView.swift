//
//  OfferingBackgroundImageViewView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/4/2567 BE.
//

import UIKit

final class OfferingBackgroundImageView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func setup(viewModel: DSOfferingCardViewModel.BackgroundImageViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.setLineHeight(height: 20)

        descriptionLabel.text = viewModel.description
        descriptionLabel.isHidden = viewModel.description.isNilOrEmpty
        descriptionLabel.setLineHeight(height: 16)

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

// MARK: - Private
private extension OfferingBackgroundImageView {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        titleLabel.font = DSFont.h4
        titleLabel.textColor = DSColor.componentOfferingTitle
        titleLabel.numberOfLines = 4

        descriptionLabel.font = DSFont.paragraphXSmall
        descriptionLabel.textColor = DSColor.componentOfferingDesc
        descriptionLabel.numberOfLines = 4

        containerView.backgroundColor = DSColor.componentOfferingBackground
        containerView.setBorder(
            width: 1,
            color: DSColor.componentOfferingOutline
        )
        
        imageView.tintAdjustmentMode = .normal

        containerView.set(cornerRadius: DSRadius.radius16px.rawValue)
        containerView.clipsToBounds = true
    }
}
