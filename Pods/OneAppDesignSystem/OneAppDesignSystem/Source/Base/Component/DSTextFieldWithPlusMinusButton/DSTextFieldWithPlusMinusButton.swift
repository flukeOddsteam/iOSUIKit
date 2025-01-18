//
//  DSTextFieldWithPlusMinusButton.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/4/2566 BE.
//

import UIKit

private enum Constants {
    static let defaultPlaceholder: String = "0"
    static let numberOfLines: Int = 1
    static let borderWidth: CGFloat = 1
}

/**
    Method for managing event for `DSTextFieldWithPlusMinusButton`. Just conform protocol `DSTextFieldWithPlusMinusButtonDelegate`
 ```swift
 extension ViewController: DSTextFieldWithPlusMinusButtonDelegate {
    func plusButtonDidSelect(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage) {
        // Do stuff
    }
 
    func minusButtonDidSelect(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage) {
            // Do stuff
    }
 
    func textFieldEditingDidBegin(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage) {
        // Do stuff
    }
 
    func textFieldEditingDidEnd(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage) {
        // Do stuff
    }
 
    func textFieldDidChange(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage) {
        // Do stuff
    }
 }
 ```
 */
public protocol DSTextFieldWithPlusMinusButtonDelegate: AnyObject {
    /// Tell the delegate of DSTextFieldWithPlusMinusButtonDelegate is select the plus button.
    func plusButtonDidSelect(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage)
    /// Tell the delegate of DSTextFieldWithPlusMinusButtonDelegate is select the minus button.
    func minusButtonDidSelect(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage)
    /// Tell the delegate of DSTextFieldWithPlusMinusButtonDelegate when editiong starts.
    func textFieldEditingDidBegin(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage)
    /// Tell the delegate of DSTextFieldWithPlusMinusButtonDelegate when editiong end.
    func textFieldEditingDidEnd(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage)
    /// Tell the delegate of DSTextFieldWithPlusMinusButtonDelegate when  text field changes.
    func textFieldDidChange(_ component: DSTextFieldWithPlusMinusButton, state: DSTextFieldWithPlusMinusButtonStage)
}

/**
    Custom component DSTextFieldWithPlusMinusButton for Design System
 
    ![image](/DocumentationImages/ds-textfield-with-plus-minus-button.png)
 
    **Usage Example:**
     1. Create UIView on .xib file and assign `DSTextFieldWithPlusMinusButton` Class to the UIView.
     2. Binding constraint and don't set `height`.
     3. Connect UIView to `@IBOutlet` in text editor.
     4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
        @IBOutlet weak var textFieldWithPlusMinusButton1: DSTextFieldWithPlusMinusButton!
        @IBOutlet weak var textFieldWithPlusMinusButton2: DSTextFieldWithPlusMinusButton!
         
        override func viewDidLoad() {
            super.viewDidLoad()
    
            // Example: DSTextFieldWithPlusMinusButton/ Setup DSTextFieldWithPlusMinusButton by View Model
            let viewModel = DSTextFieldWithPlusMinusButtonViewModel(title: "Label", helping: "เลือกได้สูงสุด 10", amountAddedEachTime: 1, minLength: 1, maxLength: 10)
            textFieldWithPlusMinusButton1.setup(viewModel: viewModel)
            textFieldWithPlusMinusButton1.delegate = self

            // Example: DSTextFieldWithPlusMinusButton/ Setup DSTextFieldWithPlusMinusButton by each parameter separately
            textFieldWithPlusMinusButton2.setup(viewModel: nil, state: .error)
            textFieldWithPlusMinusButton2.title = "Label"
            textFieldWithPlusMinusButton2.value = 11
            textFieldWithPlusMinusButton2.helping = "เลือกได้สูงสุด 10"
            textFieldWithPlusMinusButton2.minLength = 0
            textFieldWithPlusMinusButton2.maxLength = 10
            textFieldWithPlusMinusButton2.plusButtonIsEnable = true
            textFieldWithPlusMinusButton2.minusButtonIsEnable = true
            textFieldWithPlusMinusButton2.delegate = self
        }
     ```
 How to use DSTextFieldWithPlusMinusButtonViewModel for DSBulletList remark type
  Parameter | Type + Information
    --- | ---
    `title` | `String` For setup the title display in TextFieldWithPlusMinusButton.
    `value` | `Int` For setup the value in TextFieldWithPlusMinusButton.
    `helping` | `String` For setup the helper display in TextFieldWithPlusMinusButton.
    `amountAddedEachTime` | `Int` For setup the value increase/ decrease when tap on plus/ minus button in TextFieldWithPlusMinusButton.
    `minLength` | `Int` For setup the minimum value in TextFieldWithPlusMinusButton.
    `maxLength` | `Int` For setup the maximum in TextFieldWithPlusMinusButton.
    ```
        public struct DSBulletRemarkViewModel {
            var title: String?
            var value: Int = 0
            var helping: String?
            var amountAddedEachTime: Int = 0
            var minLength: Int = 0
            var maxLength: Int = 0
        }
    ```
     
     **DSTextFieldWithPlusMinusButton has 4 states:**
     - default
     - focus
     - error
     - disable
 */
public final class DSTextFieldWithPlusMinusButton: UIView {
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var helpingLabel: UILabel!
    @IBOutlet weak var textFieldBorderView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    // MARK: - Public properties
    public weak var delegate: DSTextFieldWithPlusMinusButtonDelegate?
    
    public var state: DSTextFieldWithPlusMinusButtonStage = .default {
        didSet {
            updateAppearance()
        }
    }
    
    public var theNumber: Int = 0
    public var amountAddedEachTime: Int = 1
    public var minLength: Int = 0
    public var maxLength: Int = 0
    
    public var titleToolBar: String = "Done" {
        didSet {
            setToolBar(title: titleToolBar)
        }
    }
    
    public var plusButtonIsEnable: Bool = true {
        didSet {
            updatePlusButtonAppearance()
        }
    }
    
    public var minusButtonIsEnable: Bool = false {
        didSet {
            updateMinusButtonAppearance()
        }
    }
    
    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    public var value: Int = 0 {
        didSet {
            self.theNumber = value
            textField.text = "\(value)"
        }
    }
    
    public var helping: String? {
        didSet {
            self.helpingLabel.text = helping
        }
    }
    
    // MARK: - Private properties    
    private var numberFormatterService: NumberFormatterServiceInterface = {
        return NumberFormatterService(maximumFractionDigits: 2, minimumFractionDigits: 2)
    }()
    
    // MARK: - Public function
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSTextFieldWithPlusMinusButton
    ///
    /// Parameter for setup DSTextFieldWithPlusMinusButton
    /// - Parameter viewModel: viewModel of DSTextFieldWithPlusMinusButton (optional).
    /// - Parameter state: state of DSTextFieldWithPlusMinusButton (mandatory).
    public func setup(viewModel: DSTextFieldWithPlusMinusButtonViewModel?, state: DSTextFieldWithPlusMinusButtonStage = .default) {
        self.title = viewModel?.title
        self.value = viewModel?.value ?? 0
        self.helping = viewModel?.helping
        self.amountAddedEachTime = viewModel?.amountAddedEachTime ?? 1
        self.minLength = viewModel?.minLength ?? 0
        self.maxLength = viewModel?.maxLength ?? 0
        self.state = state
    }
}

// MARK: - UITextFieldDelegate
extension DSTextFieldWithPlusMinusButton: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.textFieldEditingDidBegin(self, state: self.state)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.textFieldEditingDidEnd(self, state: self.state)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newStringInput = string.replacingOccurrences(of: ",", with: ".")
        return numberFormatterService.isValidNumber(inputString: newStringInput, textField: textField, range: range, string: string, maxLength: self.maxLength.digitCount)
    }
}

// MARK: - TextField Action
extension DSTextFieldWithPlusMinusButton {
    @objc private func dismissKeyboard() {
        self.textField.endEditing(true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldDidChange(self, state: self.state)
    }
}

// MARK: - Button Action
extension DSTextFieldWithPlusMinusButton {
    @objc private func plusButtonDidSelect(_ button: UIButton) {
        self.delegate?.plusButtonDidSelect(self, state: self.state)
    }
    
    @objc private func minusButtonDidSelect(_ button: UIButton) {
        self.delegate?.minusButtonDidSelect(self, state: self.state)
    }
}

// MARK: - Private
private extension DSTextFieldWithPlusMinusButton {
    func commonInit() {
        setupXib()
        commonUI()
        setToolBar(title: titleToolBar)
        setupAction()
    }
    
    func commonUI() {
        self.titleLabel.textColor = DSColor.componentLightLabel
        self.titleLabel.font = DSFont.labelInput
        self.titleLabel.numberOfLines = Constants.numberOfLines

        self.helpingLabel.font = DSFont.paragraphSmall
        self.helpingLabel.numberOfLines = Constants.numberOfLines

        self.textField.delegate = self
        self.textField.font = DSFont.h1
        self.textField.textColor = DSColor.componentLightPlaceholder
        self.textField.textAlignment = .center
        self.textField.borderStyle = .none
        self.textField.keyboardType = .numberPad
        self.textField.placeholder = Constants.defaultPlaceholder
        self.textField.backgroundColor = .clear

        self.textFieldBorderView.layer.borderWidth = Constants.borderWidth
        self.textFieldBorderView.layer.borderColor = DSColor.componentLightOutline.cgColor
        self.textFieldBorderView.backgroundColor = DSColor.componentLightBackground
        self.textFieldBorderView.layer.cornerRadius = DSRadius.radius12px.rawValue
        
        self.plusButton.setTitle("", for: .normal)
        self.plusButton.setImage(SvgIcons.icon24OutlinePlusCircleSecondaryOutline.image, for: .normal)

        self.minusButton.setTitle("", for: .normal)
        self.minusButton.setImage(SvgIcons.icon24OutlineMinusCircleDisableBackground.image, for: .normal)
    }
    
    func updateAppearance() {
        updateTextFieldAppearance()
        updateHelpingLabelAppearance()
        updatePlusButtonAppearance()
        updateMinusButtonAppearance()
        
        layoutIfNeeded()
    }
    
    func updatePlusButtonAppearance() {
        self.plusButton.isEnabled = self.plusButtonIsEnable
        
        if self.plusButtonIsEnable {
            self.plusButton.setImage(SvgIcons.icon24OutlinePlusCircleSecondaryOutline.image, for: .normal)
        } else {
            self.plusButton.setImage(SvgIcons.icon24OutlinePlusCircleDisableBackground.image, for: .normal)
        }
    }
    
    func updateMinusButtonAppearance() {
        self.minusButton.isEnabled = self.minusButtonIsEnable
        
        if minusButtonIsEnable {
            self.minusButton.setImage(SvgIcons.icon24OutlineMinusCircleSecondaryOutline.image, for: .normal)
        } else {
            self.minusButton.setImage(SvgIcons.icon24OutlineMinusCircleDisableBackground.image, for: .normal)
        }
    }
    
    private func updateTextFieldAppearance() {
        switch self.state {
        case .disable:
            self.textField.isEnabled = false
        default:
            self.textField.isEnabled = true
        }
        
        self.textField.textColor = self.state.textFieldColor
        self.textFieldBorderView.layer.borderColor = self.state.textFieldBorderColor.cgColor
        self.textFieldBorderView.backgroundColor = self.state.textFieldBackgroundColor
        self.textFieldBorderView.layoutIfNeeded()
    }
    
    private func updateHelpingLabelAppearance() {
        switch self.state {
        case .error:
            self.helpingLabel.textColor = DSColor.componentLightError
        default:
            self.helpingLabel.textColor = DSColor.componentLightLabel
        }
    }
    
    func setupAction() {
        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.plusButton.addTarget(self, action: #selector(self.plusButtonDidSelect(_:)), for: .touchUpInside)
        self.minusButton.addTarget(self, action: #selector(self.minusButtonDidSelect(_:)), for: .touchUpInside)
    }
    
    func setToolBar(title: String) {
        let title = title
        let keyboardToolbar = UIToolbar()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.barTintColor = DSColor.componentSummaryBackground
        keyboardToolbar.sizeToFit()
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        
        self.textField.inputAccessoryView = keyboardToolbar
    }
}
