//
//  DSMessageBoxOffering.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/1/23.
//

import UIKit

private enum Constants {
    static let numberLineDescriptionLabel: Int = 0
    static let borderWidthContainerView: CGFloat = 1
}

/**
 Custom component MessageBoxOffer

 ![image](/DocumentationImages/ds-message-box-offer.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSMessageBoxOffering` class to the UIView
 2. Binding constraint and don't set `height` (use height placeholder or set height remove at build time in storyboard, or etc.)
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
 
  ```
 @IBOutlet weak var messageBoxOffering: DSMessageBoxOffering!
  
  override func viewDidLoad() {
     super.viewDidLoad()
     messageBoxOffer1.setup(viewModel:
                         DSMessageBoxOfferingViewModel(
                             title: "Title keep it short.",
                             description: "Subtitle message here, keep this short.",
                             primaryButtonTitle: "Primary",
                             secondaryButtonTitle: "Seconday",
                             backgroundImage: .image(SvgIcons.messageBoxOfferingBackground.image)
                         ),
                        primaryButtonAction: { action trigger here }},
                        secondaryButtonAction: { action trigger here }}
     )
  }
  ```
 */
public final class DSMessageBoxOffering: UIView {
    @IBOutlet weak var rightSignatureImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var secondaryButton: DSSecondaryButton!
    @IBOutlet weak var primaryButton: DSPrimaryButton!

    // MARK: - Public
    /// variable for update title label
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    /// variable for update description label
    public var descriptionTitle: String? {
        didSet {
            descriptionLabel.text = descriptionTitle
        }
    }

    /// variable for update primary button title
    public var primaryButtonTitle: String? {
        didSet {
            updateButton()
        }
    }

    /// variable for update secondary button title
    public var secondaryButtonTitle: String? {
        didSet {
            updateButton()
        }
    }

    /// variable for update background image. Should not be nil.
    public var backgroundImage: DSMessageBoxOfferingBackgroundImageType! {
        didSet {
            updateBackground()
        }
    }

    // MARK: - Private
    private var primaryButtonAction: (() -> Void)?
    private var secondaryButtonAction: (() -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// Setup DSMessageBoxOffering
    /// Parameter | Type + Information
    /// --- | ---
    /// `viewModel` | `DSMessageBoxOfferingViewModel`  The viewModel of DSMessageBoxOffering  (mandatory).
    /// `primaryButtonAction` | `(() -> Void)` Action of primary button. (nullable)
    /// `secondaryButtonAction` | `(() -> Void)` Action of secondary button. (nullable)
    public func setup(
        viewModel: DSMessageBoxOfferingViewModel,
        primaryButtonAction: (() -> Void)? = nil,
        secondaryButtonAction: (() -> Void)? = nil
    ) {
        self.title = viewModel.title
        self.descriptionTitle = viewModel.description
        self.backgroundImage = viewModel.backgroundImage
        self.primaryButtonTitle = viewModel.primaryButtonTitle
        self.secondaryButtonTitle = viewModel.secondaryButtonTitle
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonAction = secondaryButtonAction
    }

    /// Setup Accessibility of DSMessageBoxOffering
    /// Parameter | Type + Information
    /// --- | ---
    /// `accessibility` | `DSMessageBoxOfferingAccessibility`  The .
    public func setAccessibility(accessibility: DSMessageBoxOfferingAccessibility) {
        self.titleLabel.accessibilityIdentifier = accessibility.titleId
        self.descriptionLabel.accessibilityIdentifier = accessibility.descriptionId
        self.primaryButton.setAccessibilityIdentifier(id: accessibility.primaryButtonId, titleLabelId: accessibility.primaryButtonTitleId)
        self.secondaryButton.setAccessibilityIdentifier(id: accessibility.secondaryButtonId, titleLabelId: accessibility.primaryButtonId)
    }
}

// MARK: - Action
extension DSMessageBoxOffering {
    @IBAction func primaryButtonDidTapped(_ sender: Any) {
        primaryButtonAction?()
    }

    @IBAction func secondaryButtonDidTapped(_ sender: Any) {
        secondaryButtonAction?()
    }
}

// MARK: - Private
private extension DSMessageBoxOffering {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        titleLabel.font = DSFont.h3
        titleLabel.textColor = DSColor.componentOfferDefault

        descriptionLabel.font = DSFont.subtitle
        descriptionLabel.textColor = DSColor.componentSummaryDefault
        descriptionLabel.numberOfLines = Constants.numberLineDescriptionLabel
        descriptionLabel.sizeToFit()

        containerView.layer.borderWidth = Constants.borderWidthContainerView
        containerView.setRadius(radius: DSRadius.radius12px)
        containerView.layer.borderColor = DSColor.componentLightOutlineActive.cgColor

        rightSignatureImageView.tintColor = DSColor.componentLightOutlineActive
        rightSignatureImageView.image = SvgIcons.signatureCurve.image.withRenderingMode(.alwaysTemplate)

        rightSignatureImageView.tintAdjustmentMode = .normal

        primaryButton.smallPrimaryText(text: "")
        secondaryButton.smallSecondaryText(text: "")
    }

    func updateButton() {
        primaryButton.isHidden = primaryButtonTitle.isNilOrEmpty
        secondaryButton.isHidden = secondaryButtonTitle.isNilOrEmpty
        primaryButton.titleText = primaryButtonTitle
        secondaryButton.titleText = secondaryButtonTitle
    }

    func updateBackground() {
        switch backgroundImage {
        case .image(let image):
            backgroundImageView.image = image
        case .url(let url, let placeholder, let cacheable):
            backgroundImageView.setImage(with: url, placeHolder: placeholder, cacheable: cacheable)
        default:
            fatalError("Undefined image background.")
        }
    }
}
