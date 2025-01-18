//
//  DSTextFieldSearch.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/11/22.
//

import UIKit

private enum Constants {
    static let borderWidthContainerView: CGFloat = 1
}

/// Enum DSTextFieldSearch state.
public enum DSTextFieldSearchState {
    /// State normal before pressing on DSTextFieldSearch.
    case `default`
    /// State when the text field is pressed and focusing on DSTextFieldSearch.
    case focus
    /// State when the text field is filled and left DSTextFieldSearch.
    case filled
    /// State disable DSTextFieldSearch.
    case disable
    /// State disable DSTextFieldSearch and text field is empty.
    case disableEmpty
}

/// Enum DSTextFieldSearch keyboard type.
public enum DSTextFieldSearchKeyboardType {
    case textAndNumber
    case number
}

public protocol DSTextFieldSearchDelegate: AnyObject {
    /// Tell the delegate of DSTextFieldSearch when editing begins in the text field.
    func textFieldEditingDidBegin(_ textField: DSTextFieldSearch)
    /// Tell the delegate of DSTextFieldSearch when text changes in the text field.
    func textFieldDidChange(_ textField: DSTextFieldSearch)
    /// Tell the delegate of DSTextFieldSearch when editing stops in the text field.
    func textFieldEditingDidEnd(_ textField: DSTextFieldSearch)
    /// Tell the delegate of DSTextFieldSearch when text will change characters
    func textField(_ textField: DSTextFieldSearch, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}

public extension DSTextFieldSearchDelegate {
    func textField(_ textField: DSTextFieldSearch, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return true }
    func textFieldEditingDidBegin(_ textField: DSTextFieldSearch) { }
    func textFieldDidChange(_ textField: DSTextFieldSearch) { }
    func textFieldEditingDidEnd(_ textField: DSTextFieldSearch) { }
}

/**
    Custom component DSTextFieldSearch for Design System
 
    ![image](/DocumentationImages/ds-text-field-search.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSTextFieldSearch` Class to the UIView.
    2. Binding constraint and don't set `height`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var textFieldSearch: DSTextFieldSearch!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         textFieldSearch.delegate = self
         textFieldSearch.setup(text: "",
                               state: .default,
                               helperText: "Helping text (required)")
     }
     ```
     Display state default:
     ```
         textFieldSearch.setup(text: "",
                               state: .default)
     ```
     Display state focus:
     ```
         textFieldSearch.setup(text: "",
                               state: .focus)
     ```
     Display state filled:
     ```
         textFieldSearch.setup(text: "Value",
                               state: .filled)
     ```
     Display state disable:
     ```
         textFieldSearch.setup(text: "Value",
                               state: .disable)
     ```
     Display state disableEmpty:
     ```
         textFieldSearch.setup(text: "",
                               state: .disableEmpty)
     ```
     Set helper text (optional):
     ```
         textFieldSearch.setup(text: "",
                               state: .default,
                               helperText: "Helping text (required)")
     ```
    Set keyboard type:
     ```
        // Example: set keyboard type default
        textFieldSearch.setupKeyboard(keyboard: .textAndNumber)
 
         // Example: set keyboard type a number pad with a decimal point.
         textFieldSearch.setupKeyboard(keyboard: .number)
     ```
     **DSTextFieldSearch has 5 states:**
     - default
     - focus
     - filled
     - disable
     - disableEmpty
 */
public final class DSTextFieldSearch: UIView {
    @IBOutlet private weak var leftIconImageView: UIImageView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var helperTextView: DSHelperTextView!
    @IBOutlet private weak var rightClickAbleIconView: DSClickableIconBadge!
    @IBOutlet private weak var textFieldSearchView: UIView!
    @IBOutlet private weak var contentView: UIView!
    
    private var state: DSTextFieldSearchState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - public
    /// Variable for update text on text field of DSTextFieldSearch.
    public var text: String {
        get {
            textField.text ?? ""
        } set {
            self.textField.text = newValue
        }
    }
    
    /// Variable for check when there is text on text field of DSTextFieldSearch.
    public var hasTextInput: Bool {
        return textField.text != ""
    }
    
    /// Variable for setting placholder of DSTextFieldSearch.
    public var placeholder: String = "Search" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    /// Variable for update helper text of DSTextFieldSearch.
    public var helperText: String = "" {
        didSet {
            updateHelperText()
        }
    }
    
    /// Delegate of DSTextFieldSearch.
    public weak var delegate: DSTextFieldSearchDelegate?
    
    /// Variable for update title of the keyboard toolbar.
    public var titleToolBar: String = "Done" {
        didSet {
            setToolBar(title: titleToolBar)
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
    
    /// Setup DSTextFieldSearch
    ///
    /// Parameter for setup DSTextFieldSearch
    /// - Parameter text: text to display on the text field,  which is input method of DSTextFieldSearch.
    /// - Parameter state: state of DSTextFieldSearch.
    /// - Parameter helperText: helpertext to display below DSTextFieldSearch.
    public func setup(
        text: String,
        state: DSTextFieldSearchState,
        helperText: String = "",
        placeholder: String = "Search"
    ) {
        setUp(
            viewModel: DSTextFieldSearchViewModel(
                placeholder: placeholder,
                text: text,
                state: state,
                helperText: helperText,
                keyboardToolBarDismissButtonLabel: titleToolBar
            )
        )
    }

    public func setUp(viewModel: DSTextFieldSearchViewModel) {
        text = viewModel.text
        state = viewModel.state
        helperText = viewModel.helperText
        helperTextView.isHidden = viewModel.helperText.isEmpty
        placeholder = viewModel.placeholder
        titleToolBar = viewModel.keyboardToolBarDismissButtonLabel
    }

    /// Setup keyboard type of DSTextFieldSearch.
    public func setupKeyboard(keyboard: DSTextFieldSearchKeyboardType) {
        switch keyboard {
        case .textAndNumber:
            textField.keyboardType = .default
        case .number:
            textField.keyboardType = .decimalPad
        }
    }
    
    /// Update search textfield state and style
    /// Parameter for UpdateState
    /// - Parameter state: state of DSTextFieldSearch.
    public func updateState(state: DSTextFieldSearchState) {
        self.state = state
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           leftIconImageId: String? = nil,
                                           textFieldId: String? = nil,
                                           helperTextViewId: String? = nil,
                                           helperTextLabelId: String? = nil,
                                           helperTextRightLabelId: String? = nil,
                                           rightClickAbleIconId: String? = nil) {
        self.accessibilityIdentifier = id
        self.leftIconImageView.accessibilityIdentifier = leftIconImageId
        self.textField.accessibilityIdentifier = textFieldId
        self.helperTextView.setAccessibilityIdentifier(id: helperTextViewId,
                                                       textLabelId: helperTextLabelId,
                                                       textRightLabelId: helperTextRightLabelId)
        self.rightClickAbleIconView.setAccessibilityIdentifier(id: rightClickAbleIconId)
    }
}

// MARK: - Action
extension DSTextFieldSearch {
    @objc private func textFieldEditingDidBegin(_ textField: UITextField) {
        state = .focus
        rightClickAbleIconView.isHidden = !self.hasTextInput
        delegate?.textFieldEditingDidBegin(self)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        rightClickAbleIconView.isHidden = !self.hasTextInput
        delegate?.textFieldDidChange(self)
    }
    
    @objc private func textFieldEditingDidEnd(_ textField: UITextField) {
        if ![.disable, .disableEmpty].contains(state) {
            state = self.hasTextInput ? .filled : .default
        }
        rightClickAbleIconView.isHidden = true
        delegate?.textFieldEditingDidEnd(self)
    }
    
    @IBAction private func pressedClickAbleIcon(_ sender: Any) {
        self.text.removeAll()
        rightClickAbleIconView.isHidden = true
        delegate?.textFieldDidChange(self)
    }
    
    @objc private func dismissKeyboard() {
        let textFields = [textField]
        textFields.forEach { _ = $0?.resignFirstResponder() }
    }
}

// MARK: - UITextFieldDelegate
extension DSTextFieldSearch: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        return delegate?.textField(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
}

// MARK: - Private
private extension DSTextFieldSearch {
    func commonInit() {
        setupXib()
        setupUI()
        setupAction()
        setToolBar(title: titleToolBar)
    }
    
    func setupUI() {
        self.textField.backgroundColor = .clear
        self.textField.borderStyle = .none
        self.textField.autocorrectionType = .no
		self.textField.delegate = self
        
        self.contentView.layer.borderWidth = Constants.borderWidthContainerView
        self.contentView.setRadius(radius: DSRadius.radius12px)
        
        self.rightClickAbleIconView.isHidden = true
        self.rightClickAbleIconView.setup(style: .normal, image: DSIcons.icon24SolidCloseCircle.image.withRenderingMode(.alwaysTemplate))
        self.rightClickAbleIconView.iconImageView.tintColor = DSColor.componentLightOutline
        self.leftIconImageView.image = DSIcons.icon24OutlineSearch.image
        self.leftIconImageView.tintAdjustmentMode = .normal
    }
    
    func setupAction() {
        self.textField.addTarget(self, action: #selector(self.textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.textField.addTarget(self, action: #selector(self.textFieldEditingDidEnd(_:)), for: .editingDidEnd)
    }
    
    func setToolBar(title: String) {
        let title = title
        let keyboardToolbar = UIToolbar()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.barTintColor = DSColor.componentSummaryBackground
        keyboardToolbar.sizeToFit()
        keyboardToolbar.items = [flexBarButton, doneBarButton]

        textField.inputAccessoryView = keyboardToolbar
    }
    
    func updateAppearance() {
        textField.font = state.textFont
        textField.textColor = state.textColor
        contentView.layer.borderColor = state.borderColor.cgColor
        contentView.backgroundColor = state.backgroundColor
        contentView.isUserInteractionEnabled = state.isUserInteractonEnabled
        
        if state == .disableEmpty {
            self.text.removeAll()
        }
    }
    
    func updateHelperText() {
        self.helperTextView.text = helperText
    }
}
