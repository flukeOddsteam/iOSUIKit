//
//  DSClickableIconGeneral.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2566 BE.
//

import UIKit

public typealias DSClickableIconGeneralAction = ((_ tagId: Int) -> Void)

/**
 Custom component DSClickableIconGeneral

 ![image](/DocumentationImages/ds-clickable-icon-selection.png)

 **Usage Example:**
 1. Create UIView on .xib file and assign `DSClickableIconGeneral` Class to the UIView
 2. Binding constraint and don't set width and height. just set intrinsic to placeholder
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
```swift
    @IBOutlet weak var clickableIcon: DSClickableIconGeneral!

    override func viewDidLoad() {
        super.viewDidLoad()
        clickableIcon.setup(viewModel:
                         DSClickableIconGeneralViewModel(
                             title: "Button Label",
                             style: .light,
                             state: .active,
                             icon: .image(DSIcons.icon24OutlinePlaceholder.image)
                         )
        ) { tagId in
            debugPrint("Clickable icon did tapped with tagId: \(tagId)")
        }
    }
}
```
*/
public final class DSClickableIconGeneral: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    /// identifier of DSClickableIconGeneral. It will return when action is called
    public var tagId: Int = .zero

    /// action of DSClickableIconGeneral.
    public var action: DSClickableIconGeneralAction?

    /// title of DSClickableIconGeneral
    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }

    /// state of DSClickableIconGeneral
    public var state: DSClickableIconGeneralState = .active {
        didSet {
            updateState()
        }
    }

    /// style of DSClickableIconGeneral such as light, dark
    public var style: DSClickableIconGeneralStyle = .light {
        didSet {
            updateStyle()
        }
    }

    /// image object that contain type of image such as image object, url object.
    public var imageType: DSClickableIconGeneralImageType? {
        didSet {
            updateImage()
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

    /// Setup DSClickableIconGeneral
    ///
    /// Parameter for setup DSClickableIconGeneral
    /// - Parameter viewModel: view model of DSClickableIconGeneral that contain tagId, title, style, state, icon for setup to component.
    /// - Parameter action: callback action when user touch the component.
    public func setup(viewModel: DSClickableIconGeneralViewModel,
                      action: DSClickableIconGeneralAction?) {
        self.tagId = viewModel.tagId
        self.title = viewModel.title
        self.style = viewModel.style
        self.state = viewModel.state
        self.imageType = viewModel.icon
        self.action = action
    }

    /// Setup accessibility identifier DSClickableIconGeneral
    ///
    /// Parameter for setup accessibility identifier for DSClickableIconGeneral
    /// - Parameter accessibility: the object that contain attribute identifier of each element.
    public func setAccessibilityIdentifier(accessibility: DSClickableIconGeneralAccessibility) {
        self.accessibilityIdentifier = accessibility.viewId
        self.containerView.accessibilityIdentifier = accessibility.containerId
        self.iconImageView.accessibilityIdentifier = accessibility.iconImageViewId
        self.titleLabel.accessibilityIdentifier = accessibility.titleId
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
extension DSClickableIconGeneral {
    @objc func clickableDidTapped(_ gesture: UIGestureRecognizer) {
        action?(tagId)
    }
}

// MARK: - Private

private extension DSClickableIconGeneral {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
        updateStyle()
        updateState()
    }

    func setupUI() {
        titleLabel.font = DSFont.clickableLabel
        titleLabel.isUserInteractionEnabled = false
        iconImageView.tintColor = DSColor.componentLightDefault
        iconImageView.isUserInteractionEnabled = false
        iconImageView.tintAdjustmentMode = .normal

        containerView.backgroundColor = DSColor.componentLightBackground
        containerView.setRadius(radius: .radius16px)
        containerView.setBorder(width: 1, color: DSColor.componentLightOutlineClickable)
        containerView.dsShadowDrop()
        containerView.isUserInteractionEnabled = false
    }

    func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickableDidTapped(_:)))
        gesture.cancelsTouchesInView = false
        addGestureRecognizer(gesture)
    }

    func updateStyle() {
        titleLabel.textColor = style.textColor
    }

    func updateState() {
        alpha = state.alpha
        isUserInteractionEnabled = state.isUserInteractionEnabled
    }

    func updateImage() {
        if let imageType = self.imageType {
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
        } else {
            iconImageView.image = nil
        }
    }

    func updateUI(event: DSClickableIconGeneralEvent) {
        DispatchQueue.main.async {
            self.containerView.dsShadowDrop(isHidden: event.isHiddenShadow,
                                            style: .bottom)
        }
    }
}
