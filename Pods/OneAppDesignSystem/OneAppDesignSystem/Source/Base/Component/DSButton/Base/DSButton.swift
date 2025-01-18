import UIKit

public class DSButton: UIControl {

    @IBInspectable
    public var xPaddingTouchArea: CGFloat = 0
    
    @IBInspectable
    public var yPaddingTouchArea: CGFloat = 0
    
    public var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    public var iconRightImage: UIImage? {
        didSet {
            iconRight.image = iconRightImage?.resizedImage(size: sizeImage).withRenderingMode(.alwaysTemplate)
        }
    }
    
    public var iconLeftImage: UIImage? {
        didSet {
            iconLeft.image = iconLeftImage?.resizedImage(size: sizeImage).withRenderingMode(.alwaysTemplate)
        }
    }
    
    public override var isUserInteractionEnabled: Bool {
        didSet {
            if !isUserInteractionEnabled {
                setStyleDisable(style: currentStyle)
            } else {
                setupStyle(style: currentStyle)
            }
        }
    }

    // MARK: - Private
    private let contentView = UIView(frame: CGRect.zero)
    private let parentView = UIView(frame: CGRect.zero)
    private let viewButton = UIView(frame: CGRect.zero)
    private let titleLabel = UILabel(frame: CGRect.zero)
    private let iconLeft = UIImageView(frame: CGRect.zero)
    private let iconRight = UIImageView(frame: CGRect.zero)
    private var stackView = UIStackView(frame: CGRect.zero)

    private var sizeImage: CGSize = .zero
    private var currentStyle: DSButtonStyle = .primary

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateTouchEventUI(event: .began)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateTouchEventUI(event: .end)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        updateTouchEventUI(event: .cancelled)
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let area = self.bounds.insetBy(
            dx: -xPaddingTouchArea,
            dy: -yPaddingTouchArea
        )
        return area.contains(point)
    }
    
    public func setStyle(_ style: DSButtonStyle) {
        self.currentStyle = style
        setupStyle(style: style)
    }
    
    func setup(style: DSButtonStyle, size: DSButtonSize, content: DSButtonContent) {
        self.sizeImage = size.iconImageSize
        setupSubViews()
        
        setupStyle(style: style)
        setupContent(content: content, sizeImage: size.iconImageSize)
        setupSize(size: size, content: content)
        
        DispatchQueue.main.async {
            switch content {
            case .textOnlyNoPadding:
                if self.parentView.bounds.width > 32 {
                    self.parentView.setCircle()
                } else {
                    self.parentView.setRadius(radius: DSRadius.radius8px)
                }
            default:
                self.manageCornerRadiusButton()
            }
        }
        layoutIfNeeded()
    }
    
    public func setAccessibilityIdentifier(id: String? = nil, titleLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        titleLabel.accessibilityIdentifier = titleLabelId
    }
}

// MARK: - Private
private extension DSButton {
    
    func setupSubViews() {
        titleLabel.layer.masksToBounds = true
        titleLabel.clipsToBounds = true
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        
        iconLeft.contentMode = .scaleAspectFit
        iconRight.contentMode = .scaleAspectFit
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        parentView.addSubview(stackView)
        self.addSubview(parentView)
        parentView.isUserInteractionEnabled = false
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor)
        iconLeft.translatesAutoresizingMaskIntoConstraints = false
        iconRight.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        iconLeft.tintAdjustmentMode = .normal
        iconRight.tintAdjustmentMode = .normal
    }
    
    func setupSize(size: DSButtonSize, content: DSButtonContent) {
        switch size {
        case .large:
            titleLabel.font = DSFont.buttonBig
            parentView.heightAnchor.constraint(greaterThanOrEqualToConstant: DSButtonHeightConstant.large.rawValue).isActive = true
            setupIconConstraint(content: content, iconHeight: DSButtonIconSizeConstant.large.rawValue)
            if case .iconOnly = content {
                setupContentPadding(paddingTopAndBottom: 8, paddingLeft: 8, paddingRight: 8)
            } else {
                setupContentPadding(paddingTopAndBottom: 8, paddingLeft: 16, paddingRight: 16)
            }
        case .medium:
            titleLabel.font = DSFont.buttonMedium
            parentView.heightAnchor.constraint(greaterThanOrEqualToConstant: DSButtonHeightConstant.medium.rawValue).isActive = true
            setupIconConstraint(content: content, iconHeight: DSButtonIconSizeConstant.medium.rawValue)
            if case .iconOnly = content {
                setupContentPadding(paddingTopAndBottom: 8, paddingLeft: 8, paddingRight: 8)
            } else {
                setupContentPadding(paddingTopAndBottom: 8, paddingLeft: 16, paddingRight: 16)
            }
        case .small:
            titleLabel.font = DSFont.buttonSmall
            parentView.heightAnchor.constraint(greaterThanOrEqualToConstant: DSButtonHeightConstant.small.rawValue).isActive = true
            setupIconConstraint(content: content, iconHeight: DSButtonIconSizeConstant.small.rawValue)
            switch content {
            case .iconOnly:
                setupContentPadding(paddingTopAndBottom: 4, paddingLeft: 8, paddingRight: 8)
            case .iconLeftNoPaddingAndText:
                stackView.spacing = 4
                setupContentPadding(paddingTopAndBottom: 4, paddingLeft: 0, paddingRight: 8)
            case .iconRightNoPaddingAndText:
                stackView.spacing = 4
                setupContentPadding(paddingTopAndBottom: 4, paddingLeft: 8, paddingRight: 0)
            case .iconRightNoPaddingLeftAndRight, .iconLeftNoPaddingLeftAndRight:
                stackView.spacing = 4
                setupContentPadding(paddingTopAndBottom: 4, paddingLeft: 0, paddingRight: 0)
            case .textOnlyNoPadding:
                setupContentPadding(paddingTopAndBottom: 4, paddingLeft: 0, paddingRight: 0)
            default:
                setupContentPadding(paddingTopAndBottom: 4, paddingLeft: 12, paddingRight: 12)
            }
        }
    }
    
    func setupIconConstraint(content: DSButtonContent, iconHeight: CGFloat) {
        if case .iconOnly = content {
            iconLeft.widthAnchor.constraint(equalToConstant: iconHeight).isActive = true
        } else {
            iconLeft.widthAnchor.constraint(equalToConstant: iconHeight).isActive = true
            iconRight.widthAnchor.constraint(equalToConstant: iconHeight).isActive = true
        }
    }
    
    func setupContentPadding(paddingTopAndBottom: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat) {
        stackView.anchor(top: parentView.topAnchor,
                         left: parentView.leftAnchor,
                         bottom: parentView.bottomAnchor,
                         right: parentView.rightAnchor,
                         paddingTop: paddingTopAndBottom,
                         paddingLeft: paddingLeft,
                         paddingBottom: paddingTopAndBottom,
                         paddingRight: paddingRight)
    }
    
    func setupContent(content: DSButtonContent, sizeImage: CGSize) {
        let minimumWidth: CGFloat = 80
        switch content {
        case .iconOnly(let image):
            iconLeft.image = image.resizedImage(size: sizeImage).withRenderingMode(.alwaysTemplate)
            stackView.addArrangedSubview(iconLeft)
        case .iconLeftAndText(let image, let text), .iconLeftNoPaddingAndText(let image, let text):
            iconLeft.image = image.resizedImage(size: sizeImage).withRenderingMode(.alwaysTemplate)
            titleLabel.text = text
            stackView.addArrangedSubview(iconLeft)
            stackView.addArrangedSubview(titleLabel)
        case .iconRightAndText(let image, let text), .iconRightNoPaddingAndText(let image, let text):
            iconRight.image = image.resizedImage(size: sizeImage).withRenderingMode(.alwaysTemplate)
            titleLabel.text = text
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(iconRight)
        case .textOnly(let text):
            titleLabel.text = text
            stackView.addArrangedSubview(titleLabel)
            parentView.widthAnchor.constraint(greaterThanOrEqualToConstant: minimumWidth).isActive = true
        case .iconRightNoPaddingLeftAndRight(let image, let text):
            iconRight.image = image.resizedImage(size: sizeImage).withRenderingMode(.alwaysTemplate)
            titleLabel.text = text
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(iconRight)
        case .iconLeftNoPaddingLeftAndRight(let image, let text):
            iconLeft.image = image.resizedImage(size: sizeImage).withRenderingMode(.alwaysTemplate)
            titleLabel.text = text
            stackView.addArrangedSubview(iconLeft)
            stackView.addArrangedSubview(titleLabel)
        case .textOnlyNoPadding(text: let text):
            titleLabel.text = text
            stackView.addArrangedSubview(titleLabel)
            parentView.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        }
    }
    
    func setupStyle(style: DSButtonStyle) {
        currentStyle = style
        stackView.backgroundColor = .clear
        switch style {
        case .primary:
            iconLeft.tintColor = DSColor.componentPrimaryDefault
            iconRight.tintColor = DSColor.componentPrimaryDefault
            parentView.backgroundColor = DSColor.componentPrimaryBackground
            titleLabel.textColor = DSColor.componentPrimaryDefault
        case .secondary:
            parentView.layer.borderColor = DSColor.componentSecondaryOutline.cgColor
            parentView.layer.borderWidth = 1
            parentView.backgroundColor = DSColor.componentSecondaryBackground
            titleLabel.textColor = DSColor.componentSecondaryDefault
            iconLeft.tintColor = DSColor.componentSecondaryDefault
            iconRight.tintColor = DSColor.componentSecondaryDefault
        case .ghost:
            iconLeft.tintColor = DSColor.componentGhostDefault
            iconRight.tintColor = DSColor.componentGhostDefault
            parentView.backgroundColor = DSColor.componentGhostBackground
            titleLabel.textColor = DSColor.componentGhostDefault
        case .ghostDark:
            iconLeft.tintColor = DSColor.pageDarkComponentGhostDefault
            iconRight.tintColor = DSColor.pageDarkComponentGhostDefault
            parentView.backgroundColor = DSColor.pageDarkComponentGhostBackground
            titleLabel.textColor = DSColor.pageDarkComponentGhostDefault
        }
    }
    
    func setStyleDisable(style: DSButtonStyle) {
        switch style {
        case .primary:
            parentView.backgroundColor = DSColor.componentDisableBackground
            titleLabel.textColor = DSColor.componentDisableDefault
            iconLeft.tintColor = DSColor.componentDisableDefault
            iconRight.tintColor = DSColor.componentDisableDefault
        case .secondary:
            parentView.layer.borderColor = DSColor.componentDisableOutline.cgColor
            parentView.layer.borderWidth = 1
            parentView.backgroundColor = DSColor.componentDisableBackground
            titleLabel.textColor = DSColor.componentDisableDefault
            iconLeft.tintColor = DSColor.componentDisableDefault
            iconRight.tintColor = DSColor.componentDisableDefault
        case .ghost:
            parentView.backgroundColor = DSColor.componentGhostBackground
            titleLabel.textColor = DSColor.componentDisableDefault
            iconLeft.tintColor = DSColor.componentDisableDefault
            iconRight.tintColor = DSColor.componentDisableDefault
        case .ghostDark:
            parentView.backgroundColor = DSColor.pageDarkComponentGhostBackground
            titleLabel.textColor = DSColor.componentDisableDefault
            iconLeft.tintColor = DSColor.componentDisableDefault
            iconRight.tintColor = DSColor.componentDisableDefault
        }
    }
    
    func manageCornerRadiusButton() {
        parentView.layer.cornerRadius = parentView.bounds.height / 2
    }

    func updateTouchEventUI(event: DSButtonGestureEvent) {
        let appearance: ButtonAppearance = ButtonViewModel(
            style: currentStyle,
            onTouch: event.isTouchEvent
        )

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.parentView.backgroundColor = appearance.highlightColor
        }
    }
}

// MARK: - Private UIImage
private extension UIImage {
    func resizedImage(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in self.draw(in: CGRect(origin: .zero, size: size)) }
    }
}
