//
//  BottomSheetMenuListContentView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/3/2566 BE.
//

import UIKit

private enum Constants {
    static let defaultWidthImageView: CGFloat = 48
    static let defaultHeightImageView: CGFloat = 48
}

final class BottomSheetMenuListContentView: UIView {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var widthImageViewContraint: NSLayoutConstraint!
    @IBOutlet weak var heightImageViewConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func setup(viewModel: DSBottomSheetMenuListDescriptionViewModel, imageRatio: DSRatio) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        descriptionLabel.isHidden = viewModel.description.isNilOrEmpty
        switch viewModel.imageStyle {
        case .icon(let icon, let size):
            iconImageView.image = icon.image
            widthImageViewContraint.constant = size.rawValue
            heightImageViewConstraint.constant = size.rawValue
            iconImageView.layoutIfNeeded()
        case .image(let imageType):
            setImageRatio(ratio: imageRatio)
            setImage(type: imageType, ratio: imageRatio)
        }
    }

    func highlight() {
        set(backgroundColor: DSColor.componentLightBackgroundOnPress)
    }

    func unhighlight() {
        set(backgroundColor: DSColor.componentLightBackground)
    }
}

// MARK: - Private
private extension BottomSheetMenuListContentView {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.font = DSFont.h3

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintAdjustmentMode = .normal

        descriptionLabel.textColor = DSColor.componentLightDesc
        descriptionLabel.font = DSFont.paragraphSmall

        containerView.setRadius(radius: .radius12px)
        containerView.setBorder(width: 1, color: DSColor.componentLightOutlineClickable)
        set(backgroundColor: DSColor.componentLightBackground)
    }

    func set(backgroundColor: UIColor) {
        containerView.backgroundColor = backgroundColor
        containerView.dsShadowDrop()
    }

    func setImage(type: DSBottonSheetMenuListDescriptionImageType, ratio: DSRatio) {
        switch type {
        case .image(let image):
            iconImageView.image = image
        case let .url(url, cacheable):
            let placeholder = getPlaceholder(ratio: ratio)
            iconImageView.setImage(with: url, placeHolder: placeholder, cacheable: cacheable)
        }
    }

    func getPlaceholder(ratio: DSRatio) -> UIImage? {
        switch ratio {
        case .ratio1x1:
            return DSImage.placeholder1x1.image
        case .ratio3x2:
            return DSImage.placeholder3x2.image
        case .ratio16x9:
            return DSImage.placeholder16x9.image
        case .ratio2x3, .ratio9x16, .ratio32x9, .ratio9x32:
            return nil
        }
    }

    func setImageRatio(ratio: DSRatio) {
        let newHeight = Constants.defaultWidthImageView / ratio.rawValue
        heightImageViewConstraint.constant = newHeight
        iconImageView.layoutIfNeeded()
    }
}
