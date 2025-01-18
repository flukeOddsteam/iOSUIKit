//
//  DSSelectionRadioCardAvatarView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/3/2566 BE.
//

import UIKit

private enum Constants {
    static let numberOfLine: Int = 1
}

/**
 Custom component DSCheckboxCardAvatarLabelView for Design System
 
 ![image](/DocumentationImages/ds-radio-card-avatar-label-view.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSSelectionRadioCardAvatarView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
        @IBOutlet weak var selectionRadioCardAvatar1: DSSelectionRadioCardAvatarView!
         
        override func viewDidLoad() {
            super.viewDidLoad()
            
            selectionRadioCardAvatar1.setup(titleText: "Label Max 1 Line Label Max 1 Line Label Max 1 Line", avatarImage: nil, state: .default, action: { [unowned self] state in
                // Do somting here after user taped.
            })
        }
     ```
            
     Set label and set state as default:
     Set action as whatever you want it to do when DSSelectionRadioCardAvatarView is  tapped on:
      ```
         selectionRadioCardAvatar1.setup(titleText: "Label Max 1 Line Label Max 1 Line Label Max 1 Line", avatarImage: nil, state: .default, action: { [unowned self] state in
                // Do somting here after user taped.
         })
      ```

     Set label and set state as selected:
      ```
         selectionRadioCardAvatar2.setup(titleText: "Label Max 1 Line Label Max 1 Line Label Max 1 Line", avatarImage: nil, state: .selected, action: { [unowned self] state in
                // Do somting here after user taped.
         })
      ```

     Set label and set state as disable:
      ```
         selectionRadioCardAvatar3.setup(titleText: "Label Max 1 Line", avatarImage: nil, state: .disableUnselected, action: { [unowned self] state in
                // Do somting here after user taped.
         })
      ```
 */

public final class DSSelectionRadioCardAvatarView: UIView {

    @IBOutlet private weak var avatarView: DSAvatar!
    @IBOutlet private weak var radioView: RadioView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Public
    /// Variable for set action
    public var action: DSSelectionRadioAction?
    
    /// Variable for update titleText which is label.
    public var state: DSSelectionRadioState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    /// Variable for update titleText which is label.
    public var titleText: String = "" {
        didSet {
            updateTextTitle()
        }
    }
    
    private var avatarImage: UIImage? {
        didSet {
            self.setAvatarImage(avatarImage: avatarImage, state: self.state)
        }
    }
    
    /// For setup DSSelectionRadioView///
    ///
    /// Parameters for setup funtion
    /// - Parameter titleText: text to display.
    /// - Parameter avatarImage: avatar image .
    /// - Parameter state: state view.
    /// - Parameter action: action when tap.
    public func setup(titleText: String, avatarImage: UIImage?, state: DSSelectionRadioState, action: DSSelectionRadioAction?) {
        self.titleText = titleText
        self.state = state
        self.action = action
        self.avatarImage = avatarImage
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           radioViewId: String? = nil,
                                           titleLabelId: String? = nil,
                                           avatarViewId: String? = nil) {
        self.accessibilityIdentifier = id
        self.radioView.accessibilityIdentifier = radioViewId
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.avatarView.accessibilityIdentifier = avatarViewId
    }
}

// MARK: - Action
extension DSSelectionRadioCardAvatarView {
    @objc
    func selectionRadioViewDidTapped(_ gesture: UIGestureRecognizer) {
        guard state.isUserInteractonEnabled else {
            return
        }
        
        action?(state)
    }
}

// MARK: - Private
private extension DSSelectionRadioCardAvatarView {
    func commonInit() {
        setupXib()
        setupUI()
        updateAppearance()
        setupGesture()
    }
    
    func setupUI() {
        self.titleLabel.font = DSFont.buttonMedium
        self.titleLabel.numberOfLines = Constants.numberOfLine
    }
    
    func updateAppearance() {
        self.radioView.state = state
        self.layer.cornerRadius = state.radioCardCornerRadius
        self.titleLabel.textColor = state.titleColor
        containerView.layer.borderWidth = state.radioCardBorderWidth
        containerView.layer.borderColor = state.radioCardBorderColor.cgColor
        containerView.layer.cornerRadius = state.radioCardCornerRadius
        containerView.backgroundColor = state.radioCardBackgroundColor
        containerView.dsShadowDrop(isHidden: !state.radioCardShadowEnabled, style: .bottom)
    }
    
    func setAvatarImage(avatarImage: UIImage?, state: DSSelectionRadioState) {
        switch state {
        case .disableUnselected:
            self.avatarView.setup(style: .entity, avatarImage: avatarImage, state: .disable)
        default:
            self.avatarView.setup(avatarImage: avatarImage)
        }
    }
    
    func updateTextTitle() {
        self.titleLabel.text = titleText
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectionRadioViewDidTapped(_:)))
        self.addGestureRecognizer(tapGesture)
    }
}
