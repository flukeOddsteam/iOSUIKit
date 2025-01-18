//
//  DSAmountRadioCardExpandable.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/9/2567 BE.
//

import UIKit

private enum Constants {
    static let defaultBorderWidth: CGFloat = 1.0
    static let selectedBorderWidth: CGFloat = 2.0

    static let defaultBorderColor: UIColor = DSColor.componentLightOutlinePrimary
    static let selectedBorderColor: UIColor = DSColor.componentLightOutlineActive

    static let defaultImageOpacity: CGFloat = 1.0
    static let disableImageOpacity: CGFloat = 0.3

    static let defaultAnimationTimeInterval: TimeInterval = 0.3
}

/**
 UIKit component DSAmountRadioCardExpandable for Design System

 This class represents an expandable radio button with an title, remark, ghost button and text field amount inside.

 ![image](/DocumentationImages/ds-amount-radio-card-expandable.png)

 **Usage Example:**
 1. Create UIView on .xib file and assign `DSAmountRadioCardExpandable` Class to the UIView.
 2. Binding constraint and don't set `height`.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set up the component using the `setup(viewModel:)` method.
 5. Optionally, set the `onSelectedRadioCard` closure to handle selection events and `onSelectedGhostButton` to handle event click from ghost button

 ```
 class ViewController: UIViewController {

     @IBOutlet weak var amountRadioCardExpandable: DSAmountRadioCardExpandable!

     override func viewDidLoad() {
         super.viewDidLoad()
         amountRadioExpandable1.setup(
             viewModel: DSAmountRadioCardExpandableViewModel(
                 isSelected: false,
                 isEnabled: true,
                 title: "Label1",
                 remark: DSAmountRadioCardExpandableViewModel.Remark(
                     title: "หมายเหตุ",
                     isShowSymbol: true,
                     bullets: [
                         "Title  Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                         "Title  Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                     ]
                 ),
                 textField: DSAmountRadioCardExpandableViewModel.TextFieldAmount(
                         titleText: "Label",
                         state: .default,
                         type: .general,
                         errorEmptyAmountText: "โปรดกรอกตัวเลข",
                         textFieldValue: "",
                         helperText: "",
                         placeholder: "0.00",
                         feeText: "",
                         suffixText: "",
                         maxLength: nil
                     )
             ),
             animated: false
         )

         amountRadioExpandable1.tagId = 1
         amountRadioExpandable1.onSelectedRadioCard = { view, tagId in
            // Do Stuff
         }
     }
 }
 ```
 */
public final class DSAmountRadioCardExpandable: UIView {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerContent: AmountRadioHeaderContent!
    @IBOutlet weak var inputContent: AmountRadioInputContent!

    /// tagId for DSAmountRadioCardExpandable.
    public var tagId: Int = .zero

    /// title variable for set label in radio card view
    public var title: String? {
        didSet {
            headerContent.title = title
        }
    }

    /// variable for setup/update remark section in component (if this variable is null, It will hidden)
    public var remark: DSAmountRadioCardExpandableViewModel.Remark? {
        didSet {
            inputContent.setRemark(remark)
        }
    }

    /// variable for setup/update ghost button in component (if this variable is null, It will hidden)
    public var ghostButton: DSAmountRadioCardExpandableViewModel.GhostButton? {
        didSet {
            inputContent.setGhostButton(viewModel: ghostButton)
        }
    }

    /// variable for get amount text field for observe value or set config and value
    public var amountTextField: DSTextFieldAmount {
        inputContent.textField
    }

    /// Closure triggered when the user selects the radio
    public var onSelectedRadioCard: ((DSAmountRadioCardExpandable, Int) -> Void)?

    /// Closure triggered when the user selects the ghost button in radio
    public var onSelectedGhostButton: ((DSAmountRadioCardExpandable, Int) -> Void)?

    private var isEnabled: Bool = true {
        didSet {
            updateRadioAppearance()
        }
    }

    private var isSelected: Bool = false {
        didSet {
            updateRadioAppearance()
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

    /**
     Setup function for initial view data for DSAmountRadioCardExpandable.

     - Parameters:
       - viewModel: The DSAmountRadioCardExpandableViewModel used to configure the component.
         - title: The title to be displayed.
         - isSelected: Determines if the radio button is currently selected.
         - isEnabled: Determines if the radio button is disabled.
         - ghostButton: the ghost button view model (can be optional if it null it will gone).
         - textField: the Getter of amount text field for access and set it
     */

    public func setup(viewModel: DSAmountRadioCardExpandableViewModel, animated: Bool) {
        self.isEnabled = viewModel.isEnabled
        self.isSelected = viewModel.isSelected
        self.title = viewModel.title
        self.remark = viewModel.remark
        self.ghostButton = viewModel.ghostButton

        inputContent.setTextField(viewModel: viewModel.textField)
        updateExpandedState(animated: animated)
    }

    /// Set state enable/disable for DSAmountRadioCardExpandable
    ///
    /// Parameter for setEnabled
    /// - Parameter isEnabled: state of enable / disable.
    /// - Parameter animated: animation boolean for display expand.
    public func setEnabled(_ isEnabled: Bool, animated: Bool) {
        self.isEnabled = isEnabled
        updateExpandedState(animated: animated)
    }

    /// function get current state enable/disable of DSAmountRadioCardExpandable
    public func getEnabled() -> Bool {
        isEnabled
    }

    /// Set state selected/unselect for DSAmountRadioCardExpandable. Cannot set selected when your state is disabled. It will do nothing.
    ///
    /// Parameter for setEnabled
    /// - Parameter isEnabled: state of selected / unselect.
    /// - Parameter animated: animation boolean for display expand.
    public func setSelected(_ isSelected: Bool, animated: Bool) {
        self.isSelected = isSelected
        updateExpandedState(animated: animated)
    }

    /// function get current state select/unselect of DSAmountRadioCardExpandable
    public func getSelected() -> Bool {
        isSelected
    }
}

// MARK: - AmountRadioHeaderContentDelegate
extension DSAmountRadioCardExpandable: AmountRadioHeaderContentDelegate {
    func amountRadioHeaderDidTapped(_ view: AmountRadioHeaderContent) {
        onSelectedRadioCard?(self, tagId)
        if isEnabled {
            amountTextField.textField.becomeFirstResponder()
        }
    }
}

// MARK: - AmountRadioInputContentDelegate
extension DSAmountRadioCardExpandable: AmountRadioInputContentDelegate {
    func amountRadioInputGhostButtonDidTapped(_ view: AmountRadioInputContent) {
        onSelectedGhostButton?(self, tagId)
    }
}

// MARK: - Private
private extension DSAmountRadioCardExpandable {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        headerContent.delegate = self
        inputContent.delegate = self

        stackView.setRadius(radius: .radius12px)
        stackView.backgroundColor = DSColor.componentLightBackground
    }

    func updateRadioAppearance() {
        headerContent.updateState(
            isEnabled: isEnabled,
            isSelected: isSelected
        )

        var borderWidth: CGFloat = Constants.defaultBorderWidth
        var borderColor: UIColor = Constants.defaultBorderColor

        if isEnabled {
            borderWidth = isSelected ? Constants.selectedBorderWidth : Constants.defaultBorderWidth
            borderColor = isSelected ? Constants.selectedBorderColor : Constants.defaultBorderColor
        }

        backgroundColor = DSColor.componentLightBackground
        setRadius(radius: .radius12px)

        dsShadowDrop(
            isHidden: !isEnabled
        )

        stackView.setBorder(
            width: borderWidth,
            color: borderColor
        )
    }

    func updateExpandedState(animated: Bool) {
        let isInputHidden = isEnabled ? !isSelected : true
        if animated {
            let animator = UIViewPropertyAnimator(
                duration: Constants.defaultAnimationTimeInterval,
                curve: .easeInOut
            ) { [weak self] in
                guard let self else { return }
                self.inputContent.isHidden = isInputHidden
                self.stackView.layoutIfNeeded()
            }

            animator.addCompletion { [weak self] _ in
                guard let self else { return }
                self.inputContent.isHidden = isInputHidden
            }
            
            animator.startAnimation()
        } else {
            inputContent.isHidden = isInputHidden
            stackView.layoutIfNeeded()
        }
    }
}
