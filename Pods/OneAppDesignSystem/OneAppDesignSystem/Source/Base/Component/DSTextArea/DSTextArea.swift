//
//  DSTextArea.swift
//  OneAppDesignSystem
//
//  Created by TTB on 11/10/2565 BE.
//

import UIKit

/// Enum DSTextarea state.
public enum DSTextAreaState {
    /// State normal before pressed.
    case `default`
    /// State when pressed and focusing on textarea.
    case focus
    /// State when filled text and leaved textarea.
    case filled
    /// State error with icon alert and error message below textarea.
    case error(errorMessage: String)
    /// State disable textarea.
    case disable
}
/**
    Method for managing event for `DSTextArea`. Just conform protocol `DSTextAreaDelegate`
 ```
 extension ViewController: DSTextAreaDelegate {
     func textAreaDidChange(_ textView: UITextView) {
        // Do stuff
     }
 }
 ```
 */
public protocol DSTextAreaDelegate: AnyObject {
    func textAreaDidBeginEditing(_ textArea: DSTextArea)
    func textAreaDidEndEditing(_ textArea: DSTextArea)
    func textAreaDidChange(_ textArea: DSTextArea)
    func textArea(_ textArea: DSTextArea, didChange pastedText: String) -> String?
    func textArea(_ textArea: DSTextArea, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
}

public extension DSTextAreaDelegate {
    func textAreaDidBeginEditing(_ textArea: DSTextArea) {}
    func textAreaDidEndEditing(_ textArea: DSTextArea) {}
    func textAreaDidChange(_ textArea: DSTextArea) {}
    func textArea(_ textArea: DSTextArea, didChange pastedText: String) -> String? { nil }
    func textArea(_ textArea: DSTextArea, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool { return true }
}

public enum DSTextAreaKeyboardType {
    case textAndNumber
    case number
}

public enum DSHelperType {
    /// Type to present helper text.
    ///
    /// Default max length is max
    case helperText(text: String)
    /// Type to present remaining characters counter.
    ///
    /// Default max length is 50
    case characterCounter(stringFormat: String)
    /// Type to hide helper text
    case none
}

/**
 Custom component DSTextArea for Design System
 
 ![image](/DocumentationImages/ds-textarea.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSTextArea` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 5. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var textArea: DSTextArea!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         textArea.setup(title: "Label",
                        state: .filled,
                        text: "Lorem ipsum dolor sit amet,",
                        maxLine: 4,
                        maxLength: 50,
                        helperType: .characterCounter(stringFormat: stringFormat1),
                        placeholder: "Placeholder(optional)")
     }
     ```
 */
public final class DSTextArea: UIView {
    // MARK: - IBOutlet
    
    @IBOutlet public weak var textView: UITextView!

    @IBOutlet weak var helperTextView: DSHelperTextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textAreaContentView: UIView!
    @IBOutlet weak var heightTextView: NSLayoutConstraint!
    
    // MARK: - Private Properties
    private var titleLabelTopMargin = NSLayoutConstraint()
    private var titleLabelCenterYConstraint = NSLayoutConstraint()
    private var placeholderLabel: UILabel!
    public var hasTextInput: Bool {
        return textView.text != ""
    }
    /// For displaying helperText (Text below textarea).
    private var helperText: String = "" {
        didSet {
            helperTextView.text = helperText
        }
    }
    
    // MARK: - Public Properties
    /// Variable for updating state of DSTextArea.
    public var state: DSTextAreaState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    /// The maximum character that the text container can store.
    public var maxLength: Int = Int.max {
        didSet {
            textView.text = trimTextByMaxLength(text: text)
            updateHelperText()
        }
    }
    
    /// The maximum number of lines that the text container can store.
    public var maxLine: Int = 2 {
        didSet {
            if maxLine > 2 {
                heightTextView.constant = 16 + (DSFont.paragraphMedium?.lineHeight ?? 23.3) * CGFloat(maxLine)
            }
        }
    }
    
    /// `type` | `.helperText` or `.characterCounter` for setup style of helperText.
    public var helperType: DSHelperType = .helperText(text: "") {
        didSet {
            helperTextView.isHidden = false
            switch helperType {
            case .helperText(let text):
                helperText = text
            case .characterCounter(let stringFormat):
                helperTextView.text = String(format: stringFormat, maxLength - self.textView.text.unicodeScalars.count)
                if maxLength == Int.max {
                    maxLength = 50
                }
            case .none:
                helperTextView.isHidden = true
            }
        }
    }
    
    /// For displaying title (label when state idle, floating label when state focus).
    public var title: String = "" {
        didSet { titleLabel.text = title }
    }
    
    /// For displaying text of textarea.
    public var text: String {
        get {
            textView.text
        } set {
            textView.text = trimTextByMaxLength(text: newValue)
            if newValue.isNotEmpty {
                placeholderLabel.isHidden = true
                updateLayout(state: .filled, isAnimate: true)
            }
            updateHelperText()
        }
    }
    /// For displaying placeholder of textarea.
    public var placeholder: String = ""

    /// Returns a Boolean value indicating whether this object is the first responder.
    public override var isFirstResponder: Bool {
        return textView.isFirstResponder
    }

    /// The object that acts as the delegate of the DSTextArea.
    public weak var delegate: DSTextAreaDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup keyboard type of textarea
    public func setupKeyboard(keyboard: DSTextAreaKeyboardType) {
        switch keyboard {
        case .textAndNumber:
            textView.keyboardType = .default
        case .number:
            textView.keyboardType = .decimalPad
        }
    }
    
    /// Setup returnkey type of keyboard
    public func setReturnKey(type: UIReturnKeyType) {
        textView.returnKeyType = type
    }
    
    /// Setup DSTextArea
    ///
    /// Parameter for setup DSTextArea
    /// - Parameter title: text to display as the title label of DSTextArea.
    /// - Parameter state: state of DSTextArea.
    /// - Parameter text: text to display on the text view,  which is input method of DSTextArea (optional).
    /// - Parameter maxLine: the maximum number of lines that the text container can store (optional).
    /// - Parameter maxLength:the maximum character that the text container can store (optional).
    /// - Parameter helperType: to set type of helpertext and helpertext to display below DSTextArea (optional).
    /// - Parameter placeholder: text to display as the placeholder on the text view of DSTextArea (optional).
    public func setup(title: String,
                      state: DSTextAreaState,
                      text: String = "",
                      maxLine: Int = 2,
                      maxLength: Int = Int.max,
                      helperType: DSHelperType = .helperText(text: ""),
                      placeholder: String = "") {
        self.title = title
        self.state = state
        self.text = text
        self.maxLine = maxLine
        self.maxLength = maxLength
        self.helperType = helperType
        self.placeholder = placeholder
        
        updateAppearance()
    }

    /// Update textarea layout by state
    /// 
    /// - Parameter state: state of DSTextarea.
    /// - Parameter isAnimate: Is animating when change state.
    public func updateLayout(state: DSTextAreaState, isAnimate: Bool = false) {
        self.state = state
		if isAnimate {
			UIView.animate(
				withDuration: 0.2,
				animations: {
                    self.contentView.layoutIfNeeded()
				},
				completion: nil
			)
		} else {
            self.contentView.layoutIfNeeded()
		}
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           titleLabelId: String? = nil,
                                           textViewId: String? = nil,
                                           helperTextViewId: String? = nil,
                                           placeholderLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        titleLabel.accessibilityIdentifier = titleLabelId
        textView.accessibilityIdentifier = textViewId
        helperTextView.accessibilityIdentifier = helperTextViewId
        placeholderLabel.accessibilityIdentifier = placeholderLabelId
    }

    /// Return character before cursor
    public func characterBeforeCursor() -> String {
        guard let cursorRange = textView.selectedTextRange,
              let newPosition = textView.position(from: cursorRange.start, offset: -1),
              let range = textView.textRange(from: newPosition, to: cursorRange.start)
        else { return "" }
        return textView.text(in: range) ?? ""
    }

    public func setCursorPosition(range: NSRange) {
        textView.selectedRange = range
    }
}

// MARK: - UITextViewDelegate
extension DSTextArea: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        updateLayout(state: .focus, isAnimate: true)
        placeholderLabel.text = self.placeholder
        placeholderLabel.isHidden = self.hasTextInput ? true : false
        delegate?.textAreaDidBeginEditing(self)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.textAreaDidEndEditing(self)
        if case .error = self.state {
            updateLayout(state: .error(errorMessage: helperTextView.text), isAnimate: true)
        } else {
            let currentState: DSTextAreaState = self.hasTextInput ? .filled : .default
            updateLayout(state: currentState, isAnimate: true)
        }
        placeholderLabel.isHidden = self.hasTextInput ? false : true
        placeholderLabel.text = self.hasTextInput ? "" : placeholder
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.contains(UIPasteboard.general.string ?? "") {
            var validateText = text.replacingOccurrences(of: "\\n{1,}", with: "\n", options: .regularExpression)

            if textView.returnKeyType == .done {
                validateText = validateText.replacingOccurrences(of: "\n", with: " ")
            }

            let newText = (textView.text as NSString).replacingCharacters(in: range, with: validateText)
            
            if newText.unicodeScalars.count > maxLength {
                let modifiedText = delegate?.textArea(self, didChange: newText) ?? newText
                let trimText = trimTextByMaxLength(text: modifiedText)
                self.text = trimText
                textView.setCursorPosition(
                    position: trimText.unicodeScalars.count,
                    isMainThread: true
                )
                return false
            }

            return delegate?.textArea(self, shouldChangeTextIn: range, replacementText: text) ?? true
        } else if textView.returnKeyType != .default && text == "\n" {
            textView.resignFirstResponder()
            return false
        } else {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.unicodeScalars.count
            if numberOfChars <= maxLength {
                return delegate?.textArea(self, shouldChangeTextIn: range, replacementText: text) ?? true
            } else {
                return false
            }
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        updateHelperText()
        delegate?.textAreaDidChange(self)
    }
}

// MARK: - Private
private extension DSTextArea {
    func commonInit() {
        setupXib()
        setStyle()
        setupPlaceHolder()
    }

    func setStyle() {
        textView.textContainerInset = UIEdgeInsets(top: 4, left: 8, bottom: 8, right: 8)

        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = DSColor.componentLightOutline.cgColor
        contentView.backgroundColor = DSColor.componentLightBackground
        contentView.layer.cornerRadius = DSRadius.radius12px.rawValue

        titleLabel.numberOfLines = 1
        titleLabel.font = DSFont.placeholder
        titleLabel.textColor = DSColor.componentLightPlaceholder

        textView.delegate = self
        textView.font = DSFont.paragraphMedium
        textView.returnKeyType = .done
        
        titleLabelTopMargin = titleLabel.topAnchor.constraint(equalTo: textAreaContentView.topAnchor, constant: 8)
        titleLabelCenterYConstraint = titleLabel.topAnchor.constraint(equalTo: textAreaContentView.topAnchor, constant: 18)
        titleLabelCenterYConstraint.isActive = true
        self.clipsToBounds = true
    }

    func setupPlaceHolder() {
        placeholderLabel = UILabel()
        placeholderLabel.font = DSFont.paragraphMedium
        placeholderLabel.sizeToFit()
        textAreaContentView.addSubview(placeholderLabel)
        placeholderLabel.frame = CGRect(x: textView.frame.origin.x + 13, y: 16, width: textView.frame.width - 12, height: textView.frame.height)
        placeholderLabel.textColor = DSColor.componentLightPlaceholder
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func updateHelperText() {
        switch helperType {
        case .helperText(let text):
            helperText = text
        case .characterCounter(let stringFormat):
            helperTextView.text = String(format: stringFormat, maxLength - self.textView.text.unicodeScalars.count)
        case .none:
            helperText = ""
        }
    }
    
    func updateAppearance() {
        contentView.layer.borderColor = state.borderColor.cgColor
        contentView.backgroundColor = state.backgroundColor
        contentView.isUserInteractionEnabled = state.isUserInteractionEnabled
        textView.textColor = state.textColor
        helperTextView.isError = state.helperTextIsError
        
        switch state {
        case .default:
            titleLabelTopMargin.isActive = false
            titleLabel.font = DSFont.placeholder
            titleLabel.textColor = DSColor.componentLightPlaceholder
        case .focus:
            titleLabelTopMargin.isActive = true
            titleLabel.font = DSFont.labelInput
            titleLabel.textColor = DSColor.componentLightLabel
        case .filled:
            titleLabelTopMargin.isActive = true
            titleLabel.font = DSFont.labelInput
            titleLabel.textColor = DSColor.componentLightLabel
        case .error(let errorMessage):
            titleLabelTopMargin.isActive = hasTextInput
            titleLabel.font = hasTextInput ? DSFont.labelInput : DSFont.placeholder
            titleLabel.textColor = hasTextInput ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder
            helperType = .helperText(text: errorMessage)
        case .disable:
            titleLabelTopMargin.isActive = hasTextInput
            titleLabel.font = hasTextInput ? DSFont.labelInput : DSFont.placeholder
            titleLabel.textColor = hasTextInput ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder
            helperTextView.text = helperText
        }
        titleLabelCenterYConstraint.isActive = !titleLabelTopMargin.isActive
    }

    func trimTextByMaxLength(text: String) -> String {
        if text.unicodeScalars.count > maxLength {
            let start = text.unicodeScalars.startIndex
            let end = text.unicodeScalars.index(start, offsetBy: maxLength)
            let newText = String(text[start..<end])
            return newText
        } else {
            return text
        }
    }
}
