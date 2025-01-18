//
//  DSSelectionRadioCardView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/9/2565 BE.
//

import UIKit

private enum Constants {
	static let numberOfLine: Int = 1
}

/**
 Custom component DSSelectionRadioCard for Design System
 
 ![image](/DocumentationImages/ds-selection-radio-card.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSSelectionRadioCardView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
        @IBOutlet weak var radioCardView: DSSelectionRadioCardView!
         
        override func viewDidLoad() {
            super.viewDidLoad()
            radioCardView.setup(titleText: "Label Max 1 Line", state: .disableUnselected, action: { state in
                print("radioCardView current state: \(state)")
            })
     ```
 
    Set label and set state as default for DSSelectionRadioCard:
    Set action as whatever you want it to do when DSSelectionRadioView is  tapped on:
     ```
        radioCardView.setup(titleText: "Your Label", state: .default, action: { state in
            print("radioCardView current state: \(state)")
        })
     ```
 
    Set label and set state as selected for DSSelectionRadioCard:
     ```
         radioCardView.setup(titleText: "Your Label", state: .selected, action: { state in
             print("radioCardView current state: \(state)")
         })
     ```
 
    Set label and set state as disable for DSSelectionRadioCard:
     ```
         radioCardView.setup(titleText: "Your Label", state: .disableUnselected, action: { state in
             print("radioCardView current state: \(state)")
         })
     ```
 */
public final class DSSelectionRadioCardView: UIView {
    
	@IBOutlet private weak var radioView: RadioView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet weak var containerView: UIView!
	
	// MARK: - Public
    /// Variable for set action of DSSelectionRadioCardView
	public var action: DSSelectionRadioAction?
    
    /// Variable for update titleText which is label of DSSelectionRadioCardView.
	public var state: DSSelectionRadioState = .default {
		didSet {
			updateAppearance()
		}
	}
	
    /// Variable for update titleText which is label of DSSelectionRadioCardView.
	public var titleText: String = "" {
		didSet {
			updateTextTitle()
		}
	}
	
    /// For setup DSSelectionRadioView///
    ///
    /// Parameter for setup DSSelectionRadioCardView
    /// - Parameter titleText: text to display on DSSelectionRadioCardView.
    /// - Parameter state: state of DSSelectionRadioCardView.
    /// - Parameter action: action when tap on DSSelectionRadioCardView.
	public func setup(titleText: String, state: DSSelectionRadioState, action: DSSelectionRadioAction?) {
		self.titleText = titleText
		self.state = state
		self.action = action
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupXib()
		setupUI()
		updateAppearance()
		setupGesture()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupXib()
		setupUI()
		updateAppearance()
		setupGesture()
	}
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           radioViewId: String? = nil,
                                           titleLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.radioView.accessibilityIdentifier = radioViewId
        self.titleLabel.accessibilityIdentifier = titleLabelId
    }
}

// MARK: - Action
extension DSSelectionRadioCardView {
	@objc
	func selectionRadioViewDidTapped(_ gesture: UIGestureRecognizer) {
		guard state.isUserInteractonEnabled else {
			return
		}
		
		action?(state)
	}
}

// MARK: - Private
private extension DSSelectionRadioCardView {
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
	
	func updateTextTitle() {
		self.titleLabel.text = titleText
	}
	
	func setupGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectionRadioViewDidTapped(_:)))
		self.addGestureRecognizer(tapGesture)
	}
}
