//
//  DSDropdown.swift
//  OneApp
//
//  Created by TTB on 7/9/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import Foundation
import UIKit

private enum Constants {
    static let defaultHeightNormalTextField: CGFloat = 60
    static let defaultHeightAccountTextField: CGFloat = 108
    static let defaultAnimationInterval: TimeInterval = 0.2
}

/**
 Custom component DSDropdown for Design System
 
 ![image](/DocumentationImages/ds-dropdown.png)
 ![image](/DocumentationImages/ds-dropdown-bottomsheet.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSDropdown` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Connect UIButton to `@IBAction` in text editor
 5. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
         @IBOutlet weak var dropdownField: DSDropdown!
         
         override func viewDidLoad() {
             super.viewDidLoad()
             dropdownField.tagId = 1
             dropdownField.delegate = self
             dropdownField.titleText = "Label"
             dropdownField.helperText = "Helping text(required)"
             dropdownField.updateLayout(state: .idle))
             dropdownField.itemList = itemList
             dropdownField.numberOfLines = 1
         }
     ```
     Display state as idle:
     ```
        dropdownField.updateLayout(state: .idle)
     ```
     Display state as focus:
     ```
        dropdownField.updateLayout(state: .focus)
     ```
     Display state as selected:
     ```
        dropdownField.updateLayout(state: .selected)
     ```
     Display state as error:
     ```
        dropdownField.updateLayout(state: .error(errorMessage: "Error Message"))
     ```
     Display state as disable:
     ```
        dropdownField.updateLayout(state: .disable)
     ```
     For data to display on BottomSheet Dropdown, it must be array of String:
     ```
         let itemList = [
             DSBottomSheetDropdownViewModel.DSBottomSheetItem(
                 icon: nil,
                 title: "Title label",
                 firstText: "",
                 secondText: ""
             ),
             DSBottomSheetDropdownViewModel.DSBottomSheetItem(
                 icon: nil,
                 title: "Title label",
                 firstText: "",
                 secondText: ""
             ),
             DSBottomSheetDropdownViewModel.DSBottomSheetItem(
                 icon: nil,
                 title: "Title label",
                 firstText: "",
                 secondText: ""
             )
         ]
         
         dropdownField.itemList = itemList
     ```
     Set selectedItem when there is selected option for the Dropdown field already:
     ```
        dropdownField.selectedItem = SelectedItem(text: itemList[index], selectedIndex: index)
     ```
 */
public class DSDropdown: UIView {
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var dropdownHelperTextView: DSHelperTextView!
    @IBOutlet weak var dropdownIconView: DSClickableIconBadge!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabelContentView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var textFieldAccountContentView: UIView!
    @IBOutlet weak var accountTitleLabel: UILabel!
    @IBOutlet weak var accountFirstLabel: UILabel!
    @IBOutlet weak var accountSecondLabel: UILabel!
    @IBOutlet weak var accountThirdLabel: UILabel!
    @IBOutlet weak var heightContainerViewConstraint: NSLayoutConstraint!
    
    // MARK: - Private variable
    private var titleLabelTopMargin = NSLayoutConstraint()
    private var titleLabelCenterYConstraint = NSLayoutConstraint()
    
    private var inputState: DSDropdownState = .idle
    private var previousState: DSDropdownState = .idle
    private var isSelectedBottomSheetItem: Bool = false
    private var selectionIndex: Int?
    private var isDisplayAnimate: Bool = true

    // MARK: - Public
    /// Variable for set tag ID of DSDropdown
    public var tagId: Int = 0
    public var isAutoDisplay: Bool = true
    public var leftIcon: DSIcons?
    public var itemList: [DSBottomSheetDropdownViewModel.DSBottomSheetItem] = []
    public var styleDropdown: DSDropdownStyle = .normal
    
    public weak var delegate: DSDropdownDelegate?
    
    /// Variable to get text value of text field
    public var text: String {
        return textLabel.text ?? ""
    }
    
    /// For displaying title which is label of idle state and floating label of focus state.
    public var titleText: String = "" {
        didSet { titleLabel.text = titleText }
    }
    
    /// For displaying bottomsheet title if this value not set bottomsheet title will be the same as dropdown title
    public var bottomSheetTitle: String?
    
    /// For displaying helperText which is the text below Dropdown field.
    public var helperText: String = "" {
        didSet { dropdownHelperTextView.text = helperText }
    }
    
    /// Variable for change number of line textLabel.
    public var numberOfLines: Int = 1 {
        didSet { textLabel.numberOfLines = numberOfLines }
    }
    
    private lazy var isShowAnimate: (Bool) -> Bool = { isDisplay in
        self.isDisplayAnimate = false
        return isDisplay && self.textLabel.text.isNilOrEmpty
    }
    
    /// For displaying selectedItem text of Dropdown field
    /// For displaying check icon as rightIcon of selectedItem on BottomSheet Dropdown
    @available(*, deprecated, message: "Deprecated, Please use function setSelectedIndex(_ :Int,_ animate: Bool)")
    public var selectedItem: SelectedItem? {
        didSet {
            textLabel.text = selectedItem?.text
            selectionIndex = selectedItem?.selectedIndex
            updateSelectionState(animate: false)
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
        
    /// For displaying DropdownField layout by state.
    /// - Parameter state: state of DSDropdown field.
    /// - Parameter isAnimate: Is animation when state changes.
    public func updateLayout(state: DSDropdownState, isAnimate: Bool = false) {
        inputState = state
        let appearance: DropdownAppearance = DropdownViewModel(
            state: state,
            previousState: previousState,
            hasSelected: textLabel.text.isNotNilAndNotEmpty,
            helperTextValue: helperText,
            helperTextIsErrorValue: dropdownHelperTextView.isError
        )

        titleLabel.font = appearance.titleFont
        titleLabel.textColor = appearance.titleTextColor

        contentView.layer.borderColor = appearance.borderColor.cgColor
        contentView.backgroundColor = appearance.backgroundColor
        contentView.isUserInteractionEnabled = appearance.contentViewIsUserInteractionEnabled

        dropdownHelperTextView.text = appearance.helperText
        dropdownHelperTextView.isError = appearance.helperTextIsError
        dropdownHelperTextView.isHidden = appearance.isHiddenHelperText
        
        textLabel.textColor = appearance.textFieldTextColor
        textLabel.layer.removeAllAnimations()
        textLabel.layoutIfNeeded()
        
        textLabelContentView.isUserInteractionEnabled = appearance.textFieldIsUserInteractionEnabled
        
        dropdownIconView.iconImageView.tintColor = appearance.iconImageTintColor

        titleLabelTopMargin.isActive = appearance.isActiveTitleLabelTopMargin
        titleLabelCenterYConstraint.isActive = appearance.isActiveTitleLabelYConstraint
        
        addGestureView(
            uiview: contentStackView,
            isUserInteractionEnabled: appearance.buttonIsUserInteractionEnabled
        )
        
        performAnimation(
            animated: isAnimate,
            interval: Constants.defaultAnimationInterval
        ) { [weak self] in
            guard let self = self else { return }
            self.textLabelContentView.layoutIfNeeded()
        }
    }
    
    public func clearData() {
        switch styleDropdown {
        case .normal, .actionIconValue:
            textLabel.text?.removeAll()
        case .account:
            textLabelContentView.isHidden = false
            textFieldAccountContentView.isHidden = true
            heightContainerViewConstraint.constant = Constants.defaultHeightNormalTextField
        }
        
        selectionIndex = nil
        isSelectedBottomSheetItem = false
        updateLayout(state: .idle)
    }
    
    public func showBottomSheetDropdown() {
        displayBottomSheetDropdown()
    }

    /// Before using this function. Please set items list to dropdown
    public func setSelectedIndex(title: String? = nil, index: Int?, animate: Bool = true) {
        selectionIndex = index
        if let title {
            textLabel.text = title
            updateSelectionState(animate: animate)
        } else {
            guard let index, let item = itemList[safe: index] else {
                return
            }

            switch styleDropdown {
            case .normal, .actionIconValue:
                updateSelectionUI(animate: animate)
            case .account:
                updateAccountDetail(itemAccount: item)
                updateLayout(state: inputState, isAnimate: animate)
            }
        }
    }

    public func getSelectedIndex() -> Int? {
        return selectionIndex
    }

    public func getCurrentState() -> DSDropdownState {
        return inputState
    }

    public func setAccessibilityIdentifier(style: DSDropdownStlyeAccessibilityIdentifier,
                                           id: String? = nil,
                                           dropdownHelperTextId: String? = nil,
                                           dropdownIconId: String? = nil) {
        self.accessibilityIdentifier = id
        self.dropdownHelperTextView.accessibilityIdentifier = dropdownHelperTextId
        self.dropdownIconView.accessibilityIdentifier = dropdownIconId
        
        switch style {
        case .normal(let titleLabelId, let textFieldId):
            self.titleLabel.accessibilityIdentifier = titleLabelId
            self.textLabel.accessibilityIdentifier = textFieldId
        case .account(let accountTitleLabelId, let accountFirstLabelId, let accountSecondLabelId, let accountThirdLabelId):
            self.accountTitleLabel.accessibilityIdentifier = accountTitleLabelId
            self.accountFirstLabel.accessibilityIdentifier = accountFirstLabelId
            self.accountSecondLabel.accessibilityIdentifier = accountSecondLabelId
            self.accountThirdLabel.accessibilityIdentifier = accountThirdLabelId
        case .actionIconValue(let titleLabelId, let textFieldId):
            self.titleLabel.accessibilityIdentifier = titleLabelId
            self.textLabel.accessibilityIdentifier = textFieldId
        }
    }

    func setFocusState() {
        previousState = inputState
        updateLayout(state: .focus, isAnimate: true)
    }
    
    public func addGestureView(
        uiview: UIView,
        isUserInteractionEnabled: Bool
    ) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onClickContentStackView(_:)))
        
        uiview.addGestureRecognizer(tap)
        uiview.isUserInteractionEnabled = isUserInteractionEnabled
    }
}

// MARK: - Action
extension DSDropdown {
    @IBAction func pressClickAbleIcon(_ sender: Any) {
        performPressedAction()
    }
    
    @objc func pressedContentView() {
        performPressedAction()
    }
    
    @objc func onClickContentStackView(_ sender: UITapGestureRecognizer? = nil) {
        performPressedAction()
    }
}

// MARK: - BottomSheetDropDownDelegate
extension DSDropdown: DSBottomSheetDropdownDelegate {
    public func bottomSheet(_ viewController: UIViewController, didSelectAt index: Int) {
        selectionIndex = index
        isSelectedBottomSheetItem = true

        updateSelectionUI(animate: isShowAnimate(isDisplayAnimate))
        delegate?.dropdown(self, didSelectAt: index, withTagId: tagId)
    }
    
    public func bottomSheet(_ viewController: UIViewController, didDismiss isSelected: Bool) {
        if !self.isSelectedBottomSheetItem {
            updateLayout(state: previousState, isAnimate: true)
        }

        if !isSelected {
            delegate?.dropdownDidCancel(self, withTagId: tagId)
        }
    }
}

// MARK: - Private
private extension DSDropdown {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        dropdownIconView.isHidden = false
        
        contentStackView.backgroundColor = .clear
        textLabel.backgroundColor = .clear
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = DSColor.componentLightOutline.cgColor
        contentView.backgroundColor = DSColor.componentLightBackground
        contentView.layer.cornerRadius = DSRadius.radius12px.rawValue
        
        titleLabel.numberOfLines = 1
        titleLabel.font = DSFont.placeholder
        titleLabel.textColor = DSColor.componentLightPlaceholder
        
        textLabel.numberOfLines = numberOfLines
        textLabel.font = DSFont.paragraphMedium
        textLabel.textColor = DSColor.componentLightDefault
        
        titleLabelTopMargin = titleLabel.topAnchor.constraint(
            equalTo: textLabelContentView.topAnchor,
            constant: 8
        )
        titleLabelCenterYConstraint = titleLabel.centerYAnchor.constraint(
            equalTo: textLabelContentView.centerYAnchor,
            constant: 0
        )
        titleLabelCenterYConstraint.isActive = true
        
        dropdownIconView.setup(style: .normal, image: DSIcons.icon24OutlineChevronDown.image)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pressedContentView))
        contentView.addGestureRecognizer(tapGesture)

        // MARK: - Account UI
        accountTitleLabel.textColor = DSColor.componentLightLabel
        accountTitleLabel.font = DSFont.labelInput
        accountFirstLabel.textColor = DSColor.componentLightDefault
        accountFirstLabel.font = DSFont.paragraphMedium
        accountSecondLabel.textColor = DSColor.componentLightDefault
        accountSecondLabel.font = DSFont.paragraphMedium
        accountThirdLabel.textColor = DSColor.componentLightDefault
        accountThirdLabel.font = DSFont.paragraphMedium
    }
    
    func updateSelectionState(animate: Bool) {
        switch inputState {
        case .idle, .selected, .focus:
            let state: DSDropdownState = self.selectionIndex.isNotNull ? .selected : .idle
            updateLayout(state: state, isAnimate: animate)
        default:
            updateLayout(state: inputState, isAnimate: animate)
        }
    }

    func updateSelectionUI(animate: Bool = true) {
        guard let index = selectionIndex, let item = itemList[safe: index] else {
            return
        }

        switch styleDropdown {
        case .account:
            updateAccountDetail(itemAccount: item)
            heightContainerViewConstraint.constant = Constants.defaultHeightAccountTextField
        case .normal, .actionIconValue:
            textLabel.text = item.title
            heightContainerViewConstraint.constant = Constants.defaultHeightNormalTextField
            updateSelectionState(animate: animate)
        }
    }

    func updateAccountDetail(itemAccount: DSBottomSheetDropdownViewModel.DSBottomSheetItem) {
        if case .error = self.inputState { return }
        textLabelContentView.isHidden = true
        textFieldAccountContentView.isHidden = false
        accountTitleLabel.text = titleText
        accountFirstLabel.text = itemAccount.title
        accountSecondLabel.text = itemAccount.firstText
        accountThirdLabel.text = itemAccount.secondText
    }

    func displayBottomSheetDropdown() {
        guard itemList.isNotEmpty else { return }
        guard let viewController = UIApplication.topViewController() else { return }

        var style: BottomSheetListStyle
        
        switch styleDropdown {
        case .normal:
            style = .listAction(viewModel: DSBottomSheetDropdownViewModel(title: bottomSheetTitle ?? titleText, leftIcon: leftIcon, selectedIndex: selectionIndex, listItem: itemList))
            let bottomSheet = DSBottomSheetDropdown(style: style)
            bottomSheet.delegate = self
            viewController.presentBottomSheet(viewController: bottomSheet)
        case .account:
            style = .listAccountAction(viewModel: DSBottomSheetDropdownViewModel(title: bottomSheetTitle ?? titleText, leftIcon: leftIcon, selectedIndex: selectionIndex, listItem: itemList))
            let bottomSheet = DSBottomSheetDropdown(style: style)
            bottomSheet.delegate = self
            viewController.presentBottomSheet(viewController: bottomSheet)
        case .actionIconValue:
            let bottomSheet = DSBottomSheetListActionIconValue(nibName: String(describing: DSBottomSheetListActionIconValue.self), bundle: .dsBundle)
            
            let dataList: [DSListActionIconValueViewModel] = itemList.enumerated().map { index, item in
                let isSelected = index == selectionIndex
                let rightIcon: DSIcons? = isSelected ? .icon24OutlineCheck : nil
                return DSListActionIconValueViewModel(
                    text: item.title,
                    valueText: item.firstText ?? "",
                    secondaryText: item.secondText,
                    leftIcon: item.icon,
                    rightIcon: rightIcon,
                    hideRightIcon: .onlyIcon
                )
            }
            
            bottomSheet.setUp(
                viewModel: .init(
                    title: bottomSheetTitle ?? titleText,
                    leftIcon: leftIcon,
                    selectedIndex: selectionIndex,
                    listItem: dataList
                )
            )
            bottomSheet.delegate = self
            viewController.presentBottomSheet(viewController: bottomSheet)
        }
                
        setFocusState()
        isSelectedBottomSheetItem = false
    }

    func performPressedAction() {
        delegate?.dropdownDidTapped(self, withTagId: tagId)

        guard isAutoDisplay else {
            return
        }

        displayBottomSheetDropdown()
    }
}
