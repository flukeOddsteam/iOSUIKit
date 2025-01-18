//
//  DSOfferingCardView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/4/2567 BE.
//

import UIKit

/**
 Common flow DSOfferingCard

 ![image](/DocumentationImages/ds-offering-card-background-image.png)
 ![image](/DocumentationImages/ds-offering-card-image-left.png)

 **Usage Example:**
    ## Example for background image type
 ```swift
     offeringCard.setup(
         type: .backgroundImage(
             viewModel: DSOfferingCardViewModel.BackgroundImageViewModel(
                 title: "Title keep it short max 2 line",
                 description: "Desc Message here, keep this short, 3",
                 imageType: .image(image)
             )
         ),
         action: {
             // Do something action
         }
     )
 ```
    ## Example for image left type
    ```swift
    offeringCard.setup(
         type: .imageLeft(
             viewModel: DSOfferingCardViewModel.ImageLeftViewModel(
                 title: "Title keep it short max 2 line maximum",
                 description: "Desc Message here, keep this short, 3 lines maximum",
                 amount: "Amount THB",
                 pill: DSPillViewModel(
                     style: .tag,
                     title: "Text Label"
                 ),
                 iconType: .creditCard,
                 imageType: .url(
                     url,
                     placeholder: DSImage.placeholder16x9.image,
                     cacheable: true
                 ),
                 textSize: .medium
             )
         ),
         action: {
            // Do something action
     })
     ```
*/
public final class DSOfferingCard: UIView {

    @IBOutlet weak var offeringBackgroundView: OfferingBackgroundImageView!
    @IBOutlet weak var offeringImageLeftView: OfferingImageLeftView!
    @IBOutlet weak var stackView: UIStackView!

    private var action: (() -> Void)?

    /// type of offering card
    public var type: DSOfferingCardType? {
        didSet {
            updateType()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /**
     Parameter | Description
       --- | ---
       `type` | ` type of offering card` This contains viewModel for type background image and image left.
       `action` | `callback of tap event on card`Callback when user tapped the card. It will triggered this method
     */
    public func setup(
        type: DSOfferingCardType,
        action: (() -> Void)? = nil
    ) {
        self.type = type
        self.action = action
    }
}
// MARK: - Action
extension DSOfferingCard {
    @objc func cardDidTapped() {
        action?()
    }
}

// MARK: - Private
private extension DSOfferingCard {
    func commonInit() {
        setupXib()
        setupAction()
    }

    func setupAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardDidTapped))
        addGestureRecognizer(tapGesture)
    }

    func updateType() {
        guard let type else { return }
        offeringBackgroundView.isHidden = type.isHiddenBackgroundImageView
        offeringImageLeftView.isHidden = type.isHiddenImageLeftView

        switch type {
        case .backgroundImage(let viewModel):
            offeringBackgroundView.setup(viewModel: viewModel)
        case .imageLeft(let viewModel):
            offeringImageLeftView.setup(viewModel: viewModel)
        }

        set(cornerRadius: DSRadius.radius16px.rawValue)
        dsShadowDrop()
    }
}
