//
//  DSDropdownFilter.swift
//  OneApp
//
//  Created by TTB on 21/11/2566 BE.
//  Copyright © 2566 BE TTB. All rights reserved.
//

import Foundation
import UIKit

private enum Constants {
    static let defaultHeightNormalTextField: CGFloat = 60
    static let defaultAnimationInterval: TimeInterval = 0.2
}

/**
 Custom component DSDropdown for Design System
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSDropdownFilter` Class to the UIView
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
             DSBottomSheetDropdownFilterViewModel.DSBottomSheetItem(
                 icon: nil,
                 title: "Title label",
                 firstText: "",
                 secondText: ""
             ),
             DSBottomSheetDropdownFilterViewModel.DSBottomSheetItem(
                 icon: nil,
                 title: "Title label",
                 firstText: "",
                 secondText: ""
             ),
             DSBottomSheetDropdownFilterViewModel.DSBottomSheetItem(
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

     Set emptyViewModel for Empty State UI on search
 ```
        dropdownField.emptyViewModel = .init(style: .iconMedium(image: UIImage()), description: String)
 ```
 */
public class DSDropdownFilter: UIView {
    @IBOutlet weak var transparentButtonView: UIButton!
    @IBOutlet weak var dropdownHelperTextView: DSHelperTextView!
    @IBOutlet weak var dropdownIconView: DSClickableIconBadge!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextFieldPadding!
    @IBOutlet weak var textFieldContentView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var heightContainerViewConstraint: NSLayoutConstraint!
    
    // MARK: - Private variable
    private var titleLabelTopMargin = NSLayoutConstraint()
    private var titleLabelCenterYConstraint = NSLayoutConstraint()
    
    private var inputState: DSDropdownState = .idle
    private var previousState: DSDropdownState = .idle
    private var isSelectedBottomSheetItem: Bool = false
    private var selectionIndex: Int?

    // MARK: - Public
    /// Variable for set tag ID of DSDropdown
    public var tagId: Int = 0
    public var isAutoDisplay: Bool = true
    public var leftIcon: DSIcons?
    public var itemList: [DSBottomSheetDropdownFilterViewModel.DSBottomSheetItem] = []
    public var searchTextFieldPlaceholder: String = ""
    public var searchTextFieldTitleToolBar: String = ""
    public var emptyViewModel: DSBottomSheetDropdownFilterViewModel.EmptyViewModel?
    
    public weak var delegate: DSDropdownFilterDelegate?
    
    // Variable to show max height of screen for dropdown
    public var isDisplayMaxHeight: Bool = false
    
    /// Variable to get text value of text field
    public var text: String {
        return textField.text ?? ""
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
    
    /// For displaying selectedItem text of Dropdown field
    /// For displaying check icon as rightIcon of selectedItem on BottomSheet Dropdown
    public var selectedItem: SelectedItem? {
        didSet {
            textField.text = selectedItem?.text
            selectionIndex = selectedItem?.selectedIndex
            updateState()
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
        let appearance: DropdownAppearance = DropdownFilterViewModel(
            state: state,
            hasSelected: selectionIndex.isNotNull,
            helperTextValue: helperText,
            helperTextIsErrorValue: dropdownHelperTextView.isError
        )

        titleLabel.font = appearance.titleFont
        titleLabel.textColor = appearance.titleTextColor

        contentView.layer.borderColor = appearance.borderColor.cgColor
        contentView.backgroundColor = appearance.backgroundColor
        contentView.isUserInteractionEnabled = appearance.contentViewIsUserInteractionEnabled

        dropdownHelperTextView.isError = appearance.helperTextIsError
        dropdownHelperTextView.text = appearance.helperText
        dropdownHelperTextView.isHidden = appearance.isHiddenHelperText

        textField.textColor = appearance.textFieldTextColor
        textFieldContentView.isUserInteractionEnabled = appearance.textFieldIsUserInteractionEnabled

        transparentButtonView.isUserInteractionEnabled = appearance.buttonIsUserInteractionEnabled
        dropdownIconView.iconImageView.tintColor = appearance.iconImageTintColor

        titleLabelTopMargin.isActive = appearance.isActiveTitleLabelTopMargin
        titleLabelCenterYConstraint.isActive = appearance.isActiveTitleLabelYConstraint

        performAnimation(
            animated: isAnimate,
            interval: Constants.defaultAnimationInterval
        ) { [weak self] in
            guard let self = self else { return }
            self.textFieldContentView.layoutIfNeeded()
        }
    }
    
    public func clearData() {
        textField.text?.removeAll()

        selectionIndex = nil
        updateLayout(state: .idle)
    }
    
    public func showBottomSheetDropdown() {
        displayBottomSheetDropdown()
    }
}

// MARK: - Action
extension DSDropdownFilter {
    @IBAction func pressedTransparentButton(_ sender: Any) {
        performPressedAction()
    }
    
    @IBAction func pressClickAbleIcon(_ sender: Any) {
        performPressedAction()
    }
    
    @objc func pressedContentView() {
        performPressedAction()
    }
}

// MARK: - BottomSheetDropDownDelegate
extension DSDropdownFilter: DSBottomSheetDropdownFilterDelegate {
    public func bottomSheet(_ viewController: UIViewController, didSelectAt index: Int) {
        selectionIndex = index
        isSelectedBottomSheetItem = true

        updateSelectionUI()

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

    public func bottomSheet(_ viewController: UIViewController, didFilter text: String, on item: ListActionIconViewModel) -> Bool {
        guard let delegate = delegate else {
            return true
        }
        return delegate.dropdownDidFilter(self, filteredText: text, filteredItem: item, withTagId: tagId)
    }
}

// MARK: - Private
private extension DSDropdownFilter {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        dropdownIconView.isHidden = false
        
        transparentButtonView.backgroundColor = .clear
        
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
        textField.textColor = DSColor.componentLightDefault
        
        titleLabelTopMargin = titleLabel.topAnchor.constraint(equalTo: textFieldContentView.topAnchor, constant: 8)
        titleLabelCenterYConstraint = titleLabel.centerYAnchor.constraint(equalTo: textFieldContentView.centerYAnchor, constant: 0)
        titleLabelCenterYConstraint.isActive = true
        
        dropdownIconView.setup(style: .normal, image: DSIcons.icon24OutlineChevronDown.image)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pressedContentView))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    func setFocusState() {
        let currentState: DSDropdownState = .focus
        if self.dropdownHelperTextView.isError == true {
            previousState = .error(errorMessage: self.helperText)
        } else if self.selectionIndex.isNotNull {
            previousState = .selected
        } else {
            previousState = .idle
        }
        updateLayout(state: currentState, isAnimate: true)
    }
    
    func updateState() {
        if case .error = self.inputState { return }
        let state: DSDropdownState = self.selectionIndex.isNotNull ? .selected : .idle
        updateLayout(state: state, isAnimate: true)
    }

    func updateSelectionUI() {
        guard let index = selectionIndex else {
            return
        }
        textField.text = itemList[index].title
        heightContainerViewConstraint.constant = Constants.defaultHeightNormalTextField
        updateState()
    }

    func displayBottomSheetDropdown() {
        guard itemList.isNotEmpty, let emptyViewModel else { return }
        guard let viewController = UIApplication.topViewController() else { return }

        let style: BottomSheetFilterListStyle = .listAction(viewModel: DSBottomSheetDropdownFilterViewModel(
            title: bottomSheetTitle ?? titleText,
            searchTextFieldPlaceholder: searchTextFieldPlaceholder,
            searchTextFieldTitleToolBar: searchTextFieldTitleToolBar,
            leftIcon: leftIcon,
            selectedIndex: selectionIndex,
            listItem: itemList,
            emptyViewModel: emptyViewModel,
            isDisplayMaxHeight: isDisplayMaxHeight
        ))
        let bottomSheet = DSBottomSheetDropdownFilter(style: style)
        bottomSheet.delegate = self
        viewController.presentBottomSheet(viewController: bottomSheet)

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
