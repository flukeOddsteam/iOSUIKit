//
//  DSSelectionRadioView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/9/2565 BE.
//

import UIKit

private enum Constants {
	static let numberOfLine: Int = 0
}

/// Delegate for DSSelectionRadioView
public protocol DSSelectionRadioViewDelegate: AnyObject {
    /// on tap See More button
    func onTapGhostButton(_ tagId: Int)
}

/**
 Custom component DSSelectionRadioView for Design System
 
 ![image](/DocumentationImages/ds-selection-radio.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSSelectionRadioView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or wherever you want.
     ```
        @IBOutlet weak var selectionRadioView: DSSelectionRadioView!
         
        override func viewDidLoad() {
            super.viewDidLoad()
            selectionRadio1.setup(tagId: 1,
                                titleText: "Label",
                                state: .default,
                                action: { [unowned self] state in self.didTapOnRadioView(selectionRadio1, radioViewList1)},
                                hasGhostButton: false,
                                ghostButtonLabel: "")
     ```
    Set tagId as an integer value for DSSelectionRadioView.
 
    Set label as text that you want to display.
 
    Set state as default for DSSelectionRadioView.
 
    Set action as whatever you want it to do when DSSelectionRadioView is  tapped on.
 
    Set hasGhostButton as false when there is no ghost button on DSSelectionRadioView.
 
    Set a defalut value of ghostButtonLabel is empty string:
     ```
        selectionRadio.setup(tagId: 1,
                            titleText: "Label",
                            state: .default,
                            action: { [unowned self] state in self.didTapOnRadioView(selectionRadio1, radioViewList1)},
                            hasGhostButton: false,
                            ghostButtonLabel: "")
     ```
 
    Set state as selected for DSSelectionRadioView.
 
    Set hasGhostButton as true when there is a ghost button on DSSelectionRadioView.
 
    Set ghostButtonLabel as text that you want to display :
     ```
        selectionRadio.setup(tagId: 1,
                            titleText: "Label",
                            state: .default,
                            action: { [unowned self] state in self.didTapOnRadioView(selectionRadio1, radioViewList1)},
                            hasGhostButton: true,
                            ghostButtonLabel: "See More")
     ```
 
    Set label and set state as disable for DSSelectionRadioView:
     ```
        selectionRadio.setup(tagId: 1,
                            titleText: "Label",
                            state: .disableUnselected,
                            action: { [unowned self] state in self.didTapOnRadioView(selectionRadio1, radioViewList1)},
                            hasGhostButton: true,
                            ghostButtonLabel: "See More")
     ```
 */
public final class DSSelectionRadioView: UIView {
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var radioView: RadioView!
    @IBOutlet private weak var selectionRadioView: UIStackView!
    @IBOutlet private weak var ghostButton: DSGhostButton!
    @IBOutlet private weak var ghostButtonView: UIStackView!
    @IBOutlet private weak var additionalView: UIView!
    
    /// Delegate of DSSelectionRadioView
    public weak var delegate: DSSelectionRadioViewDelegate?
    
    // MARK: - Public
    /// Variable for set tag ID of DSSelectionRadioView
    public var tagId: Int = 0
    
    /// Variable for update titleText which is label of DSSelectionRadioView
    public var titleText: String = "" {
        didSet {
            updateTextTitle()
        }
    }
    
    /// Variable for update state of DSSelectionRadioView
    public var state: DSSelectionRadioState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    /// Variable for set action of DSSelectionRadioView
    public var action: DSSelectionRadioAction?
    
    /// Variable for set there is See More button or not
    public var hasGhostButton: Bool = false {
        didSet {
            updateHasGhostButton()
        }
    }
    
    /// Variable for update titleText which is label of DSSelectionRadioView
    public var ghostButtonLabel: String = "" {
        didSet {
            updateGhostButtonLabel()
        }
    }
    
    /// For setup DSSelectionRadioView
    ///
    /// Parameter for setup DSSelectionRadioView
    /// - Parameter tagId: tag ID of DSSelectionRadioView.
    /// - Parameter titleText: text to display on DSSelectionRadioView.
    /// - Parameter state: state of DSSelectionRadioView.
    /// - Parameter action: action when tap on DSSelectionRadioView.
    /// - Parameter hasGhostButton: Is there See More button on DSSelectionRadioView?
    /// - Parameter ghostButtonLabel: text to display on ghostButton.
    public func setup(tagId: Int, titleText: String, state: DSSelectionRadioState, action: DSSelectionRadioAction?, hasGhostButton: Bool, ghostButtonLabel: String) {
        self.tagId = tagId
		self.titleText = titleText
		self.state = state
		self.action = action
        self.hasGhostButton = hasGhostButton
        self.ghostButtonLabel = hasGhostButton ? ghostButtonLabel : ""
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
                                           titleLabelId: String? = nil,
                                           ghostButtonId: String? = nil) {
        self.accessibilityIdentifier = id
        self.radioView.accessibilityIdentifier = radioViewId
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.ghostButton.accessibilityIdentifier = ghostButtonId
    }
}

// MARK: - Action
extension DSSelectionRadioView {
	@objc func radioViewDidTapped(_ sender: Any) {
		guard state.isUserInteractonEnabled else {
			return
		}

		action?(state)
	}
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.onTapGhostButton(tagId)
    }
}

// MARK: - Private
private extension DSSelectionRadioView {
	func setupUI() {
		self.titleLabel.font = DSFont.labelSelection
		self.titleLabel.numberOfLines = Constants.numberOfLine
        self.ghostButtonView.isHidden = true
        self.additionalView.isHidden = false
	}
	
	func updateAppearance() {
		self.radioView?.state = state
		self.titleLabel.textColor = state.titleColor
        self.selectionRadioView.isUserInteractionEnabled = state.isUserInteractonEnabled
	}
    
	func updateTextTitle() {
		self.titleLabel.text = titleText
	}
    
    func updateHasGhostButton() {
        self.ghostButtonView.isHidden = hasGhostButton ? false : true
        self.additionalView.isHidden = hasGhostButton ? true : false
    }
    
    func updateGhostButtonLabel() {
        self.ghostButton.smallGhostNoPaddingRightIconRight(text: ghostButtonLabel, icon: SvgIcons.icon16ChevronRight.image)
    }
	
	func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(radioViewDidTapped(_:)))
        self.selectionRadioView.addGestureRecognizer(tap)
        
        let ontapGhostButton = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.ghostButton.addGestureRecognizer(ontapGhostButton)
	}
}
