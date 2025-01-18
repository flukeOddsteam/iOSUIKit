//
//  DSCheckboxView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/10/22.
//

import UIKit

private enum Constants {
    static let numberOfLine: Int = 0
}

/// Delegate for DSCheckboxView
public protocol DSSelectionCheckboxDelegate: AnyObject {
    /// Tell the delegate  of DSCheckbox when small ghost button is checked
    func onTapGhostButton(_ tagId: Int)
}

/**
 Custom component DSCheckboxView for Design System
 
 ![image](/DocumentationImages/ds-checkbox-label.png)
 ![image](/DocumentationImages/ds-checkbox-labelSoft.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSCheckboxView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or wherever you want.
     ```
        @IBOutlet weak var selectionCheckbox: DSCheckboxView!
            
        override func viewDidLoad() {
            super.viewDidLoad()
            selectionCheckbox.delegate = self
            selectionCheckbox.setup(type: .default,
                                    theme: .light,
                                    tagId: 1,
                                    titleText: "Long Label",
                                    state: .default,
                                    action: { [unowned self] state in didSelectCheckbox(selectionCheckbox, selectionCheckboxList)},
                                    hasGhostButton: false,
                                    ghostButtonLabel: "")
        }
     ```
    Set type as default for DSCheckboxView.
 
    Set theme as light for DSCheckboxView.
 
    Set tagId as an integer value for DSCheckboxView.
 
    Set titleText as text label that you want to display.
 
    Set state as default for DSCheckboxView.
 
    Set action as whatever you want it to do when DSCheckboxView is checked.
 
    Set hasGhostButton as false when there is no ghost button on DSCheckboxView.
 
    Set a defalut value of ghostButtonLabel is empty string if there is no ghost button:
     ```
         selectionCheckbox.setup(type: .default,
                                 theme: .light,
                                 tagId: 1,
                                 titleText: "Long Label",
                                 state: .default,
                                 action: { [unowned self] state in didSelectCheckbox(selectionCheckbox, selectionCheckboxList)},
                                 hasGhostButton: false,
                                 ghostButtonLabel: "")
     ```
 
    Set state as selected for DSCheckboxView.
 
    Set hasGhostButton as true when there is a ghost button on DSCheckView.
 
    Set ghostButtonLabel as text that you want to display :
     ```
         selectionCheckbox.setup(type: .default,
                                 theme: .light,
                                 tagId: 1,
                                 titleText: "Long Label",
                                 state: .selected,
                                 action: { [unowned self] state in didSelectCheckbox(selectionCheckbox, selectionCheckboxList)},
                                 hasGhostButton: true,
                                 ghostButtonLabel: "See More")
     ```
 
    Set label and set state as disableUnchecked for DSCheckboxView:
     ```
         selectionCheckbox.setup(type: .default,
                                 theme: .light,
                                 tagId: 1,
                                 titleText: "Long Label",
                                 state: .disableUnchecked,
                                 action: nil,
                                 hasGhostButton: true,
                                 ghostButtonLabel: "See More")
     ```
 
 ![image](/DocumentationImages/ds-checkbox-onDark.png)
 
    Set theme as dark for DSCheckboxView.
 
    Set label and set state as disableChecked for DSCheckboxView:
     ```
         selectionCheckbox.setup(type: .default,
                                 theme: .dark,
                                 tagId: 1,
                                 titleText: "Long Label",
                                 state: .disableChecked,
                                 action: nil,
                                 hasGhostButton: true,
                                 ghostButtonLabel: "See More")
     ```
 
    Set type as softLabel for DSCheckboxView:
     ```
         selectionCheckbox.setup(type: .softLabel,
                                 theme: .light,
                                 tagId: 1,
                                 titleText: "Long Label",
                                 state: .disableChecked,
                                 action: nil,
                                 hasGhostButton: true,
                                 ghostButtonLabel: "See More")
     ```
 
     Set theme as dark for DSCheckboxView:
     ```
          selectionCheckbox.setup(type: .softLabel,
                                  theme: .dark,
                                  tagId: 1,
                                  titleText: "Long Label",
                                  state: .disableChecked,
                                  action: nil,
                                  hasGhostButton: true,
                                  ghostButtonLabel: "See More")
     ```
 */
public final class DSCheckboxView: UIView {

    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var checkboxView: DSInputCheckBox!
    @IBOutlet private weak var selectionCheckboxView: UIStackView!
    @IBOutlet private weak var ghostButton: DSGhostButton!
    @IBOutlet private weak var ghostButtonView: UIStackView!
    
    // MARK: - Public
    /// Delegate of DSCheckboxView
    public weak var delegate: DSSelectionCheckboxDelegate?
    
    /// Variable for setting tag ID of DSCheckboxView
    public var tagId: Int = 0
    
    /// Variable for updating titleText, which is a label of DSCheckboxView
    public var titleText: String = "" {
        didSet {
            updateTitle()
        }
    }
    
    /// Variable for updating state of DSCheckboxView
    public var state: DSSelectionCheckboxState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    /// Variable for setting type of DSCheckboxView
    public var type: DSSelectionCheckboxType = .default
    
    /// Variable for setting theme of DSCheckboxView
    public var theme: DSSelectionCheckboxTheme = .light
    
    /// Variable for setting action of DSCheckboxView
    public var action: DSSelectionCheckboxAction?
    
    /// Variable for setting there is ghost button or not
    public var hasGhostButton: Bool = false {
        didSet {
            updateHasGhostButton()
        }
    }
    
    /// Variable for updating text that is a ghost button's label of DSCheckboxView
    public var ghostButtonLabel: String = "" {
        didSet {
            updateGhostButtonLabel()
        }
    }
    
    // Private
    private var builder: SelectionCheckBoxBuilder = SelectionCheckBoxBuilder()
    
    /// For setup DSCheckboxView
    ///
    /// Parameter for setup DSCheckboxView
    /// - Parameter type: type of DSCheckboxView.
    /// - Parameter theme: theme of DSCheckboxView.
    /// - Parameter tagId: tag ID of DSCheckboxView.
    /// - Parameter titleText: text to display as label of DSCheckboxView.
    /// - Parameter state: state of DSCheckboxView.
    /// - Parameter action: action when tap on DSCheckboxView.
    /// - Parameter hasGhostButton: Is there a small ghost button on DSCheckboxView.
    /// - Parameter ghostButtonLabel: text to display as a label of a small ghostButton.
    public func setup(
        type: DSSelectionCheckboxType = .default,
        theme: DSSelectionCheckboxTheme = .light,
        tagId: Int,
        titleText: String,
        state: DSSelectionCheckboxState,
        action: DSSelectionCheckboxAction?,
        hasGhostButton: Bool,
        ghostButtonLabel: String) {
            self.type = type
            self.theme = theme
            self.tagId = tagId
            self.titleLabel.text = titleText
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
                                           checkboxId: String? = nil,
                                           ghostButtonId: String? = nil,
                                           ghostTitleId: String? = nil) {
        self.accessibilityIdentifier = id
        self.checkboxView.accessibilityIdentifier = checkboxId
        self.ghostButton.setAccessibilityIdentifier(id: ghostButtonId, titleLabelId: ghostTitleId)
    }
    
}

// MARK: - Action
extension DSCheckboxView {
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
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.onTapGhostButton(tagId)
        
    }
}

// MARK: - Private
private extension DSCheckboxView {
    func setupUI() {
        self.titleLabel.font = DSFont.labelSelection
        self.titleLabel.numberOfLines = Constants.numberOfLine
        self.ghostButtonView.isHidden = true
    }
    
    func updateAppearance() {
        let checkboxAppearanceViewModel = builder.build(state: state, type: type, theme: theme )
        
        self.checkboxView.type = type
        self.checkboxView.theme = theme
        self.checkboxView?.state = state
        self.checkboxView.alpha = checkboxAppearanceViewModel.alpha
        self.view.backgroundColor = theme.backgroundColor
        self.titleLabel.textColor = checkboxAppearanceViewModel.titleColor
        self.alpha = checkboxAppearanceViewModel.alpha
        self.titleLabel.font = type.titleSize
        self.selectionCheckboxView.isUserInteractionEnabled = state.isUserInteractonEnabled
    }
    
    func updateTitle() {
        self.titleLabel.text = titleText
    }
    
    func updateHasGhostButton() {
        self.ghostButtonView.isHidden = !hasGhostButton
    }
    
    func updateGhostButtonLabel() {
        self.ghostButton.smallGhostNoPaddingRightIconRight(text: ghostButtonLabel, icon: DSIcons.icon16ChevronRight.image)
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(checkboxViewDidTapped(_:)))
        self.selectionCheckboxView.addGestureRecognizer(tap)
        
        let ontapGhostButton = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.ghostButton.addGestureRecognizer(ontapGhostButton)
        
    }
}
