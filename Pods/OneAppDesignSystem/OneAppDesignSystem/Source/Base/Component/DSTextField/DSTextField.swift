import UIKit

/// Enum DSTextField state.
public enum DSTextFieldState {
    /// State normal before pressed.
    case `default`
    /// State when pressed and focusing on textfield.
    case focus
    /// State when filled text and leaved textfield.
    case filled
    /// State error with icon alert and error message below textfield.
    case error(errorMessage: String)
    /// State disable textfield.
    case disable
}

/// Type of keyboard DSTextField
public enum DSTextFieldKeyboardType {
    case textAndNumber
    case number
}

/**
    Custom component textfield for design system
 
    ![image](/DocumentationImages/ds-textfield.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSTextField` Class to the UIView.
    2. Binding constraint and don't set `height`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var textfield: DSTextField!
     
     override func viewDidLoad() {
         super.viewDidLoad()
 
         textfield.delegate = self
         textField.setup(title: "Label",
                         state: .default,
                         text: "Value",
                         helperText: "Helping text(required)",
                         placeholder: "plaeholder",
                         clickAbleIcon: SvgIcons.icon24OutlineInfo.image,
                         clickableIconAction: onTapClickAbleIcon2)
     }
     ```
     Display state error:
     ```
        textfield.updateLayout(state: .error(errorMessage: "Error Message"))
     ```
     Display state disable:
     ```
        textfield.updateLayout(state: .disable)
     ```
     Display state filled:
     ```
        textfield.updateLayout(state: .filled)
     ```
     Display state focus:
     ```
        textfield.updateLayout(state: .focus)
     ```
     Display state default:
     ```
        textfield.updateLayout(state: .default)
     ```
     **Note:**
     1. `IconClickAble` The image must be entered correctly by
        **Medium** Size
*/
public final class DSTextField: UIView {
    @IBOutlet public weak var textField: UITextFieldPadding!
    @IBOutlet weak var helperTextView: DSHelperTextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clickAbleIconView: DSClickableIconBadge!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textFieldContentView: UIView!
    
    // MARK: - Private variable
    private var titleLabelTopMargin = NSLayoutConstraint()
    private var titleLabelCenterYConstraint = NSLayoutConstraint()
    private var state: DSTextFieldState = .default
    private var clickAbleIconAction: (() -> Void)?

    private lazy var doneButton: UIBarButtonItem = {
        return UIBarButtonItem(title: titleToolBar,
                               style: .done,
                               target: self,
                               action: #selector(dismissKeyboard))
    }()

    // MARK: - Public variable
    public var hasTextInput: Bool {
        return textField.text != ""
    }
    
    /// For textfield delegate
    public weak var delegate: UITextFieldDelegate? {
        didSet {
            textField.delegate = delegate
        }
    }
    
    /// For displaying title of keyboard tool bar
    public var titleToolBar: String = "Done" {
        didSet {
            doneButton.title = titleToolBar
        }
    }
    
    /// For displaying helperText (Text below textfield).
    public var helperText: String = "" {
        didSet { helperTextView.text = helperText }
    }
    
    /// For displaying title (label when state idle, floating label when state focus).
    public var title: String = "" {
        didSet { titleLabel.text = title }
    }
    
    /// For displaying helpertTextRight (Text below textfield and right side).
    public var helperTextRight: String = "" {
        didSet { helperTextView.textRight = helperTextRight }
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
    
    /// For displaying clickable icon (icon on right side of textfield).
    public func setClickAbleIcon(image: UIImage, actionCallBack: @escaping () -> Void) {
        clickAbleIconView.isHidden = false
        clickAbleIconView.setup(style: .normal, image: image)
        clickAbleIconAction = actionCallBack
    }
    
    /// Setup keyboard type of textfield
    public func setupKeyboard(keyboard: DSTextFieldKeyboardType) {
        switch keyboard {
        case .textAndNumber:
            textField.keyboardType = .default
        case .number:
            textField.keyboardType = .decimalPad
        }
    }
    
    /// Setup DSTextField
    ///
    /// Parameter for setup DSTextField
    /// - Parameter title: text to display as the title label of DSTextField.
    /// - Parameter state: state of DSTextField.
    /// - Parameter text: text to display on the text filed,  which is input method of DSTextField (optional).
    /// - Parameter helperText: text to display as helpertext below DSTextField (optional).
    /// - Parameter placeholder: text to display as the placeholder on the text view of DSTextField(optional).
    /// - Parameter clickAbleIcon: clickable icon which is at the right sid of text field (optional).
    /// - Parameter clickableIconAction: action of clickable icon (optional).
    public func setup(title: String,
                      state: DSTextFieldState,
                      text: String = "",
                      helperText: String = "",
                      placeholder: String = "",
                      clickAbleIcon: UIImage? = nil,
                      clickableIconAction: @escaping (() -> Void) = {}) {
        self.title = title
        self.text = text
        self.helperText = helperText
        self.placeholder = placeholder
        if let clickAbleIcon = clickAbleIcon {
            setClickAbleIcon(
                image: clickAbleIcon,
                actionCallBack: clickableIconAction
            )
        }

        updateLayout(state: state)
    }
    
    /// Update DSTextField layout
    ///
    /// - Parameter state: state of DSTextfield.
    /// - Parameter isAnimate: Is animating when change state.
    public func updateLayout(state: DSTextFieldState, isAnimate: Bool = false) {
        self.state = state
        updateAppearance()
        performAnimation(animated: isAnimate,
                         interval: 0.2) {
            self.contentView.layoutIfNeeded()
        }
    }

    public func getCurrentState() -> DSTextFieldState {
        return self.state
    }

    @available(*, deprecated, message: "Deprecated, Please use DSTextFieldAccessibility instead")
    public func setAccessibilityIdentifier(id: String? = nil,
                                           textFieldId: String? = nil,
                                           helperTextViewId: String? = nil,
                                           titleLabelId: String? = nil,
                                           clickAbleIconViewId: String? = nil) {
        self.accessibilityIdentifier = id
        textField.accessibilityIdentifier = textFieldId
        helperTextView.accessibilityIdentifier = helperTextViewId
        titleLabel.accessibilityIdentifier = titleLabelId
        clickAbleIconView.accessibilityIdentifier = clickAbleIconViewId
    }

    public func setAccessibility(accessibility: DSTextFieldAccessibility) {
        self.accessibilityIdentifier = accessibility.id
        self.textField.accessibilityIdentifier = accessibility.textFieldId
        self.helperTextView.accessibilityIdentifier = accessibility.helperTextViewId
        self.titleLabel.accessibilityIdentifier = accessibility.titleLabelId
        self.clickAbleIconView.accessibilityIdentifier = accessibility.clickAbleIconViewId
        self.doneButton.accessibilityIdentifier = accessibility.doneButtonId
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Action
extension DSTextField {
    @IBAction func pressedClickAbleIcon(_ sender: Any) {
        clickAbleIconAction?()
    }
    
    @objc private func dismissKeyboard() {
        textField.resignFirstResponder()
    }
}

// MARK: - Private
private extension DSTextField {
    func commonInit() {
        setupXib()
        setStyle()
        setToolBar()
        addObservers()
    }
    
    func setStyle() {
        clickAbleIconView.isHidden = true

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
        
        titleLabelTopMargin = titleLabel.topAnchor.constraint(equalTo: textFieldContentView.topAnchor, constant: 8)
        titleLabelCenterYConstraint = titleLabel.centerYAnchor.constraint(equalTo: textFieldContentView.centerYAnchor, constant: 0)
        titleLabelCenterYConstraint.isActive = true
    }
    
    func updateAppearance() {
        let appearance: TextFieldAppearance = TextFieldViewModel(
            state: state,
            textValue: textField.text ?? "",
            helperTextValue: helperText
        )

        contentView.layer.borderColor = appearance.borderColor.cgColor
        contentView.backgroundColor = appearance.backgroundColor
        contentView.isUserInteractionEnabled = appearance.isUserInteractionEnabled

        textField.textColor = appearance.textColor

        titleLabel.font = appearance.titleFont
        titleLabel.textColor = appearance.titleTextColor

        titleLabelTopMargin.isActive = appearance.isActiveTitleLabelTopMargin
        titleLabelCenterYConstraint.isActive = appearance.isActiveTitleLabelCenterYConstraint

        helperTextView.text = appearance.helperText
        helperTextView.isError = appearance.helperTextIsError
        helperTextView.isHidden = appearance.isHiddenHelperTextView

        clickAbleIconView.isEnabled = appearance.isClickableEnabled
    }
    
    func setToolBar() {
        let title = title
        let keyboardToolbar = UIToolbar()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        keyboardToolbar.barTintColor = DSColor.componentSummaryBackground
        keyboardToolbar.sizeToFit()
        keyboardToolbar.items = [flexBarButton, doneButton]

        textField.inputAccessoryView = keyboardToolbar
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: UITextField.textDidBeginEditingNotification, object: nil, queue: .main) { (notification) in
            self.notifyTextFieldIsBeginEditing(notification)
        }
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidEndEditingNotification, object: nil, queue: .main) { (notification) in
            self.notifyTextFieldDidEndEdit(notification)
        }
    }
    
    func notifyTextFieldIsBeginEditing(_ notification: Notification) {
        if let textField = notification.object as? UITextField, textField == self.textField {
            updateLayout(state: .focus, isAnimate: true)
            textField.placeholder = self.placeholder
        }
    }
    
    func notifyTextFieldDidEndEdit(_ notification: Notification) {
        if let textField = notification.object as? UITextField, textField == self.textField {
            textField.placeholder = ""
            if case .error = self.state { return }
            let currentState: DSTextFieldState = self.hasTextInput ? .filled : .default
            updateLayout(state: currentState, isAnimate: true)
        }
    }
}
