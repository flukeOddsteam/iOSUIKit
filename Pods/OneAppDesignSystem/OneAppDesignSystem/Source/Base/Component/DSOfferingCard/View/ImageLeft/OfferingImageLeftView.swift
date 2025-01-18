//
//  OfferingImageLeftView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/4/2567 BE.
//

import UIKit

final class OfferingImageLeftView: UIView {
    
    @IBOutlet weak var imageIconView: OfferingImageIconView!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    @IBOutlet weak var pillContainerView: UIView!
    @IBOutlet weak var pillView: DSPill!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func setup(viewModel: DSOfferingCardViewModel.ImageLeftViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.font = viewModel.textSize.titleFont
        descriptionLabel.text = viewModel.description
        descriptionLabel.isHidden = viewModel.description.isNilOrEmpty
        descriptionLabel.font = viewModel.textSize.descriptionFont

        amountLabel.text = viewModel.amount
        amountLabel.isHidden = viewModel.amount.isNilOrEmpty

        pillView.setup(viewModel: viewModel.pill)

        imageIconView.setup(
            iconType: viewModel.iconType,
            imageType: viewModel.imageType
        )
    }
}

// MARK: - Private
private extension OfferingImageLeftView {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        titleLabel.textColor = DSColor.componentOfferingTitle
        titleLabel.font = DSFont.h3
        
        descriptionLabel.font = DSFont.paragraphSmall
        descriptionLabel.textColor = DSColor.componentOfferingDesc

        amountLabel.font = DSFont.valueSmall
        amountLabel.textColor = DSColor.componentOfferingValue

        containerView.backgroundColor = DSColor.componentOfferingBackground
        containerView.setBorder(
            width: 1,
            color: DSColor.componentOfferingOutline
        )
        containerView.setRadius(radius: .radius16px)
    }
}
