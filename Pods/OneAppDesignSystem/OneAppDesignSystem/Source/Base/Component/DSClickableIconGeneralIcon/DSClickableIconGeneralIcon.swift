//
//  DSClickableIconGeneralIcon.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/2/2567 BE.
//

import UIKit
/**
 Custom component DSClickableIconGeneralIcon for Design System

 **Usage Example:**
 1. Create UIView on .xib file and assign `DSClickableIconGeneralIcon` Class to the UIView.
 2. Binding constraint and don't set `height` and `width`.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
 ```
     @IBOutlet weak var clickableIconGeneralIcon: DSClickableIconGeneralIcon!

     override func viewDidLoad() {
         super.viewDidLoad()
         clickableIconGeneralIcon.setup(
             viewModel:
                 DSClickableIconGeneralIconViewModel(
                     tagId: .zero,
                     state: .active,
                     theme: .light,
                     size: .medium,
                     imageType: .image(DSIcons.icon24OutlinePlaceholder.image),
                     isBadged: false
                 ),
             action: nil
         )
    }
 ```
 */
public final class DSClickableIconGeneralIcon: UIControl {

    @IBOutlet weak var badgeDot: DSBadgeDot!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heightContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightIconImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthIconImageConstraint: NSLayoutConstraint!

    /// identifier of DSClickableIconGeneralIcon. It will return when action is called
    public var tagId: Int = .zero

    /// action of DSClickableIconGeneralIcon.
    public var action: DSClickableIconGeneralAction?

    /// state of DSClickableIconGeneralIcon
    public var componentState: DSClickableIconGeneralState = .active {
        didSet {
            updateState()
        }
    }

    /// style of DSClickableIconGeneralIcon such as light, dark
    public var theme: DSClickableIconGeneralIconTheme = .light {
        didSet {
            updateTheme()
        }
    }

    public var size: DSClickableIconGeneralIconSize = .medium {
        didSet {
            updateSize()
        }
    }

    /// image object that contain type of image such as image object, url object.
    public var imageType: DSClickableIconGeneralImageType? {
        didSet {
            updateImage()
        }
    }

    /// flag for display badge dot
    public var isBadged: Bool = false {
        didSet {
            badgeDot.isHidden = !isBadged
        }
    }

    /// Constructor for instance initializers.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Constructor for Designated initializers.
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// Setup DSClickableIconGeneralIcon
    ///
    /// Parameter for setup DSClickableIconGeneralIcon
    /// - Parameter viewModel: view model of DSClickableIconGeneralIcon.
    /// - Parameter action: callback action when user touch the component.
    public func setup(
        viewModel: DSClickableIconGeneralIconViewModel,
        action: DSClickableIconGeneralAction?
    ) {
        self.tagId = viewModel.tagId
        self.componentState = viewModel.state
        self.theme = viewModel.theme
        self.imageType = viewModel.imageType
        self.size = viewModel.size
        self.isBadged = viewModel.isBadged
        self.action = action
    }
    
    public func setAccessibilityIdentifier(id: String? = nil) {
        self.accessibilityIdentifier = id
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.updateUI(event: .begin)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.updateUI(event: .end)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.updateUI(event: .cancelled)
    }
}

// MARK: - Action
extension DSClickableIconGeneralIcon {
    @objc func clickableDidTapped() {
        action?(tagId)
    }
}

// MARK: - Private
private extension DSClickableIconGeneralIcon {
    func commonInit() {
        setupXib()
        updateState()
        updateSize()
        updateTheme()
        setupUI()
    }

    func setupUI() {
        self.isUserInteractionEnabled = false
        containerView.isUserInteractionEnabled = false
        iconImageView.tintAdjustmentMode = .normal

        addTarget(
            self,
            action: #selector(clickableDidTapped),
            for: .touchUpInside
        )
    }

    func updateState() {
        isUserInteractionEnabled = componentState.isUserInteractionEnabled
        updateTheme()
    }

    func updateImage() {
        guard let imageType else {
            return
        }

        switch imageType {
        case .image(let image):
            iconImageView.image = image.withRenderingMode(.alwaysTemplate)
        case let .url(url, placeholder, cacheable):
            iconImageView.setImage(
                with: url,
                placeHolder: placeholder,
                cacheable: cacheable
            )
        }
    }

    func updateSize() {
        widthContainerConstraint.constant = size.containerSize.width
        heightContainerConstraint.constant = size.containerSize.height
        widthIconImageConstraint.constant = size.iconSize.width
        heightIconImageConstraint.constant = size.iconSize.height
        containerView.set(cornerRadius: size.cornerRadius)
        layoutIfNeeded()
    }

    func updateTheme() {
        iconImageView.tintColor = componentState == .active ? theme.iconActiveTintColor : theme.iconDisableTintColor
    }

    func updateUI(event: DSClickableIconGeneralEvent) {
        let background = event == .begin ? theme.highlightBackground : theme.defaultBackground
        DispatchQueue.main.async {
            self.containerView.backgroundColor = background
        }
    }
}
