//
//  DSTextFieldAmount.swift
//  OneAppDesignSystem
//
//  Created by TTB on 18/1/2566 BE.
//

import UIKit
import Foundation

private enum Constants {
    static let animationDuration: TimeInterval = 0.2
    static let defaultPlaceholder: String = "0.00"
}

/// Enum DSTextFieldAmount state.
public enum DSTextFieldAmountState: Equatable {
    /// State normal before being pressed on.
    case `default`
    /// State when being pressed and focusing on textfield.
    case focus
    /// State error with icon alert and error message below textfield.
    case error(errorMessage: String)
    /// State disable textfield.
    case disable
}

public protocol DSTextFieldAmountDelegate: AnyObject {
    /// Tell the delegate of DSTextFieldAmount when editing starts.
    func textFieldEditingDidBegin(_ textField: DSTextFieldAmount)
    /// Tell the delegate of DSTextFieldAmount when editing stops.
    func textFieldEditingDidEnd(_ textField: DSTextFieldAmount)
    /// Tell the delegate of DSTextFieldAmount when text field changes.
    func textFieldDidChange(_ textField: DSTextFieldAmount)
    /// Tell the delegate of DSTextFieldAmount when text field will begin editing.
    func textFieldWillEditingBegin(_ textField: DSTextFieldAmount)
}

public extension DSTextFieldAmountDelegate {
    func textFieldEditingDidBegin(_ textField: DSTextFieldAmount) { }
    func textFieldEditingDidEnd(_ textField: DSTextFieldAmount) { }
    func textFieldDidChange(_ textField: DSTextFieldAmount) { }
    func textFieldWillEditingBegin(_ textField: DSTextFieldAmount) { }
}

/**
 Custom component DSTextFieldAmount for Design System
 
 ** Text Field/Amount Transaction  **
 
 ![image](/DocumentationImages/ds-textfield-amount-transaction.png)
 
 
 ** Text Field/Amount General  **
 
 ![image](/DocumentationImages/ds-textfield-amount-general.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSTextFieldAmount` Class to the UIView.
 2. Binding constraint and don't set `height`.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
 ```
     @IBOutlet weak var textField1: DSTextFieldAmount!
     @IBOutlet weak var textField2: DSTextFieldAmount!
     
     override func viewDidLoad() {
         super.viewDidLoad()
     
         // Example: DSTextFieldAmount/ Transactrion
         textField1.delegate = self
         textField1.setup(titleText: "Label",
         state: .default,
         type: .transaction,
         errorEmptyAmountText: "โปรดใส่จำนวนเงิน",
         textFieldValue: "",
         helperText: "Helping text (required)",
         placeholder: "0.00",
         feeText: "Fee 0.00",
         maxLength: 10)
 
         // Example: DSTextFieldAmount/ General
         textField2.delegate = self
         textField2.setup(titleText: "Label",
         state: .error(errorMessage: "error message"),
         type: .general,
         errorEmptyAmountText: "โปรดใส่จำนวนเงิน",
         textFieldValue: "",
         helperText: "Helping text (required)",
         placeholder: "0.00")
    }
 ```
 
 **DSTextFieldAmount has 2 tpyes:**
 - general
 - transaction
 
 **DSTextFieldAmount has 4 states:**
 - default
 - focus
 - error
 - disable
 */
public final class DSTextFieldAmount: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet public weak var textField: UITextFieldPadding!
    @IBOutlet weak var helperTextView: DSHelperTextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textFieldContentView: UIView!
    @IBOutlet weak var suffixContainerView: UIView!
    @IBOutlet weak var suffixLabel: UILabel!
    
    @IBOutlet private weak var textFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Private variable
    private var state: DSTextFieldAmountState = .default {
        didSet {
            updateErrorText()
            updateAppearance()
            updateHelperText()
        }
    }
    
    private var type: DSTextFieldAmountType = .general {
        didSet {
            updateTypeUI()
        }
    }
    
    private var maxLength: Int?
    
    private var errorHelperText: String = ""
    
    private lazy var numberFormatterService: NumberFormatterServiceInterface = {
        return NumberFormatterService(
            maximumFractionDigits: formatType.maximumFractionDigits,
            minimumFractionDigits: formatType.minimumFractionDigits
        )
    }()
    
    // MARK: - Public variable
    /// Delegate of DSTextFieldAmount.
    public weak var delegate: DSTextFieldAmountDelegate?

    /// Configuration of amount textfield
    public var configuration: DSTextFieldAmountConfiguration = DSTextFieldAmountConfiguration.default

    /// Format type of amount textfield
    public var formatType: DSTextFieldAmountFormatType = .decimal {
        didSet {
            textField.keyboardType = formatType.keyboard
            numberFormatterService = NumberFormatterService(
                maximumFractionDigits: formatType.maximumFractionDigits,
                minimumFractionDigits: formatType.minimumFractionDigits
            )
        }
    }

    /// Variable for setting helper text right as a fee text of DSTextFieldAmount.
    public var feeText: String = "" {
        didSet {
            helperTextView.textRight = feeText
        }
    }
    
    /// Variable for setting placholder of DSTextFieldAmount.
    public var placeholder: String = Constants.defaultPlaceholder {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    /// Variable for setting helper text for empty error of DSTextFieldAmount.
    public var errorEmptyAmountText: String = ""
    
    /// Variable for setting helper text of DSTextFieldAmount.
    public var helperText: String = "" {
        didSet {
            updateHelperText()
        }
    }
    
    /// Variable for setting title label of DSTextFieldAmount.
    public var titleText: String {
        get {
            titleLabel.text ?? ""
        } set {
            titleLabel.text = newValue
        }
    }
    
    /// Variable for setting and getting text field value of DSTextFieldAmount.
    public var textFieldValue: String {
        get {
            textField.text ?? ""
        } set {
            textField.text = newValue.isEmpty ? newValue : numberFormatterService.formatAmountString(newValue)
            updateHelperText()
        }
    }
    
    /// Variable for check text field is not empty.
    public var hasTextInput: Bool {
        textField.text?.isNotEmpty ?? false
    }
    
    /// Variable for setting title  of  ToolBar button.
    public var titleToolBar: String = "Done" {
        didSet {
            setToolBar(title: titleToolBar)
        }
    }
    
    /// Variable for setting suffix text of DSTextFieldAmount.
    public var suffixText: String = "" {
        didSet {
            updateSuffixText()
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
    
    /// Setup DSTextFieldAmount
    ///
    /// Parameter for setup DSTextFieldAmount
    /// - Parameter titleText: text to display as a label of DSTextFieldAmount.
    /// - Parameter state: state of DSTextFieldAmount.
    /// - Parameter type: type of  DSTextFieldAmount.
    /// - Parameter errorEmptyAmountText: helpertext to display when text field is empty error.
    /// - Parameter textFieldValue: text to display on text field, which is input method of DSTextFieldAmount (Optional). Dafault value is empty string that means there is no input value yet.
    /// - Parameter helperText: helpertext to display below DSTextFieldAmount (Optional).
    /// - Parameter placeholder: placeholder of text field (Optional). Default value is "0.00".
    /// - Parameter feeText: helpertext right to display at the right side under DSTextFieldAmount (Optional). feeText is only available for DSTextFieldAmount/ Transaction.
    /// - Parameter suffixText: text to display as a suffix text in DSTextFieldAmount (Optional).
    /// - Parameter maxLength: maximum length of text field value, which is number part only (Optional). It should not be greater than 10.
    public func setup(titleText: String,
                      state: DSTextFieldAmountState,
                      type: DSTextFieldAmountType,
                      errorEmptyAmountText: String,
                      textFieldValue: String = "",
                      helperText: String = "",
                      placeholder: String = "0.00",
                      feeText: String = "",
                      suffixText: String = "",
                      maxLength: Int? = nil) {
        self.titleText = titleText
        self.textFieldValue = textFieldValue
        self.helperText = helperText
        self.errorEmptyAmountText = errorEmptyAmountText
        self.placeholder = placeholder
        self.feeText = feeText
        self.suffixText = suffixText
        self.type = type
        self.maxLength = maxLength
        
        self.state = state
        updateLayout()
    }
    
    /// Set DSTextFieldAmount state
    /// Parameter for setState
    /// - Parameter state: state of DSTextFieldAmount.
    public func setState(state: DSTextFieldAmountState, isAnimate: Bool = false) {
        self.state = state
        updateLayout()
    }

    public func getState() -> DSTextFieldAmountState {
        return state
    }

    public func setAccessibilityIdentifier(id: String? = nil,
                                           textFieldId: String? = nil,
                                           helperTextViewId: String? = nil,
                                           titleLabelId: String? = nil,
                                           suffixLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        textField.accessibilityIdentifier = textFieldId
        helperTextView.accessibilityIdentifier = helperTextViewId
        titleLabel.accessibilityIdentifier = titleLabelId
        suffixLabel.accessibilityIdentifier = suffixLabelId
    }
}

// MARK: - Action
extension DSTextFieldAmount {
    @objc private func dismissKeyboard() {
        textField.endEditing(true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if configuration.autoDisplayEmptyError {
            if let text = textField.text, text.isEmpty {
                updateState(state: .error(errorMessage: self.errorEmptyAmountText))
            } else {
                updateState(state: .focus)
            }
        }
        
        if textField == self.textField, let input = textField.text {
            let inputSplit = input.components(separatedBy: ".")
            let numberPart = inputSplit.first ?? ""
            if numberPart.isZero {
                textField.text = textField.text?.replacingOccurrences(of: "^0+", with: "0", options: .regularExpression)
                if numberPart.count > 1 {
                    textField.moveCursorPositionToTheBeginning()
                }
            } else {
                let textFormatted = textField.text?.removeZero
                let originalText = textField.text
                textField.text = textFormatted
                if originalText != textFormatted {
                    textField.moveCursorPositionToTheBeginning()
                }
            }
        }
        delegate?.textFieldDidChange(self)
    }
}

// MARK: - UITextFieldDelegate
extension DSTextFieldAmount: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldWillEditingBegin(self)
        if self.state == .default {
            updateState(state: .focus)
        }
        
        if let textWithoutComma = textField.text?.removeCommas,
           let textDouble = Double(textWithoutComma),
           !textDouble.isZero {
            textField.text = textWithoutComma
        }
        
        delegate?.textFieldEditingDidBegin(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.hasText {
            updateState(state: .default)
            if let text = textField.text {
                textField.text = numberFormatterService.formatAmountString(text)
            }
        } else {
            if configuration.autoDisplayEmptyError {
                updateState(state: .error(errorMessage: self.errorEmptyAmountText))
            } else {
                updateState(state: .default)
            }
        }
        
        delegate?.textFieldEditingDidEnd(self)
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        let newStringInput = string.replacingOccurrences(of: ",", with: ".")
        return numberFormatterService.isValidNumber(inputString: newStringInput,
                                                    textField: textField,
                                                    range: range,
                                                    string: string,
                                                    maxLength: self.maxLength)
    }
}

// MARK: - Private
private extension DSTextFieldAmount {
    func commonInit() {
        setupXib()
        setupUI()
        updateTypeUI()
        setToolBar(title: titleToolBar)
        setupAction()
    }
    
    func setupUI() {
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.isPasteEnabled = false
        textField.isCopyEnabled = false
        textField.isCutEnabled = false
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = DSColor.componentLightOutline.cgColor
        contentView.backgroundColor = DSColor.componentLightBackground
        contentView.layer.cornerRadius = DSRadius.radius12px.rawValue
        
        titleLabel.numberOfLines = 1
        titleLabel.font = DSFont.labelInput
        titleLabel.textColor = DSColor.componentLightLabel
        
        suffixLabel.numberOfLines = 1
        suffixLabel.font = DSFont.paragraphMedium
        suffixLabel.textColor = DSColor.componentLightLabel
        
        textField.font = type.font
        textField.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor: DSColor.componentLightPlaceholder]
        )
    }
    
    func updateTypeUI() {
        textField.font = type.font
        helperTextView.textRight = type == .general ? "" : self.feeText
        
        textFieldHeightConstraint.constant = type.textFieldHeight
        contentViewHeightConstraint.constant = type.textFieldHeight
    }
    
    func updateAppearance() {
        contentView.layer.borderColor = state.borderColor.cgColor
        contentView.backgroundColor = state.backgroundColor
        contentView.isUserInteractionEnabled = state.isUserInteractionEnabled
        textField.textColor = state.textColor
        helperTextView.isError = state.helperTextIsError
        
        switch state {
        case .error:
            helperTextView.text = self.errorHelperText
        default:
            helperTextView.text = helperText
        }
    }
    
    func updateErrorText() {
        guard case let .error(message) = self.state else { return }
        self.errorHelperText = message
    }
    
    func updateHelperText() {
        switch self.state {
        case .default, .disable, .focus:
            helperTextView.text = helperText
        case .error:
            helperTextView.text = hasTextInput ? errorHelperText : errorEmptyAmountText
        }
        
        helperTextView.isHidden = helperTextView.text.isEmpty
    }
    
    func updateSuffixText() {
        suffixLabel.text = suffixText
        suffixContainerView.isHidden = suffixText.isEmpty
    }
    
    func updateState(state: DSTextFieldAmountState) {
        self.state = state
        updateLayout()
    }
    
    func updateLayout() {
        self.contentView.layoutIfNeeded()
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
    
    func setupAction() {
        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
}
