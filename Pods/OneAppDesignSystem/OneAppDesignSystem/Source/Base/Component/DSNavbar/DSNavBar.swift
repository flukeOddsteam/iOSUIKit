//
//  DSNavBar.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/4/2566 BE.
//

import UIKit

/**
    Method for managing event for `DSNavBar`. Just conform protocol `DSNavBarDelegate`
 ```
 extension ViewController: DSNavBarDelegate {
    func navBarBackButtonDidTapped(_ view: DSNavBar) { }
    func navBarPrimaryButtonDidTapped(_ view: DSNavBar) { }
    func navBarSecondaryButtonDidTapped(_ view: DSNavBar) { }
    func navBarGhostButtonDidTapped(_ view: DSNavBar) { }
    func navBarCloseButtonDidTapped(_ view: DSNavBar) { }
 }
 ```
 */

public protocol DSNavBarDelegate: AnyObject {
    func navBarBackButtonDidTapped(_ view: DSNavBar)
    func navBarPrimaryButtonDidTapped(_ view: DSNavBar)
    func navBarSecondaryButtonDidTapped(_ view: DSNavBar)
    func navBarGhostButtonDidTapped(_ view: DSNavBar)
    func navBarCloseButtonDidTapped(_ view: DSNavBar)
}

public extension DSNavBarDelegate {
    func navBarBackButtonDidTapped(_ view: DSNavBar) { }
    func navBarPrimaryButtonDidTapped(_ view: DSNavBar) { }
    func navBarSecondaryButtonDidTapped(_ view: DSNavBar) { }
    func navBarGhostButtonDidTapped(_ view: DSNavBar) { }
    func navBarCloseButtonDidTapped(_ view: DSNavBar) { }
}

public extension DSNavBarDelegate where Self: UIViewController {
    func navBarBackButtonDidTapped(_ view: DSNavBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navBarCloseButtonDidTapped(_ view: DSNavBar) {
        self.dismiss(animated: true)
    }
}

/**
 Custom component DSNavBar for Design System
 
 ![image](/DocumentationImages/ds-nav-bar-light.png)
 ![image](/DocumentationImages/ds-nav-bar-dark.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSNavBar` Class to the UIView
 2. Binding constraint top, leading, trailing
 3. Set placeholder on storyboard/nib
 4. Connect UIView to `@IBOutlet` in text editor
 5. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
    @IBOutlet weak var navigationBar: DSNavBar!

     override func viewDidLoad() {
         navigationBar.setup(title: "Title", style: .backButtonOnly, theme: .light, isAchorWithSuperView: false)
         navigationBar.delegate = self
         navigationBar.setupScrollView(scrollView)
     }
     ```
 */
public final class DSNavBar: UIView {
    
    // MARK: - Public
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ghostButton: DSGhostButton!
    @IBOutlet weak var backButton: DSClickableIconBadge!
    @IBOutlet weak var primaryRightButton: DSClickableIconBadge!
    @IBOutlet weak var secondaryRightButton: DSClickableIconBadge!
    @IBOutlet weak var closeButton: DSClickableIconBadge!
    @IBOutlet weak var topContentConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightHorizontalStackView: UIStackView!
    @IBOutlet weak var leftContainerView: UIView!
    
    @IBOutlet weak var betaPill: DSPill!
    /// The properties that contain style
    public var style: DSNavBarStyle = .backButtonOnly {
        didSet {
            updateStyle()
        }
    }
    
    /// The properties that contain theme, such as light/dark
    public var theme: DSNavBarTheme = .light {
        didSet {
            updateTheme()
        }
    }
    
    /// The properties for update shadow
    public var isShadowEnabled: Bool = false {
        didSet {
            dsShadowDrop(isHidden: !isShadowEnabled)
        }
    }
    
    /// The properties for update navigation bar title
    public var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    /// The properties for update padding with status bar height
    public var isAchorWithSuperView: Bool = false {
        didSet {
            updateSafeAreaPadding()
        }
    }

    public var isBeta: Bool = false {
        didSet {
            betaPill.isHidden = !isBeta
        }
    }
    /// The object that acts as the delegate of the DSNavBar.
    public weak var delegate: DSNavBarDelegate?
    
    // MARK: - Private variable
    private var scrollObserver: NSKeyValueObservation?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    deinit {
        removeScrollViewObserver()
    }
    
    /// Setup DSNavBar
    ///
    /// Parameter for setup DSNavBar
    /// - Parameter title: title of navigation bar (mandatory).
    /// - Parameter style: style of navigation bar (mandatory). example backButtonOnly/closeButtonOnly
    /// - Parameter theme: theme of navigation bar (mandatory). such as light/dark.
    /// - Parameter isAchorWithSuperView: boolean for update padding that include status bar frame or not. default is false.
    public func setup(title: String,
                      style: DSNavBarStyle,
                      theme: DSNavBarTheme,
                      isAchorWithSuperView: Bool = false) {
        self.isAchorWithSuperView = isAchorWithSuperView
        self.title = title
        self.style = style
        self.theme = theme
    }
    
    /// Function for setup automatic display border of navbar.
    public func setupScrollView(_ scrollView: UIScrollView) {
        removeScrollViewObserver()
        scrollObserver = scrollView.observe(\.contentOffset, options: .new) { [weak self] scrollView, change in
            self?.contentDidScroll(scrollView, change: change)
        }
    }

    public func setShadowDrop(isHidden: Bool) {
        self.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }

    public func setupAccessibilityIdentifier(id: String? = nil,
                                             titleId: String? = nil,
                                             backButtonId: String? = nil,
                                             closeButtonId: String? = nil,
                                             primaryButtonId: String? = nil,
                                             secondaryButtonId: String? = nil,
                                             ghostButtonId: String? = nil) {
        self.accessibilityIdentifier = id
        self.titleLabel.accessibilityIdentifier = titleId
        self.backButton.accessibilityIdentifier = backButtonId
        self.closeButton.accessibilityIdentifier = closeButtonId
        self.primaryRightButton.accessibilityIdentifier = primaryButtonId
        self.secondaryRightButton.accessibilityIdentifier = secondaryButtonId
        self.ghostButton.accessibilityIdentifier = ghostButtonId
    }
}
// MARK: - Action
extension DSNavBar {
    @IBAction func backButtonDidTapped(_ sender: Any) {
        delegate?.navBarBackButtonDidTapped(self)
    }
    
    @IBAction func ghostButtonDidTapped(_ sender: Any) {
        delegate?.navBarGhostButtonDidTapped(self)
    }
    
    @IBAction func primaryRightButtonDidTapped(_ sender: Any) {
        delegate?.navBarPrimaryButtonDidTapped(self)
    }
    
    @IBAction func secondaryRightButtonDidTapped(_ sender: Any) {
        delegate?.navBarSecondaryButtonDidTapped(self)
    }
    
    @IBAction func closeButtonDidTapped(_ sender: Any) {
        delegate?.navBarCloseButtonDidTapped(self)
    }
   
}
// MARK: - Private
private extension DSNavBar {
    func commonInit() {
        setupXib()
        setupUI()
        updateStyle()
        updateTheme()
    }
    
    func setupUI() {
        titleLabel.font = DSFont.pageTitle
        ghostButton.mediumGhostText(text: "")
        backButton.setup(style: theme.clickableStyle,
                         image: DSIcons.icon24OutlineChevronLeft.image)
        closeButton.setup(style: theme.clickableStyle,
                          image: DSIcons.icon24Close.image)
        primaryRightButton.setup(style: .ghost,
                                 image: DSIcons.icon24OutlinePlaceholder.image)
        secondaryRightButton.setup(style: .ghost,
                                   image: DSIcons.icon24OutlinePlaceholder.image)

        betaPill.setup(style: .status(.default), title: "BETA")
    }
    
    func updateSafeAreaPadding() {
        let padding = isAchorWithSuperView ? UIApplication.getStatusBarFrame().height : .zero
        topContentConstraint.constant = padding
        layoutIfNeeded()
    }
    
    func updateStyle() {
        backButton.isHidden = style.isBackButtonHidden
        primaryRightButton.isHidden = style.isPrimaryIconHidden
        secondaryRightButton.isHidden = style.isSecondaryIconHidden
        closeButton.isHidden = style.isCloseButtonHidden
        ghostButton.isHidden = style.isGhostButtonHidden
        rightHorizontalStackView.isHidden = style.isRightStackViewHidden
        leftContainerView.isHidden = style.leftContainerViewHidden
        switch style {
        case .backButtonWithSingleClickable(let icon):
            primaryRightButton.setIconImage(icon)
        case .backButtonWithMultipleClickable(let primaryIcon, let secondaryIcon, let isHideBackButton):
            primaryRightButton.setIconImage(primaryIcon)
            secondaryRightButton.setIconImage(secondaryIcon)
        case .backButtonWithGhost(let title):
            ghostButton.titleText = title
        default:
            break
        }
    }
    
    func updateTheme() {
        let appearance: NavBarThemeAppearance = theme
        
        titleLabel.textColor = appearance.titleColor
        backgroundColor = appearance.backgroundColor
        
        closeButton.setStyle(appearance.clickableStyle)
        backButton.setStyle(appearance.clickableStyle)
        primaryRightButton.setStyle(appearance.clickableStyle)
        secondaryRightButton.setStyle(appearance.clickableStyle)
        ghostButton.setStyle(appearance.ghostButtonStyle)
    }
    
    func contentDidScroll(_ scrollView: UIScrollView, change: NSKeyValueObservedChange<CGPoint>) {
        let isHidden = scrollView.contentOffset.y <= 0
        self.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
    
    func removeScrollViewObserver() {
        scrollObserver?.invalidate()
        scrollObserver = nil
    }
}
