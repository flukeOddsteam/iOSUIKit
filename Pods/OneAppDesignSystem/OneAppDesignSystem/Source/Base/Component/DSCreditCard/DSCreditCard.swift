//
//  DSCreditCard.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/1/2567 BE.
//

import UIKit

/**
 Custom component DSCreditCard

 ![image](/DocumentationImages/ds-credit-card.png)

 **Usage Example:**
 1. Create UIView on .xib file and assign `DSCreditCard` Class to the UIView
 2. Binding constraint and don't set width and height. just set intrinsic to placeholder
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
```swift
    @IBOutlet weak var creditCard: DSCreditCard!

    override func viewDidLoad() {
        super.viewDidLoad()
        creditCard.setup(viewModel:
                         DSCreditCardViewModel(
                             size: .xSmall,
                             imageType: .image(image),
                             isVirtual: true
                         )
        )
    }
}
```
*/

public final class DSCreditCard: UIView {
    @IBOutlet private weak var virtualImageView: UIImageView!
    @IBOutlet private weak var creditCardImageView: UIImageView!
    @IBOutlet private weak var heightCreditCardViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthCreditCardViewConstraint: NSLayoutConstraint!

    private var viewModel: DSCreditCardViewModel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    /// Setup DSCreditCard
    ///
    /// Parameter for setup DSCreditCard
    /// - Parameter viewModel: view model of DSCreditCard that contain size, imagetype, isVirtual for setup to component.
    public func setup(viewModel: DSCreditCardViewModel) {
        self.viewModel = viewModel
        self.updateUI()
    }

    public func setAccessibility(accessibility: DSCreditCardAccessibility) {
        virtualImageView.accessibilityIdentifier = accessibility.virtualImageId
        creditCardImageView.accessibilityIdentifier = accessibility.creditCardImageId
    }
}

// MAKR: - Private
private extension DSCreditCard {
    func commonInit() {
        setupXib()
    }

    func updateUI() {
        set(cornerRadius: viewModel.size.radius)
        creditCardImageView.set(cornerRadius: viewModel.size.radius)
        
        heightCreditCardViewConstraint.constant = viewModel.size.cgSize.height
        widthCreditCardViewConstraint.constant = viewModel.size.cgSize.width
        layoutIfNeeded()

        virtualImageView.isHidden = !viewModel.isVirtual
        virtualImageView.image = viewModel.size.virtualImage

        updateImage()
    }

    func updateImage() {
        switch viewModel.imageType {
        case let .image(image):
            creditCardImageView.image = image
        case let .url(url, cacheable):
            creditCardImageView.setImage(
                with: url,
                placeHolder: viewModel.size.placeholder,
                cacheable: cacheable
            )
        }
    }
}
