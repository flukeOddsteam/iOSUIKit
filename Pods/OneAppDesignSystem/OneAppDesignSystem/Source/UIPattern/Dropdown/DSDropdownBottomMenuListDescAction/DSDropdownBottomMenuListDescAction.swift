//
//  DSDropdownBottomMenuListDescAction.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/6/2567 BE.
//

import UIKit

public protocol DSDropdownBottomMenuListDescActionDelegate: AnyObject {
    func dropdownMenuListDescActionDidTapGhostButton(_ view: DSDropdownBottomMenuListDescAction)
    func dropdownMenuListDescActionBottomSheetDidClosed(_ view: DSDropdownBottomMenuListDescAction)
    func dropdownMenuListDescAction(_ view: DSDropdownBottomMenuListDescAction, didSelectAt index: Int)
}

/// Enum DSDropdown state
public enum DSDropdownBottomMenuListDescActionState: Equatable {
    /// Normal State before being pressed
    case `default`
    /// State when being pressed and focused on Dropdown field
    case focus
    /// State error with alert icon and error message below Dropdown field
    case error(message: String)
    /// State disable Dropdown field
    case disable
}

/**
    Custom component DropdownBottomMenuListDescAction for design system
 
    ![image](/DocumentationImages/ds-DropdownBottomMenuListDescAction.png)
    ![image](/DocumentationImages/ds-BottomMenuListDescActionHalf.png)
    ![image](/DocumentationImages/ds-BottomMenuListDescAction2CardFull.png)
    ![image](/DocumentationImages/ds-BottomMenuListDescActionFull.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSDropdownBottomMenuListDescAction` Class to the UIView.
    2. Binding constraint and don't set `height`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
 
    Display presentationType Half Page:
     ```
     @IBOutlet weak var dropdown: DSDropdownBottomMenuListDescAction!
     
     override func viewDidLoad() {
         super.viewDidLoad()
 
         dropdown.delegate = self
         dropdown.setup(viewModel: DSMenuListDescriptionActionViewModel(title: "Header, Keep it short (1 line)",
                                                                      ghostButtonIcon: DSIcons.icon24OutlinePlus,
                                                                      ghostButtonText: "Ghost Text",
                                                                      iconSize: .medium,
                                                                      items: item2List,
                                                                      presentationType: .dynamic
                                                                     ),
                         title: "Label",
                         helperText: "Helping text(required)"
                        )
     }
     ```
     Display presentationType Full Page:
      ```
      @IBOutlet weak var dropdown: DSDropdownBottomMenuListDescAction!
      
      override func viewDidLoad() {
          super.viewDidLoad()

          dropdown.delegate = self
          dropdown.setup(viewModel: DSMenuListDescriptionActionViewModel(title: "Header, Keep it short (1 line)",
                                                                       ghostButtonIcon: DSIcons.icon24OutlinePlus,
                                                                       ghostButtonText: "Ghost Text",
                                                                       iconSize: .medium,
                                                                       items: item2List,
                                                                       presentationType: .fullpage
                                                                      ),
                          title: "Label",
                          helperText: "Helping text(required)"
                         )
      }
      ```
     Display state default:
     ```
        dropdown.state = .default
     ```
     Display state focus:
     ```
        dropdown.state = .focus
     ```
     Display state error:
     ```
        dropdown.state = .error(message: "Helping text (required)")
     ```
     Display state disable:
     ```
        dropdown.state = .disable
     ```
     
     **Note:**
     1. `IconClickAble` The image must be entered correctly by
        **Medium** Size
*/

public final class DSDropdownBottomMenuListDescAction: UIView {

    @IBOutlet weak var baseTextField: DSTextField!

    public weak var delegate: DSDropdownBottomMenuListDescActionDelegate?

    public var selectedIndex: Int?

    public var title: String = "" {
        didSet {
            baseTextField.title = title
        }
    }

    public var placeholder: String {
        get {
            return baseTextField.placeholder
        } set {
            baseTextField.placeholder = newValue
        }
    }

    public var helperText: String {
        get {
            return baseTextField.helperTextView.text
        } set {
            baseTextField.helperTextView.text = newValue
        }
    }

    public var text: String {
        get {
            baseTextField.text
        } set {
            baseTextField.text = newValue
        }
    }

    public var state: DSDropdownBottomMenuListDescActionState = .default {
        didSet {
            baseTextField.updateLayout(
                state: DSTextFieldState(
                    state
                )
            )
        }
    }

    private var viewModel: DSMenuListDescriptionActionViewModel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    public func setup(
        viewModel: DSMenuListDescriptionActionViewModel,
        title: String,
        helperText: String
    ) {
        self.viewModel = viewModel
        baseTextField.setup(
            title: title,
            state: .default,
            text: "",
            helperText: helperText,
            placeholder: "",
            clickAbleIcon: DSIcons.icon24OutlineChevronDown.image,
            clickableIconAction: {
                self.displayBottomSheet()
            }
        )
    }

    public func setState(_ state: DSDropdownBottomMenuListDescActionState) {
        self.state = state
    }

    public func setSelectedIndex(title: String? = nil, index: Int?, animate: Bool = true) {
        if let title = title {
            baseTextField.text = title
            baseTextField.updateLayout(state: title.isEmpty ? .default : .filled)
        }

        if let index = index {
            selectedIndex = index
            let title = title ?? viewModel.items[safe: index]?.titleText ?? ""
            baseTextField.text = title
            baseTextField.updateLayout(state: title.isEmpty ? .default : .filled)
        }
    }
}

extension DSDropdownBottomMenuListDescAction: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        updatePresentationState(presentationState: .open)
        displayBottomSheet()
        return false
    }
}

// MARK: - DSDropdownBottomMenuListDescAction
extension DSDropdownBottomMenuListDescAction: MenuListDescriptionActionDelegate {
    func menuListDescriptionActionDidTapGhostButton(_ viewController: UIViewController) {
        delegate?.dropdownMenuListDescActionDidTapGhostButton(self)
    }

    func menuListDescriptionAction(_ viewController: UIViewController, didSelectItemAt index: Int) {
        selectedIndex = index
        baseTextField.text = viewModel.items[index].titleText
        if state == .default {
            baseTextField.updateLayout(state: baseTextField.text.isNotEmpty ? .filled : .default)
        } else {
            baseTextField.updateLayout(state: DSTextFieldState(state))

        }
        delegate?.dropdownMenuListDescAction(self, didSelectAt: index)
    }

    func menuListDescriptionActionDidDismiss(_ viewController: UIViewController) {
        updatePresentationState(presentationState: .closed)
        delegate?.dropdownMenuListDescActionBottomSheetDidClosed(self)
    }
}

// MARK: - Private
private extension DSDropdownBottomMenuListDescAction {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        baseTextField.textField.delegate = self
        layoutIfNeeded()
    }

    func updatePresentationState(presentationState: PresentationState) {
        switch presentationState {
        case .open:
            if state == .default {
                baseTextField.setFocus()
            }
        case .closed:
            if state == .default {
                baseTextField.updateLayout(
                    state: baseTextField.text.isNotEmpty ? .filled : .default
                )
            }
        }
    }

    func displayBottomSheet() {
        guard viewModel.items.isNotEmpty,
              let rootViewController = UIApplication.getWindow()?.rootViewController else {
            return
        }

        let viewController = MenuListDescriptionActionViewController(viewModel: viewModel)
        viewController.delegate = self
        viewController.selectedIndex = selectedIndex
        rootViewController.presentBottomSheet(viewController: viewController)
    }
}

// MARK: - Private DSDropdownBottomMenuListDescAction
private extension DSDropdownBottomMenuListDescAction {
    enum PresentationState {
        case open
        case closed

        func value<T>(open: T, closed: T) -> T {
            switch self {
            case .open:
                return open
            case .closed:
                return closed
            }
        }
    }
}

// MARK: - DSTextFieldState
fileprivate extension DSTextFieldState {
    init(_ state: DSDropdownBottomMenuListDescActionState) {
        switch state {
        case .default:
            self = .default
        case .focus:
            self = .focus
        case .error(let message):
            self = .error(errorMessage: message)
        case .disable:
            self = .disable
        }
    }
}

fileprivate extension DSTextField {
    func setFocus() {
        contentView.setBorder(
            width: 1,
            color: DSColor.componentLightOutlineInputFocus
        )
    }
}
