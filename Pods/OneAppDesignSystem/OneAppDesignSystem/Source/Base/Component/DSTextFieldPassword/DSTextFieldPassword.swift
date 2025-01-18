//
//  DSTextFieldPassword.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/5/2566 BE.
//

import UIKit

/// Enum DSTextFieldPasswordState state.
public enum DSTextFieldPasswordState: Equatable {
    /// The default state of the text field.
    case `default`
    /// The state when the text field is focused for editing.
    case focus
    /// The state when the text field contains an error. The message argument specifies the error message to display.
    case error(message: String)
    /// The disabled state of the text field where user interaction is prevented.
    case disable
}

public protocol DSTextFieldPasswordDelegate: AnyObject {
    /// Tell the delegate of DSTextFieldPassword when editing starts.
    func textFieldEditingDidBegin(_ textField: DSTextFieldPassword)
    /// Tell the delegate of DSTextFieldPassword when text field changes.
    func textFieldDidChange(_ textField: DSTextFieldPassword)
    /// Tell the delegate of DSTextFieldPassword when editing stops.
    func textFieldEditingDidEnd(_ textField: DSTextFieldPassword)
    /// Asks the delegate if the specified text should be changed.
    func textField(_ textField: DSTextFieldPassword, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    /// Tell the delegate of DSTextFieldPassword when users tap return button.
    func textFieldShouldReturn(_ textField: DSTextFieldPassword) -> Bool
    /// Tell the delegate of DSTextFieldPassword when users tap done button in toolbar.
    func textFieldToolBarButtonDidTapped(_ textField: DSTextFieldPassword)

}

public extension DSTextFieldPasswordDelegate {
    func textField(_ textField: DSTextFieldPassword, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return true }
    func textFieldEditingDidBegin(_ textField: DSTextFieldPassword) { }
    func textFieldDidChange(_ textField: DSTextFieldPassword) { }
    func textFieldEditingDidEnd(_ textField: DSTextFieldPassword) { }
    func textFieldShouldReturn(_ textField: DSTextFieldPassword) -> Bool { return true }
    func textFieldToolBarButtonDidTapped(_ textField: DSTextFieldPassword) { }
}

public struct DSTextFieldPasswordViewModel {
    /// The title associated with the password text field.
    public var title: String
    /// The current state of the password text field.
    public var state: DSTextFieldPasswordState
    /// The current text value of the password text field.
    public var text: String?
    /// An optional helper text that provides additional information to the user.
    public var helperText: String?
    /// The placeholder text displayed when there is no other text in the text field.
    public var placeholder: String?
    /// A Boolean value that determines whether the text field should obscure the text input for secure entry.
    public var isSecurePassword: Bool

    public init(
        title: String,
        state: DSTextFieldPasswordState,
        text: String? = nil,
        helperText: String? = nil,
        placeholder: String? = nil,
        isSecurePassword: Bool
    ) {
        self.title = title
        self.state = state
        self.text = text
        self.helperText = helperText
        self.placeholder = placeholder
        self.isSecurePassword = isSecurePassword
    }
}

/**
 Custom component DSTextFieldPassword for Design System
 
 ![image](/DocumentationImages/ds-textfield-password.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSTextFieldPassword` Class to the UIView.
 2. Binding constraint and don't set `height`.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
 
 ```
 @IBOutlet weak var textFieldHidePasswordYesDefault: DSTextFieldPassword!
 @IBOutlet weak var textFieldHidePasswordNoDefault: DSTextFieldPassword!
 
 override func viewDidLoad() {
     super.viewDidLoad()
 
     textFieldHidePasswordYesDefault.delegate = self
     textFieldHidePasswordYesDefault.setup(viewModel: DSTextFieldPasswordViewModel(
         title: "Label",
         state: .default,
         text: "",
         helperText: "Helping text(required)",
         placeholder: "placeholder",
         isSecurePassword: true
     ))

     textFieldHidePasswordNoDefault.delegate = self
     textFieldHidePasswordNoDefault.setup(viewModel: DSTextFieldPasswordViewModel(
         title: "Label",
         state: .default,
         text: "",
         helperText: "Helping text(required)",
         placeholder: "placeholder",
         isSecurePassword: false
     ))
}
 ```
 Setup default state
 ```
 textField.setup(viewModel: DSTextFieldPasswordViewModel(
     title: "Label",
     state: .default,
     text: "",
     helperText: "Helping text(required)",
     placeholder: "placeholder",
     isSecurePassword: true
 ))
 ```
 Setup error state
 ```
 textField.setup(viewModel: DSTextFieldPasswordViewModel(
     title: "Label",
     state: .error(message: "Invalid password"),
     text: "",
     helperText: "Helping text(required)",
     placeholder: "placeholder",
     isSecurePassword: true
 ))
 ```
 Setup disable state
 ```
 textField.setup(viewModel: DSTextFieldPasswordViewModel(
     title: "Label",
     state: .disable,
     text: "",
     helperText: "Helping text(required)",
     placeholder: "placeholder",
     isSecurePassword: true
 ))
 ```

 **DSTextFieldPassword has 4 states:**
 - default
 - focus
 - error
 - disable
 */
public final class DSTextFieldPassword: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak var textField: UITextFieldPadding!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var securePasswordIcon: DSClickableIconGeneralIcon!
    @IBOutlet weak var helperTextView: DSHelperTextView!
    @IBOutlet weak var textFieldContentView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Private variable
    private var labelTopMargin = NSLayoutConstraint()
    private var labelCenterYConstraint = NSLayoutConstraint()
    private var state: DSTextFieldPasswordState = .default
    private var secureTextEntry: Bool  = false
    private var stateBeforeEditing: DSTextFieldPasswordState?

    private lazy var doneButton: UIBarButtonItem = {
        return UIBarButtonItem(title: titleToolBar,
                               style: .done,
                               target: self,
                               action: #selector(dismissKeyboard))
    }()
    
    // MARK: - Public variable
    /// Variable for check text field is not empty.
    public var hasTextInput: Bool {
        return textField.text?.isNotEmpty ?? false
    }
    
    /// Variable for setting title  of  ToolBar button.
    public var titleToolBar: String = "Done" {
        didSet {
            doneButton.title = titleToolBar
        }
    }
    
    /// For displaying helperText (Text below textfield).
    public var helperText: String? {
        didSet { helperTextView.text = helperText ?? "" }
    }
    
    /// Delegate of DSTextFieldPassword.
    public weak var delegate: DSTextFieldPasswordDelegate?
    
    /// For displaying title (label when state idle, floating label when state focus).
    public var title: String = "" {
        didSet { titleLabel.text = title }
    }
    
    /// For displaying text of textfield.
    public var text: String {
        get {
            textField.text ?? ""
        } set {
            textField.text = newValue
        }
    }
    
    /// For displaying placeholder of textfield.
    public var placeholder: String = ""
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup keyboard type of textfield
    public func setupKeyboard(keyboardType: UIKeyboardType) {
        textField.keyboardType = keyboardType
    }
    
    /// Configures DSTextFieldPassword with the provided view model.
    ///
    /// - Parameter viewModel: The view model containing the data to display.
    ///   - `title`: The title associated with the password text field.
    ///   - `state`: The current state of the password text field.
    ///   - `text`: The current text value of the password text field.
    ///   - `helperText`: An optional helper text that provides additional information to the user.
    ///   - `placeholder`: The placeholder text displayed when there is no other text in the text field.
    ///   - `isSecurePassword`: A Boolean value that determines whether the text field should obscure the text input for secure entry.
    public func setup(viewModel: DSTextFieldPasswordViewModel) {
        self.title = viewModel.title
        self.text = viewModel.text ?? ""
        self.helperText = viewModel.helperText
        self.placeholder = viewModel.placeholder ?? ""
        secureTextEntry = viewModel.isSecurePassword
        textField.isSecureTextEntry = viewModel.isSecurePassword
        
        var isDisabled: Bool {
            if case .disable = viewModel.state {
                return true
            }
            return false
        }
        
        securePasswordIcon.setup(
            viewModel: DSClickableIconGeneralIconViewModel(
                tagId: .zero,
                state: isDisabled ? .disable : .active,
                theme: .light,
                size: .medium,
                imageType: .image(secureTextEntry ? DSIcons.icon24OutlineeyeOff.image : DSIcons.icon24OutlineEye.image),
                isBadged: false
            )
        ) { [weak self] _ in
            self?.toggleSecureTextEntry()
        }
        updateLayout(state: viewModel.state)
    }
    
    /// Update DSTextFieldPassword layout
    ///
    /// - Parameter state: state of DSTextfield.
    /// - Parameter isAnimate: Is animating when change state.
    public func updateLayout(state: DSTextFieldPasswordState, isAnimate: Bool = false) {
        self.state = state
        updateAppearance()
        performAnimation(animated: isAnimate,
                         interval: 0.2) {
            self.contentView.layoutIfNeeded()
        }
    }

    /// Display keyboard immediately
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
        return super.becomeFirstResponder()
    }

    /// Returns the current state of the password text field.
    public func getCurrentState() -> DSTextFieldPasswordState {
        return self.state
    }
}

// MARK: - Action
extension DSTextFieldPassword {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldDidChange(self)
    }
    
    @objc private func dismissKeyboard() {
        textField.resignFirstResponder()
        delegate?.textFieldToolBarButtonDidTapped(self)
    }
}

// MARK: - UITextFieldDelegate
extension DSTextFieldPassword: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        return delegate?.textField(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        stateBeforeEditing = state
        let expectedState = state == .default ? .focus : state
        updateLayout(state: expectedState, isAnimate: true)

        textField.placeholder = self.placeholder
        delegate?.textFieldEditingDidBegin(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder?.removeAll()
        if let stateBeforeEditing, case .error = stateBeforeEditing {
            updateLayout(state: stateBeforeEditing, isAnimate: true)
        } else {
            updateLayout(state: .default, isAnimate: true)
        }

        stateBeforeEditing = nil
        delegate?.textFieldEditingDidEnd(self)
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn(self) ?? true
    }
}

extension DSClickableIconGeneralIcon {
    
    func setImageType(_ newImageType: DSClickableIconGeneralImageType?) {
        guard let newImageType else {
            return
        }
        
        switch newImageType {
        case .image(let image):
            iconImageView.image = image.withRenderingMode(.alwaysTemplate)
        case let .url(url, placeholder, cacheable):
            iconImageView.setImage(
                with: url,
                placeHolder: placeholder,
                cacheable: cacheable
            )
        }
    }
}

// MARK: - Private
private extension DSTextFieldPassword {
    func commonInit() {
        setupXib()
        setStyle()
        setupAction()
        setToolBar()
    }
    
    func setStyle() {
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = DSColor.componentLightOutline.cgColor
        contentView.backgroundColor = DSColor.componentLightBackground
        contentView.layer.cornerRadius = DSRadius.radius12px.rawValue
        
        titleLabel.numberOfLines = 1
        titleLabel.font = DSFont.placeholder
        titleLabel.textColor = DSColor.componentLightPlaceholder
        
        textField.font = DSFont.paragraphMedium
        textField.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor: DSColor.componentLightPlaceholder]
        )
        textField.isSecureTextEntry = secureTextEntry
        
        labelTopMargin = titleLabel.topAnchor.constraint(equalTo: textFieldContentView.topAnchor, constant: 8)
        labelCenterYConstraint = titleLabel.centerYAnchor.constraint(equalTo: textFieldContentView.centerYAnchor, constant: 0)
        labelCenterYConstraint.isActive = true
    }
    
    func setupAction() {
        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setToolBar() {
        let keyboardToolbar = UIToolbar()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        keyboardToolbar.barTintColor = DSColor.componentSummaryBackground
        keyboardToolbar.sizeToFit()
        keyboardToolbar.items = [flexBarButton, doneButton]
        
        textField.inputAccessoryView = keyboardToolbar
    }
    
    func updateAppearance() {
        let appearance: TextFieldPasswordAppearance = TextFieldPasswordViewModel(
            state: state,
            textValue: textField.text ?? "",
            helperTextValue: helperText ?? "",
            isEditing: textField.isEditing
        )
        
        textField.textColor = appearance.textColor
        
        titleLabel.font = appearance.labelFont
        titleLabel.textColor = appearance.labelTextColor
        
        contentView.layer.borderColor = appearance.borderColor.cgColor
        contentView.backgroundColor = appearance.backgroundColor
        contentView.isUserInteractionEnabled = appearance.isUserInteractionEnabled
        
        helperTextView.isError = appearance.helperTextIsError
        helperTextView.text = appearance.helperText
        helperTextView.isHidden = appearance.isHiddenHelperTextView
        
        labelTopMargin.isActive = appearance.isActiveTitleLabelTopMargin
        labelCenterYConstraint.isActive = appearance.isActiveTitleLabelCenterYConstraint
    }
    
    func toggleSecureTextEntry() {
        secureTextEntry.toggle()
        textField.isSecureTextEntry = secureTextEntry
        securePasswordIcon.setImageType(.image(secureTextEntry ? DSIcons.icon24OutlineeyeOff.image : DSIcons.icon24OutlineEye.image))
    }
}
