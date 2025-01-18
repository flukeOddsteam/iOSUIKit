//
//  MultipleTextFieldAmount.swift
//  OneAppDesignSystem
//
//  Created by TTB on 31/1/2567 BE.
//

import UIKit

public protocol DSMultipleTextFieldAmountDelegate: AnyObject {
    func multipleTextFieldDidChange(_ view: DSMultipleTextFieldAmount, with textField: DSTextFieldAmount, withId id: DSMultipleTextFieldIdentifier)
    func multipleTextFieldEditingDidEnd(_ view: DSMultipleTextFieldAmount, with textField: DSTextFieldAmount, withId id: DSMultipleTextFieldIdentifier)
    func multipleTextFieldEditingDidBegin(_ view: DSMultipleTextFieldAmount, with textField: DSTextFieldAmount, withId id: DSMultipleTextFieldIdentifier)
    func multipleTextFieldWillEditingBegin(_ view: DSMultipleTextFieldAmount, with textField: DSTextFieldAmount, withId id: DSMultipleTextFieldIdentifier)
}

public extension DSMultipleTextFieldAmountDelegate {
    func multipleTextFieldDidChange(_ view: DSMultipleTextFieldAmount, with textField: DSTextFieldAmount, withId id: DSMultipleTextFieldIdentifier) { }
    func multipleTextFieldEditingDidEnd(_ view: DSMultipleTextFieldAmount, with textField: DSTextFieldAmount, withId id: DSMultipleTextFieldIdentifier) { }
    func multipleTextFieldEditingDidBegin(_ view: DSMultipleTextFieldAmount, with textField: DSTextFieldAmount, withId id: DSMultipleTextFieldIdentifier) { }
    func multipleTextFieldWillEditingBegin(_ view: DSMultipleTextFieldAmount, with textField: DSTextFieldAmount, withId id: DSMultipleTextFieldIdentifier) { }
}

/**
 Custom component DSMultipleTextFieldAmount for Design System

 **Usage Example:**
 1. Create UIView on .xib file and assign `DSMultipleTextFieldAmount` Class to the UIView.
 2. Binding constraint and don't set `height`.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
 ```
     @IBOutlet weak var textField: DSMultipleTextFieldAmount!

     override func viewDidLoad() {
         super.viewDidLoad()
             textField.setup(
             viewModel: DSMultipleTextFieldViewModel(
                 type: .double,
                 state: .default,
                 helperText: nil,
                 primaryViewModel: DSMultipleTextFieldComponentViewModel(
                     title: title,
                     preFillValue: nil,
                     suffixText: nil,
                     maxLenght: nil,
                     formatType: .integer
                 ),
                 secondaryViewModel: DSMultipleTextFieldComponentViewModel(
                     title: title,
                     preFillValue: nil,
                     suffixText: nil,
                     maxLenght: nil,
                     formatType: .decimal
                 ),
                 tertiaryViewModel: nil)
         )
    }
 ```

 **DSMultipleTextFieldAmount has 3 types:**
 - single
 - double
 - triple

 **DSMultipleTextFieldAmount has 3 states:**
 - default
 - disable
 - error
 */

public final class DSMultipleTextFieldAmount: UIView {

    @IBOutlet public weak var primaryTextFieldAmount: DSTextFieldAmount!
    @IBOutlet public weak var secondaryTextFieldAmount: DSTextFieldAmount!
    @IBOutlet public weak var tertiaryTextFieldAmount: DSTextFieldAmount!
    @IBOutlet weak var helperTextView: DSHelperTextView!

    /// The delegation for receive event in textfield
    public weak var delegate: DSMultipleTextFieldAmountDelegate?

    /// The state of DSMultipleTextFieldAmount
    public var state: DSMultipleTextFieldState = .default {
        didSet {
            updateState()
        }
    }

    /// The type of DSMultipleTextFieldAmount
    public var type: DSMultipleTextFieldType = .double {
        didSet {
            updateDisplayTextField()
        }
    }

    /// The helper text of DSMultipleTextFieldAmount
    public var helperText: String? {
        didSet {
            updateHelperText(state: state)
        }
    }

    private var temporaryState: DSTextFieldAmountState = .default

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// Setup DSMultipleTextFieldAmount
    ///
    /// Parameter for setup DSMultipleTextFieldAmount
    /// - Parameter viewModel: style of DSMultipleTextFieldAmount (mandatory).
    public func setup(viewModel: DSMultipleTextFieldViewModel) {
        self.helperText = viewModel.helperText
        primaryTextFieldAmount.setup(
            titleText: viewModel.primaryViewModel.title,
            state: .default,
            type: .general,
            errorEmptyAmountText: "",
            textFieldValue: viewModel.primaryViewModel.preFillValue ?? "",
            helperText: "",
            placeholder: viewModel.primaryViewModel.formatType.placeholder,
            feeText: "",
            suffixText: viewModel.primaryViewModel.suffixText ?? "",
            maxLength: viewModel.primaryViewModel.maxLenght
        )
        primaryTextFieldAmount.formatType = viewModel.primaryViewModel.formatType

        secondaryTextFieldAmount.setup(
            titleText: viewModel.secondaryViewModel?.title ?? "",
            state: .default,
            type: .general,
            errorEmptyAmountText: "",
            textFieldValue: viewModel.secondaryViewModel?.preFillValue ?? "",
            helperText: "",
            placeholder: viewModel.secondaryViewModel?.formatType.placeholder ?? "",
            feeText: "",
            suffixText: viewModel.secondaryViewModel?.suffixText ?? "",
            maxLength: viewModel.secondaryViewModel?.maxLenght
        )
        secondaryTextFieldAmount.formatType = viewModel.secondaryViewModel?.formatType ?? .decimal

        tertiaryTextFieldAmount.setup(
            titleText: viewModel.tertiaryViewModel?.title ?? "",
            state: .default,
            type: .general,
            errorEmptyAmountText: "",
            textFieldValue: viewModel.tertiaryViewModel?.preFillValue ?? "",
            helperText: "",
            placeholder: viewModel.tertiaryViewModel?.formatType.placeholder ?? "",
            feeText: "",
            suffixText: viewModel.tertiaryViewModel?.suffixText ?? "",
            maxLength: viewModel.tertiaryViewModel?.maxLenght
        )
        tertiaryTextFieldAmount.formatType = viewModel.tertiaryViewModel?.formatType ?? .decimal

        self.type = viewModel.type
        self.state = viewModel.state
    }

    /// set state for DSMultipleTextFieldAmount
    ///
    /// Parameter for set specific state each textfield
    /// - Parameter state: The state of textfield for set specific
    /// - Parameter identifiers: group of identifier for set specific state
    public func set(state: DSTextFieldState, identifiers: Set<DSMultipleTextFieldIdentifier>) {
        identifiers.forEach {
            let textField = getTextFieldBy(id: $0)
            switch state {
            case .error:
                textField.setState(
                    state: .error(
                        errorMessage: ""
                    )
                )

            default:
                let amountState = DSTextFieldAmountState(state)
                textField.setState(state: amountState)
            }
        }
        
        let multipleState = DSMultipleTextFieldState(state)
        updateHelperText(state: multipleState)
    }
}

extension DSMultipleTextFieldAmount: DSTextFieldAmountDelegate {

    public func textFieldDidChange(_ textField: DSTextFieldAmount) {
        let id = DSMultipleTextFieldIdentifier(rawValue: textField.tag) ?? .primary
        delegate?.multipleTextFieldDidChange(self, with: textField, withId: id)
    }

    public func textFieldEditingDidEnd(_ textField: DSTextFieldAmount) {
        let id = DSMultipleTextFieldIdentifier(rawValue: textField.tag) ?? .primary
        let textField = getTextFieldBy(id: id)
        textField.setState(state: temporaryState)
        delegate?.multipleTextFieldEditingDidEnd(self, with: textField, withId: id)
    }

    public func textFieldEditingDidBegin(_ textField: DSTextFieldAmount) {
        let id = DSMultipleTextFieldIdentifier(rawValue: textField.tag) ?? .primary
        delegate?.multipleTextFieldEditingDidBegin(self, with: textField, withId: id)
    }

    public func textFieldWillEditingBegin(_ textField: DSTextFieldAmount) {
        let id = DSMultipleTextFieldIdentifier(rawValue: textField.tag) ?? .primary
        let state = getTextFieldBy(id: id).getState()
        temporaryState = state
        delegate?.multipleTextFieldWillEditingBegin(self, with: textField, withId: id)

    }
}

// MARK: - Private
private extension DSMultipleTextFieldAmount {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        let group = getTextFieldGroup()
        group.forEach {
            $0.configuration = DSTextFieldAmountConfiguration(autoDisplayEmptyError: false)
            $0.delegate = self
        }

        primaryTextFieldAmount.tag = DSMultipleTextFieldIdentifier.primary.rawValue
        secondaryTextFieldAmount.tag = DSMultipleTextFieldIdentifier.secondary.rawValue
        tertiaryTextFieldAmount.tag = DSMultipleTextFieldIdentifier.tertiary.rawValue
    }

    func updateDisplayTextField() {
        primaryTextFieldAmount.isHidden = type.isPrimaryTextFieldHidden
        secondaryTextFieldAmount.isHidden = type.isSecondaryTextFieldHidden
        tertiaryTextFieldAmount.isHidden = type.isTertiaryTextFieldHidden
    }

    func updateState() {
        switch state {
        case .default:
            setTextFieldGroupState(.default)
        case .disable:
            setTextFieldGroupState(.disable)
        case .error:
            setTextFieldGroupState(
                .error(
                    errorMessage: ""
                )
            )
        }

        updateHelperText(state: state)
    }

    func updateHelperText(state: DSMultipleTextFieldState) {
        switch state {
        case .error(let message):
            helperTextView.isHidden = message.isEmpty
            helperTextView.setup(textLeft: message, isError: true)
        default:
            helperTextView.isHidden = helperText.isNilOrEmpty
            helperTextView.setup(textLeft: helperText ?? "", isError: false)
        }
    }

    func getTextFieldGroup() -> [DSTextFieldAmount] {
        return [primaryTextFieldAmount, secondaryTextFieldAmount, tertiaryTextFieldAmount]
    }

    func getTextFieldBy(id: DSMultipleTextFieldIdentifier) -> DSTextFieldAmount {
        return getTextFieldGroup()
            .first { textField in
            textField.tag == id.rawValue
        } ?? primaryTextFieldAmount
    }

    func setTextFieldGroupState(_ state: DSTextFieldAmountState) {
        let group = getTextFieldGroup()
        group.forEach { $0.setState(state: state) }
    }
}

fileprivate extension DSTextFieldAmountState {
    init(_ state: DSTextFieldState) {
        switch state {
        case .default:
            self = .default
        case .focus:
            self = .focus
        case .filled:
            self = .default
        case .error(let message):
            self = .error(errorMessage: message)
        case .disable:
            self = .default
        }
    }
}

fileprivate extension DSMultipleTextFieldState {
    init(_ state: DSTextFieldState) {
        switch state {
        case .default:
            self = .default
        case .focus:
            self = .default
        case .filled:
            self = .default
        case .error(let message):
            self = .error(message: message)
        case .disable:
            self = .disable
        }
    }
}
