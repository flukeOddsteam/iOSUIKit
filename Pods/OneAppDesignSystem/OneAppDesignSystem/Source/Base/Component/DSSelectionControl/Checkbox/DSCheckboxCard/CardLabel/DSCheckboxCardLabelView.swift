//
//  DSCheckboxCardLabelView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/2/2566 BE.
//

import UIKit

private enum Constants {
    static let numberOfLine: Int = 1
}

/**
 Custom component DSCheckboxCardLabelView for Design System
 
 ![image](/DocumentationImages/ds-checkbox-card-label.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSCheckboxCardLabelView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
        @IBOutlet weak var checkboxCardLabel: DSCheckboxCardLabelView!
         
        override func viewDidLoad() {
            super.viewDidLoad()
            checkboxCardLabel.setup(tagId: 1,
                                    titleText: "Label Max 1 Line Label Max 1 Line Label Max 1 Line",
                                    state: .default) { currentState in
            }
        }
     ```
 */

public final class DSCheckboxCardLabelView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var checkboxView: DSInputCheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    
    /// Variable for setting action of DSCheckboxCardLabelView
    public var action: DSSelectionCheckboxCardAction?

    /// Variable for updating state of DSCheckboxCardLabelView
    public var state: DSSelectionCheckboxState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    /// Variable for updating titleText, which is a label of DSCheckboxCardLabelView
    public var titleText: String = "" {
        didSet {
            self.titleLabel.text = titleText
        }
    }
    
    /// Variable for updating tagId of DSCheckboxCardLabelView
    public var tagId: Int = .zero
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// For setup DSCheckboxCardLabelView.
    ///
    /// Parameter for setup DSCheckboxCardLabelView.
    /// - Parameter tagId: tag identity of DSCheckboxCardLabelView.
    /// - Parameter titleText: title of DSCheckboxCardLabelView.
    /// - Parameter state: state of DSCheckboxCardView.
    /// - Parameter action: action when tap on DSCheckboxCardView.
    public func setup(tagId: Int = .zero,
                      titleText: String,
                      state: DSSelectionCheckboxState,
                      action: DSSelectionCheckboxCardAction? = nil) {
        self.state = state
        self.action = action
        self.titleText = titleText
    }
}

// MARK: - Action
extension DSCheckboxCardLabelView {
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
private extension DSCheckboxCardLabelView {
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
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(checkboxViewDidTapped(_:)))
       containerView.addGestureRecognizer(tap)
    }
}
