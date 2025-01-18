//
//  DSClickableIconSelection.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/3/2566 BE.
//

import UIKit

private enum Constants {
    static let defaultPlaceholderImage: UIImage = DSImage.placeholder1x1.image
    static let defaultPlaceholderIcon: DSIcons = .icon36OutlinePlaceholder
    static let imageCircleSize: CGSize = CGSize(width: 56.0, height: 56.0)
    static let imageRectangleSize: CGSize = CGSize(width: 48.0, height: 48.0)
    static let selecedImageCircleLeading: CGFloat = -16
    static let selecedImageRectangleLeading: CGFloat = -12
    static let selectedImageRectangleTop: CGFloat = -2
    static let imageRectanglePadding: CGFloat = 12.0
    static let imageRectangleCornerRadius: CGFloat = 16.0
}

/**
 Custom component DSClickableSelection
 
 ![image](/DocumentationImages/ds-clickable-icon-selection.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSClickableSelection` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
```swift
    @IBOutlet weak var clickableSelection: DSClickableSelection!
  
    override func viewDidLoad() {
        super.viewDidLoad()
            clickableSelection.setup(title: "Button Label Button Label",
                                    style: .icon(.icon36OutlinePlaceholder),
                                    state: .default) { tagId in
        // Do something
    }
}
```
*/

public final class DSClickableSelection: UIView {
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var selectedView: ClickableSelectionSelectedView!
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var selecedImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedImageViewTopConstraint: NSLayoutConstraint!
    
    /// ImageView Constraint
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    /// Variable for set tag ID of DSClickableSelection.
    public var tagId: Int = .zero
    
    /// Variable for set state of DSClickableSelection.
    public var state: DSClickableIconSelectionState = .default {
        didSet {
            updateState()
        }
    }
    
    /// Variable for set style of DSClickableSelection.
    public var style: DSClickableIconSelectionStyle = .icon(Constants.defaultPlaceholderIcon) {
        didSet {
            updateStyle()
        }
    }
    
    /// Variable for set style of DSClickableSelection.
    public var shape: DSClickableIconSelectionShape = .circle {
        didSet {
            updateShapeStyle()
            setImagePaddingAll()
        }
    }
    
    /// Variable for set text title of DSClickableSelection.
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    /// Variable for set contentMode in ImageView.
    public var imageContentMode: ContentMode = .scaleAspectFit {
        didSet {
            iconImageView.contentMode = imageContentMode
        }
    }
    
    /// Variable for set Enable of DSClickableSelection.
    public var isEnable: Bool = true {
        didSet {
            setEnable(isEnable)
        }
    }
    
    /// Callback when user tap clickable selection.
    public var clickableDidTapped: ((Int) -> Void)?
    
    private var isPressed: Bool = false
    private var isSholdDSShadow: Bool {
        if isEnable {
            return isPressed
        }
        return true
    }
    
    private var tintStyleColor: UIColor {
        return isEnable ? DSColor.componentLightDefault : DSColor.componentDisableDefault
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSClickableSelection
    ///
    /// Parameter for setup DSClickableSelection
    /// - Parameter tagId: id number of DSClickableSelection.
    /// - Parameter title: title of DSClickableSelection. Default is empty string.
    /// - Parameter style: style of DSClickableSelection. (mandatory).
    /// - Parameter shape: shape of DSClickableSelection.
    /// - Parameter state: state of DSClickableSelection.
    /// - Parameter isEnable: enable state of DSClickableSelection.
    /// - Parameter clickableDidTapped: callback closure of DSClickableSelection. When user tap DSClickableSelection this closure will trigger and pass parameter tagId.
    public func setup(tagId: Int = .zero,
                      title: String,
                      style: DSClickableIconSelectionStyle,
                      shape: DSClickableIconSelectionShape = .circle,
                      state: DSClickableIconSelectionState = .default,
                      isEnable: Bool = true,
                      clickableDidTapped: ((Int) -> Void)? = nil) {
        self.tagId = tagId
        self.title = title
        self.shape = shape
        self.style = style
        self.state = state
        self.isEnable = isEnable
        self.clickableDidTapped = clickableDidTapped
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isPressed = true
        
        dispatchMainThread { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.updateState()
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isPressed = false
        
        dispatchMainThread {
            self.updateState()
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isPressed = false
        
        dispatchMainThread {
            self.updateState()
        }
    }
}

// MARK: - Action
extension DSClickableSelection {
    @objc func clickableDidTapped(_ gesture: UIGestureRecognizer) {
        clickableDidTapped?(tagId)
    }
}

// MARK: - Private
private extension DSClickableSelection {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
        updateStyle()
        updateState()
        updateOverlay()
    }
    
    func setupUI() {
        titleLabel.font = DSFont.clickableLabel
        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.lineBreakMode = .byTruncatingTail
        
        imageContainerView.clipsToBounds = false
        
        iconImageView.clipsToBounds = true
        iconImageView.isUserInteractionEnabled = false
        iconImageView.tintAdjustmentMode = .normal
        
        // update Shape style
        updateShapeStyle()
        imageContentMode = .scaleAspectFit
    }
    
    func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickableDidTapped(_:)))
        addGestureRecognizer(gesture)
    }
    
    func updateState() {
        let backgroundColor = isPressed ? state.onPressedBackgroundColor : state.defaultBackgroundColor
        imageContainerView.backgroundColor = isEnable ? backgroundColor : DSColor.componentDisableBackgroundPrimary
        
        let borderWidth = isPressed ? state.onPressedBorderWidth : state.defaultBorderWidth
        let borderColor = isEnable ? (isPressed ? state.onPressedBorderColor(shape: shape) : state.defaultBorderColor(shape: shape)) : state.disableBackgroundColor
        imageContainerView.setBorder(width: borderWidth, color: borderColor)
        
        imageContainerView.dsShadowDrop(isHidden: isSholdDSShadow, style: .bottom)
        selectedView.isHidden = !state.isShowSelectedView
        let state: ClickableSelectionSelectedState = isEnable ? (isPressed ? .onPressed : .default) : .disable
        selectedView.state = state
    }
    
    func updateStyle() {
        switch style {
        case .icon(let icon):
            iconImageView.image = icon.image.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = tintStyleColor
        case .image(let type):
            switch type {
            case .image(let image):
                iconImageView.image = image
                
            case let .url(url, cacheable):
                iconImageView.setImage(with: url,
                                       placeHolder: Constants.defaultPlaceholderImage,
                                       cacheable: cacheable)
            }
            iconImageView.tintColor = .clear
        case .placeholderIcon:
            iconImageView.tintColor = tintStyleColor
            iconImageView.image = Constants.defaultPlaceholderIcon.image.withRenderingMode(.alwaysTemplate)
        case .placeholderImage:
            iconImageView.tintColor = DSColor.otherBackgroundLoadingIcon
            iconImageView.image = Constants.defaultPlaceholderImage
        }
        
        // set resize image ratio
        if shape == .rectangle {
            imageViewWidthConstraint.constant = Constants.imageRectangleSize.width
            imageViewHeightConstraint.constant = Constants.imageRectangleSize.height
            
            selecedImageViewLeadingConstraint.constant = Constants.selecedImageRectangleLeading
            selectedImageViewTopConstraint.constant = Constants.selectedImageRectangleTop
        } else {
            selecedImageViewLeadingConstraint.constant = Constants.selecedImageCircleLeading
            imageViewWidthConstraint.constant = Constants.imageCircleSize.width
            imageViewHeightConstraint.constant = Constants.imageCircleSize.height
        }
        setImagePaddingAll()
    }
    
    func updateShapeStyle() {
        // check style image set circle only
        // reset circle
        imageContainerView.setCircle()
        iconImageView.setCircle()
        if case .image = style, case .placeholderImage = style { return }
        if shape == .rectangle {
            imageContainerView.layer.cornerRadius = Constants.imageRectangleCornerRadius
            iconImageView.setRectangle(-4)
        }
    }
    
    func updateOverlay() {
        overlayView.backgroundColor = DSColor.componentLightBackground
        overlayView.alpha = 0.8
        switch style {
        case .image, .placeholderImage: ()
            overlayView.isHidden = isEnable
        default:
            overlayView.isHidden = true
        }
    }
    
    func setEnable(_ enable: Bool) {
        self.isUserInteractionEnabled = enable
        titleLabel.textColor = tintStyleColor
        updateStyle()
        updateState()
        updateOverlay()
    }
    
    func setImagePaddingAll() {
        if shape == .rectangle {
            let paddingPoint = Constants.imageRectanglePadding
            imageViewTopConstraint.constant = paddingPoint
            imageViewTrailingConstraint.constant = paddingPoint
            imageViewLeadingConstraint.constant = paddingPoint
            imageViewBottomConstraint.constant = paddingPoint
        }
    }
    
    func dispatchMainThread(action: @escaping () -> Void) {
        DispatchQueue.main.async {
            action()
        }
    }
}
