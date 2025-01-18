//
//  DSCheckboxCardAvatarLabelView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/3/2566 BE.
//

import UIKit

private enum Constants {
    static let numberOfLine: Int = 1
}

/**
 Custom component DSCheckboxCardAvatarLabelView for Design System
 
 ![image](/DocumentationImages/ds-checkbox-card-avatar-label-view)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSCheckboxCardAvatarLabelView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
        @IBOutlet weak var checkboxCardAvatarLabelView: DSCheckboxCardAvatarLabelView!
         
        override func viewDidLoad() {
            super.viewDidLoad()
                            
            checkboxCardAvatarLabelView.setup(titleText: "Label Max 1 Line Label Max 1 Line Label Max 1 Line ", avatarImage: nil, state: .default, action: { state in
                // Do somting here after user taped.
            })
     ```
 
    Set label and set state as default:
    Set action as whatever you want it to do when DSCheckboxCardAvatarLabelView is  tapped on:
     ```
        checkboxCardAvatarLabelView.setup(titleText: "Label Max 1 Line Label Max 1 Line Label Max 1 Line ", avatarImage: nil, state: .default, action: { state in
            // Do somting here after user taped.
        })
     ```
 
    Set label and set state as checked:
     ```
        checkboxCardAvatarLabelView.setup(titleText: "Label Max 1 Line Label Max 1 Line Label Max 1 Line ", avatarImage: nil, state: .checked), action: { state in
                // Do somting here after user taped.
         })
     ```
 
    Set label and set state as disableUnchecked:
     ```
        checkboxCardAvatarLabelView.setup(titleText: "Label Max 1 Line ", avatarImage: nil, state: .disableUnchecked, action: { state in
                // Do somting here after user taped.
         })
         ```
    Set label and set state as disableChecked:
      ```
        checkboxCardAvatarLabelView.setup(titleText: "Label Max 1 Line ", avatarImage: nil, state: .disableChecked, action: { state in
                // Do somting here after user taped.
          })
      ```
 */

public final class DSCheckboxCardAvatarLabelView: UIView {
    
    @IBOutlet private weak var avatarView: DSAvatar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var checkboxView: DSInputCheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    
    /// Variable for setting action
    public var action: DSSelectionCheckboxCardAction?

    /// Variable for updating state
    public var state: DSSelectionCheckboxState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    /// Variable for updating title
    public var titleText: String = "" {
        didSet {
            self.setupTitle()
        }
    }
    
    /// Variable for updating tagId
    public var tagId: Int = .zero
    
    private var avatarImage: UIImage? {
        didSet {
            self.setAvatarImage(avatarImage: avatarImage, state: self.state)
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
    
    /// For setup DSCheckboxCardAvatarLabelView.
    ///
    /// Parameters for setup funtion.
    /// - Parameter tagId: tag identity.
    /// - Parameter titleText: title.
    /// - Parameter avatarImage: avatar image.
    /// - Parameter state: view state.
    /// - Parameter action: action when tap.
    public func setup(tagId: Int = .zero,
                      titleText: String,
                      avatarImage: UIImage?,
                      state: DSSelectionCheckboxState,
                      action: DSSelectionCheckboxCardAction? = nil) {
        self.state = state
        self.action = action
        self.titleText = titleText
        self.avatarImage = avatarImage
    }
}

// MARK: - Action
extension DSCheckboxCardAvatarLabelView {
    @objc func checkboxViewDidTapped(_ sender: Any) {
        guard state.isUserInteractonEnabled else {
            return
        }
        if self.state == .checked {
            self.state = .default
        } else if self.state == .default {
            self.state = .checked
        }
        action?(state)
    }
}

// MARK: - Private
private extension DSCheckboxCardAvatarLabelView {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        self.titleLabel.font = DSFont.buttonMedium
        self.titleLabel.textColor = DSColor.componentLightDefault
        self.titleLabel.numberOfLines = Constants.numberOfLine
    }
    
    func updateAppearance() {
        self.checkboxView.state = state
        self.layer.cornerRadius = state.cardCornerRadius
        containerView.layer.borderWidth = state.cardBorderWidth
        containerView.layer.borderColor = state.cardBorderColor.cgColor
        containerView.layer.cornerRadius = state.cardCornerRadius
        containerView.backgroundColor = state.cardBackgroundColor
        containerView.dsShadowDrop(isHidden: !state.cardShadowEnabled, style: .bottom)
    }
    
    func setupTitle() {
        self.titleLabel.text = titleText
        
        switch self.state {
        case .disableUnchecked, .disableChecked:
            self.titleLabel.textColor = DSColor.componentDisableDefault
        default:
            self.titleLabel.textColor = DSColor.componentLightDefault
        }
    }
    
    func setAvatarImage(avatarImage: UIImage?, state: DSSelectionCheckboxState) {
        switch state {
        case .disableUnchecked, .disableChecked:
            self.avatarView.setup(style: .entity, avatarImage: avatarImage, state: .disable)
        default:
            self.avatarView.setup(avatarImage: avatarImage)
        }
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(checkboxViewDidTapped(_:)))
       containerView.addGestureRecognizer(tap)
    }
}
