//
//  DSMustKnowCard.swift
//  OneAppDesignSystem
//
//  Created by TTB  on 30/1/2567 BE.
//

import UIKit

@objc public protocol DSMustKnowCardDelegate: AnyObject {
    func mustKnowCardCloseDidTapped(_ view: DSMustKnowCard)
    func mustKnowCardContentDidTapped(_ view: DSMustKnowCard)
    @objc optional func mustKnowCardPrimaryGhostButtonDidTapped(_ view: DSMustKnowCard)
    @objc optional func mustKnowCardSecondaryGhostButtonDidTapped(_ view: DSMustKnowCard)
}

/**
 Custom component Must Know Card

 ![image](/DocumentationImages/ds-must-know-card.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSMustKnowCard` class to the UIView
 2. Binding constraint and don't set `height` (use height placeholder or set height remove at build time in storyboard, or etc.)
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
 
Must know: If not send data to params must know card will hide the component by each params that not have data.
 
 For example: Not sending tagPill parameter, Must Know Card will hide tag pill.
 
 **Programmatically Example:**
 1. Implement mustKnowCard with data and action event in viewDidLoad
  ```swift
     // Declare a mustKnowCard variable binding with view in storyboard
     @IBOutlet weak var mustKnowCard: DSMustKnowCard!

     override func viewDidLoad() {
        super.viewDidLoad()
        // Mockup data to Must Know Card.
        mustKnowCard.setup(viewModel: DSMustKnowCardViewModel(
            icon: .image( ImageAsset(name: "icon-must-know-urgent").image ),
            title: "Title",
            subTitle: "Description",
            tagPill: "Tag text",
            ghostTextPrimary: "Ghost Text",
            ghostTextSecondary: "Ghost Text",
            isInteractionEnabled: true
        ))

        // Config extension with delegate to my View Controller to use any action event of must know card
        mustKnowCard.delegate = self
     }
  ```
 2. Implement delegate  protocol to my view controller to use any action of Must Know Card
  ```swift
     extension YourViewController: DSMustKnowCardDelegate {
         func mustKnowCardCloseDidTapped(_ view: DSMustKnowCard) {
            // Handle close button clickable here..
         }
         func mustKnowCardContentDidTapped(_ view: DSMustKnowCard) {
            // Handle card content clickable here..
         }
         func mustKnowCardPrimaryGhostButtonDidTapped(_ view: DSMustKnowCard) {
            // Handle primary ghost button clickable here..
         }
         func mustKnowCardSecondaryGhostButtonDidTapped(_ view: DSMustKnowCard) {
            // Handle secondary ghost button clickable here..
         }
     }
  ```
 
    NOTE:
 - Set style as named in figma
 - `ghostTextPrimary` is the first button from right side
 - `ghostTextSecondary` is the second button from right side
 */
public final class DSMustKnowCard: UIView {
    
    @IBOutlet private weak var closeButtonContainer: UIView!
    @IBOutlet private weak var ghostContainer: UIView!
    @IBOutlet private weak var pillContainer: UIView!
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var pillView: DSPill!
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!

    @IBOutlet private weak var closeButton: DSClickableIconGeneralIcon!
    @IBOutlet private weak var ghostButtonPrimary: DSGhostButton!
    @IBOutlet private weak var ghostButtonSecondary: DSGhostButton!
    
    // MARK: - Public variables
    /// Variable for config component to return user tapped the result.
    public weak var delegate: DSMustKnowCardDelegate?
    
    /// Variable for card content interaction that user can clickable card content
    public var isInteractionEnabled: Bool = true {
        didSet {
            self.updateUI()
        }
    }
    
    /// Variable for icon type (ex. UIImage icon, url image icon)  of Must Know Card
    public var iconType: DSMustKnowCardIconType = .image(DSIcons.icon24OutlinePlaceholder.image) {
        didSet {
            updateImage()
        }
    }
    
    /// Title  of must know card
    public var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }

    /// Sub title or description of must know card
    public var subTitle: String = "" {
        didSet {
            self.descLabel.text = subTitle
        }
    }
    
    /// Tag text for tag pill of must know card
    public var tagPill: String? {
        didSet {
            self.pillContainer.isHidden = tagPill.isNilOrEmpty
            self.pillView.setup(style: .tag, title: tagPill ?? "")
        }
    }
    
    /// Variable for hide or show close button of must know card (ex. isClosable = true -> show close button)
    public var isClosable: Bool = false {
        didSet {
            closeButtonContainer.isHidden = !isClosable
            closeButton.isHidden = !isClosable
        }
    }
    
    /// Ghost text for primary ghost button
    public var ghostTextPrimary: String? {
        didSet {
            self.ghostButtonPrimary.isHidden = ghostTextPrimary.isNilOrEmpty
            self.ghostButtonPrimary.titleText = ghostTextPrimary
            self.updateUI()
        }
    }
    
    /// Ghost text for secondary ghost button
    public var ghostTextSecondary: String? {
        didSet {
            self.ghostButtonSecondary.isHidden = ghostTextSecondary.isNilOrEmpty
            self.ghostButtonSecondary.titleText = ghostTextSecondary
            self.updateUI()
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

    /// Setup DSMustKnowCard
    ///
    /// Parameter for setup DSMustKnowCard
    /// - Parameter viewModel: view model of DSMustKnowCard that contain [DsMustKnowCardViewModel]
    public func setup(viewModel: DSMustKnowCardViewModel) {
        self.title = viewModel.title
        self.subTitle = viewModel.subTitle
        self.tagPill = viewModel.tagPill
        self.iconType = viewModel.icon
        self.ghostTextPrimary = viewModel.ghostTextPrimary
        self.ghostTextSecondary = viewModel.ghostTextSecondary
        self.isClosable = viewModel.isClosable
        self.isInteractionEnabled = viewModel.isInteractionEnabled
    }
}

// MARK: - Action
extension DSMustKnowCard {
    @IBAction func primaryGhostButtonDidTapped(_ sender: Any) {
        delegate?.mustKnowCardPrimaryGhostButtonDidTapped?(self)
    }
    
    @IBAction func secondaryGhostButtonDidTapped(_ sender: Any) {
        delegate?.mustKnowCardSecondaryGhostButtonDidTapped?(self)
    }
    
    @objc func closeButtonDidTapped() {
        delegate?.mustKnowCardCloseDidTapped(self)
    }

    @objc func cardContentDidTapped() {
        guard isInteractionEnabled else {
            return
        }

        delegate?.mustKnowCardContentDidTapped(self)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isInteractionEnabled else { return }

        self.container.backgroundColor = DSColor.componentMustKnowBackgroundOnPress
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        self.container.backgroundColor = DSColor.componentMustKnowBackgroundDefault
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        self.container.backgroundColor = DSColor.componentMustKnowBackgroundDefault
    }
}
// MARK: - Gesture Delegate
extension DSMustKnowCard: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return ![ghostButtonPrimary, ghostButtonSecondary, closeButton].contains(touch.view)
    }
}

// MARK: - Private
private extension DSMustKnowCard {
    
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
    }
    
    func updateUI() {
        ghostContainer.isHidden = self.ghostButtonPrimary.isHidden && self.ghostButtonSecondary.isHidden
        self.dsShadowDrop(isHidden: !isInteractionEnabled)
    }
    
    func updateImage() {
        switch iconType {
        case let .image(image):
            iconImageView.image = image
        case let .url(url, placeholder):
            iconImageView.setImage(
                with: url,
                placeHolder: placeholder
            )
        }
    }
    
    func setupUI() {
        titleLabel.font = DSFont.h3
        titleLabel.textColor = DSColor.componentMustKnowTextDefault
        
        descLabel.font = DSFont.subtitle
        descLabel.textColor = DSColor.componentMustKnowDesc
        
        container.backgroundColor = DSColor.componentMustKnowBackgroundDefault
        container.setRadius(radius: .radius16px)
        
        backgroundColor = DSColor.componentMustKnowBackgroundDefault
        setRadius(radius: .radius16px)
        
        iconImageView.tintAdjustmentMode = .normal

        self.ghostButtonPrimary.mediumGhostText(text: "")
        self.ghostButtonSecondary.mediumGhostText(text: "")
        closeButton.setup(viewModel: DSClickableIconGeneralIconViewModel(tagId: .zero,
                                                                         state: .active,
                                                                         theme: .light,
                                                                         size: .small,
                                                                         imageType: .image(DSIcons.icon16Close.image),
                                                                         isBadged: false)) { [weak self] _ in
            guard let self, let delegate = delegate else { return }
            delegate.mustKnowCardCloseDidTapped(self)
        }
    }
    
    func setupGesture() {

        let cardContentTap = UITapGestureRecognizer(target: self, action: #selector(cardContentDidTapped))
        cardContentTap.delegate = self
        self.addGestureRecognizer(cardContentTap)
    }
}
