//
//  OfferingImageIconView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/4/2567 BE.
//

import UIKit

final class OfferingImageIconView: UIView {

    @IBOutlet weak var creditCard: DSCreditCard!
    @IBOutlet weak var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func setup(
        iconType: DSOfferingCardViewModel.IconImageLeftType,
        imageType: DSOfferingCardViewModel.ImageType
    ) {

        creditCard.isHidden = !iconType.shouldDisplayCreditCard
        imageView.isHidden = !iconType.shouldDisplayImageIcon
        imageView.tintAdjustmentMode = .normal

        switch iconType {
        case .creditCard:
            let viewModel = DSCreditCardViewModel(imageType)
            creditCard.setup(viewModel: viewModel)
        case .icon:
            switch imageType {
            case .image(let image):
                imageView.image = image
            case .url(let url, let placeholder, let cacheable):
                imageView.setImage(with: url, placeHolder: placeholder, cacheable: cacheable)
            }
        }
    }
}

// MARK: - Private
private extension OfferingImageIconView {
    func commonInit() {
        setupXib()
    }
}

fileprivate extension DSCreditCardViewModel {
    init(_ imageType: DSOfferingCardViewModel.ImageType) {

        var creditCardImageType: DSCreditCardImageType

        switch imageType {
        case .image(let image):
            creditCardImageType = .image(image)
        case let .url(url, _, cacheable):
            creditCardImageType = .url(
                url,
                cacheable: cacheable
            )
        }

        self.init(
            size: .xSmall,
            imageType: creditCardImageType,
            isVirtual: false
        )
    }
}
