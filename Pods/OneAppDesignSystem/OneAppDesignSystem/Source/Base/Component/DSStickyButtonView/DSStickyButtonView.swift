//
//  DSStickyButtonView.swift
//  OneApp
//
//  Created by TTB on 5/9/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import UIKit

public enum DSStickyButtonStyle {
    case vertical(primaryButton: DSButtonViewModel,
                  ghostButton: DSButtonViewModel?)
    case ghostHorizontal(primaryButton: DSButtonViewModel,
                         ghostButton: DSButtonViewModel)
    case secondaryHorizontal(primaryButton: DSButtonViewModel,
                             secondaryButton: DSButtonViewModel)
    case checkbox(checkboxText: String,
                  checkboxAction: DSSelectionCheckboxAction?,
                  checkboxGhostButton: DSButtonViewModel?,
                  primaryButton: DSButtonViewModel,
                  ghostButton: DSButtonViewModel?)
    case message(titleText: String,
                 descriptionText: String?,
                 helperText: String?,
                 primaryButton: DSButtonViewModel,
                 ghostButton: DSButtonViewModel?)
    case listExpand(labeltext: String,
                    valueText: String,
                    iconImage: DSIcons?,
                    iconAction: StickyButtonListExpandAction?,
                    primaryButton: DSButtonViewModel,
                    ghostButton: DSButtonViewModel?,
                    valueSize: DSStickyButtonValueSize = .small)
    case radio(leftRadioText: String,
               leftRadioIsSelected: Bool = false,
               leftRadioAction: ActionHandler? = nil,
               rightRadioText: String,
               rightRadioIsSelected: Bool = false,
               rightRadioAction: ActionHandler? = nil,
               primaryButton: DSButtonViewModel,
               primaryButtonIsEnable: Bool = false)
}

public typealias ActionHandler = () -> Void

public enum DSStickyButtonStyleAccessibilityIdentifier {
    case vertical(primaryButtonId: String,
                  primaryButtonLabelId: String,
                  ghostButtonId: String,
                  ghostButtonLabelId: String)
    case ghostHorizontal(primaryButtonId: String,
                         primaryButtonLabelId: String,
                         ghostButtonId: String,
                         ghostButtonLabelId: String)
    case secondaryHorizontal(primaryButtonId: String,
                             primaryButtonLabelId: String,
                             secondaryButtonId: String,
                             secondaryButtonLabelId: String)
    case checkbox(checkboxTextId: String,
                  primaryButtonId: String,
                  primaryButtonLabelId: String,
                  ghostButtonId: String,
                  ghostButtonLabelId: String)
    case message(titleTextId: String,
                 descriptionTextId: String,
                 helperTextId: String,
                 primaryButtonId: String,
                 primaryButtonLabelId: String,
                 ghostButtonId: String,
                 ghostButtonLabelId: String)
    case listExpand(labeltextId: String,
                    valueTextId: String,
                    iconImageId: String,
                    primaryButtonId: String,
                    primaryButtonLabelId: String,
                    ghostButtonId: String,
                    ghostButtonLabelId: String)
    case radio(leftRadioId: String,
               rightRadioId: String,
               primaryButtonId: String,
               primaryButtonLabelId: String)
}

/**
 Custom component DSStickyButtonView

 **DSStickyButton style default**
 
 ![image](/DocumentationImages/ds-sticky-button-2.png)

 **DSStickyButton style checkbox**
 
 ![image](/DocumentationImages/ds-sticky-button-checkbox.png)
 
 **DSStickyButton style checkbox (Have Checkbox Ghost Button)**
 
 ![image](/DocumentationImages/ds-sticky-button-special-checkbox- primary-action.png)
 
 **DSStickyButton style message**
 
 ![image](/DocumentationImages/ds-sticky-button-message.png)
 
 **DSStickyButton style list expand**
 
 ![image](/DocumentationImages/ds-sticky-button-list-expand.png)
 
 **DSStickyButton style secondaryHorizontal**

 ![image](/DocumentationImages/ds-sticky-button-horizontal.png)
 
 **DSStickyButton style ghostHorizontal**
 
 ![image](/DocumentationImages/ ds-sticky-button-ghost-horizontal.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSStickyButtonView` Class to the UIView
 2. Connect UIView to `@IBOutlet` in text editor
 3. Call func setup() and send parameter that required and optional parameter for style that you want. (you can get name of style from figma by click on component sticky button and see the details.)

 For example: DSStickyButton every style.
  ```
 @IBOutlet weak var stickyButton: DSStickyButtonView!
  
 
  override func viewDidLoad() {
     super.viewDidLoad()
 
     // Example: Sticky Button/ General Vertical
     stickyButton.setup(
         style: .vertical(
             primaryButton: DSButtonViewModel(
                 title: "Primary",
                 icon: nil,
                 onClick: {
                     debugPrint("Primary pressed")
                 }
             ),
             ghostButton: DSButtonViewModel(
                 title: "Ghost",
                 icon: nil,
                 onClick: {
                     debugPrint("Ghost pressed")
                 }
             )
         )
     )
 
     // Example: Sticky Button/ Special + Checkbox
     stickyButton.setup(
         style: .checkbox(
             checkboxText: "Label",
             checkboxAction: { currentState in
                 print(currentState)
             },
             primaryButton: DSButtonViewModel(
                 title: "Primary",
                 icon: nil,
                 onClick: primaryButtonOnPress
             ),
             ghostButton: nil
         )
     )
 
     // Example: Sticky Button/ Special + Checkbox / Checkbox Ghost Button
     stickyButton.setup(
         style: .checkbox(
             checkboxText: "Label",
             checkboxAction: { currentState in
                 print(currentState)
             },
             checkboxGhostButton: DSButtonViewModel(
                 title: "See more",
                 icon: nil,
                 onClick: seemoreAction
             ),
             primaryButton: DSButtonViewModel(
                 title: "Primary",
                 icon: nil,
                 onClick: primaryButtonOnPress
             ),
             ghostButton: nil
         )
     )
 
     // Disable primary button on Sticky Button/ Special + Checkbox
     stickyButton.primaryButton.isUserInteractionEnabled = false
 
     // Example: Sticky Button/ Special + Message
     stickyButton.setup(
         style: .message(
             titleText: "Label",
             descriptionText: "Description",
             helperText: "Helping text (required)",
             primaryButton: DSButtonViewModel(
                 title: "Primary",
                 icon: nil,
                 onClick: primaryButtonOnPress
             ),
             ghostButton: DSButtonViewModel(
                 title: "Ghost",
                 icon: nil,
                 onClick: ghostButtonOnPress
             )
         )
     )
            
     // Example: Sticky Button/ Special + List + Expand
     stickyButton.setup(
         style: .listExpand(
             labeltext: "LabelText",
             valueText: "Value",
             iconImage: DSIcons.icon24OutlinePlaceholder,
             iconAction: { isExpand in
                 print("5555 lol")
             },
             primaryButton: DSButtonViewModel(
                 title: "Primary",
                 icon: nil,
                 onClick: primaryButtonOnPress
             ),
             ghostButton: DSButtonViewModel(
                 title: "Ghost",
                 icon: nil,
                 onClick: ghostButtonOnPress
             )
         )
     )
 
     // Example: Stick Button/ General Secondary Horizontal
     stickyButton.setup(
         style: .secondaryHorizontal(
             primaryButton: DSButtonViewModel(
                 title: "Primary",
                 icon: nil,
                 onClick: primaryButtonOnPress
             ),
             secondaryButton: DSButtonViewModel(
                 title: "Secondary",
                 icon: nil,
                 onClick: {
                     print("secondary pressed")
                 }
             )
         )
     )
 
     // Example: Stick Button/ General Ghost Horizontal
     stickyButton.setup(
         style: .ghostHorizontal(
             primaryButton: DSButtonViewModel(
                 title: "Primary",
                 icon: nil,
                 onClick: primaryButtonOnPress),
             ghostButton: DSButtonViewModel(
                 title: "Ghost",
                 icon: nil,
                 onClick: {
                     print("ghost button pressed")
                     
                 }
             )
         )
     )
 
     // Example: sticky Button/ Special + Radio
     stickyButton.setup(
         style: .radio(
             leftRadioText: "Accept",
             leftRadioIsSelected: false,
             leftRadioAction: { self.enablePrimaryButton() },
             rightRadioText: "Decline",
             rightRadioIsSelected: false,
             rightRadioAction: { self.enablePrimaryButton() },
             primaryButton: DSButtonViewModel(
                 title: "Next",
                 icon: nil,
                 onClick: { print("Next button pressed") }
             ),
             primaryButtonIsEnable: false
         )
     )
    
            
     ```
 How to setup shadow. Default is true, which means shadow is shown.
     ```
        stickyButton.setShadow(isShowShadow: false)
     ```
 
 There are currently 7 styles of DSStickyButton.
 - default
 - checkbox
 - message
 - listExpand
 - secondaryHorizontal
 - ghostHorizontal
 - radio
 
 How to  DSStickyButtonView - radio style
 Parameter | Type + Information
 --- | ---
 `leftRadioText` | `String`  title label of left radio selection never be nil.
 `leftRadioIsSelected` | `Bool`  If true, the left radio selection will be slected. Default value is false.
 `leftRadioAction` | `ActionHandler` action when the left radio selection is selcted.
 `rightRadioText` | `String` title label of right radio selection never be nil.
 `rightRadioIsSelected` | `Bool` If true, the left radio selection will be slected. Default value is false.
 `rightRadioAction` | `ActionHandler` action when the right radio selection is selcted.
 `primaryButton` | `DSButtonViewModel` view model to setup the primary button.
 `primaryButtonIsEnable` | `Bool` If true, the primary button will be enable. Default value is false, disable buttton.
 ```
     stickyButton.setup(
         style: .radio(
             leftRadioText: "Accept",
             leftRadioIsSelected: false,
             leftRadioAction: { self.enablePrimaryButton() },
             rightRadioText: "Decline",
             rightRadioIsSelected: false,
             rightRadioAction: { self.enablePrimaryButton() },
             primaryButton: DSButtonViewModel(
                 title: "Next",
                 icon: nil,
                 onClick: { print("Next button pressed") }
             ),
             primaryButtonIsEnable: false
         )
     )
 ```
 
How to use DSButtonViewModel to setup button on DSStickyButtonView
Parameter | Type + Information
--- | ---
`title` | `String` title label of the button never be empty (mandatory).
`icon` | `DSIcons`  Label of list message never be nil.
`onClick` | `Closure` action when the button be pressed on.
```
    public struct DSButtonViewModel {
        var title: String
        var icon: DSIcons?
        var onClick: () -> Void = {}
    }
```
 */

public final class DSStickyButtonView: UIView {
    @IBOutlet public weak var ghostButton: DSGhostButton!
    @IBOutlet public weak var primaryButton: DSPrimaryButton!
    @IBOutlet public weak var checkboxView: DSCheckboxView!
    @IBOutlet weak var radioView: RadioStickyButtonView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var messageView: MessageStickyButtonView!
    @IBOutlet weak var listExpandView: ListExpandView!
    @IBOutlet weak var horizontalStickyButtonView: HorizontalStickyButtonView!
    // callback action
    private var primaryActionHandler: ActionHandler?
    private var ghostActionHandler: ActionHandler?
    private var checkboxGhostButtonActionHandler: ActionHandler?
    private var currentStyle: DSStickyButtonStyle?
    private var iconAction: ActionHandler?
    private var leftRadioAction: ActionHandler?
    private var rightRadioAction: ActionHandler?
    
    /// isPrimaryButtonEnable set for enable right button on style horizontal and top button on style vertical
    public var isPrimaryButtonEnable: Bool = true {
        didSet {
            primaryButton.isUserInteractionEnabled = isPrimaryButtonEnable
            horizontalStickyButtonView.primaryButton.isUserInteractionEnabled = isPrimaryButtonEnable
        }
    }
    
    /// isSecondaryButtonEnable set for enable left button on style horizontal and bottom button on style vertical
    public var isSecondaryButtonEnable: Bool = true {
        didSet {
            horizontalStickyButtonView.secondaryButton.isUserInteractionEnabled = isSecondaryButtonEnable
            horizontalStickyButtonView.ghostButton.isUserInteractionEnabled = isSecondaryButtonEnable
            ghostButton.isUserInteractionEnabled = isSecondaryButtonEnable
        }
    }
    
    /// Set and show text for helpter text error (text red line)
    public var helperText: String = "" {
        didSet {
            switch currentStyle {
            case .message:
                messageView.helperText.isHidden = helperText == "" ? true : false
                messageView.helperText.isError = true
                messageView.helperText.text = helperText
            default: break
            }
        }
    }
    
    /// Set icon image for content list expand type.
    public var iconImage: DSIcons = .icon24OutlinePlaceholder {
        didSet {
            switch currentStyle {
            case .listExpand:
                listExpandView.iconImage = iconImage
            default: break
            }
        }
    }
    
    /// Set value text (text that on right of sticky button type list expand).
    public var valueText: String = "" {
        didSet {
            switch currentStyle {
            case .listExpand:
                listExpandView.textRightLabel.text = valueText
            default: break
            }
        }
    }
    
    /// Set flag isExpanded.
    public var isExpanded: Bool {
        get {
            listExpandView.isExpanded
        } set {
            listExpandView.isExpanded = newValue
        }
    }

    /// Set expand icon image.
    public var expandIconImage: DSIcons = .icon24OutlinePlaceholder {
        didSet {
            listExpandView.iconImage = expandIconImage
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
    
    public func setup(style: DSStickyButtonStyle) {
        currentStyle = style
        baseView.dsShadowDrop(isHidden: false, style: .top)
        switch style {
        case .vertical(let primaryBtn, let ghostBtn):
            handleVerticalButton(primaryBtn: primaryBtn, ghostBtn: ghostBtn, checkboxGhostBtn: nil)
        case .checkbox(let checkBoxText, let checkBoxAction, let checkboxGhostBtn, let primaryBtn, let ghostBtn):
            handleVerticalButton(primaryBtn: primaryBtn, ghostBtn: ghostBtn, checkboxGhostBtn: checkboxGhostBtn)
            checkboxView.isHidden = false
            checkboxView.delegate = self
            checkboxView.setup(type: .default,
                               theme: .light,
                               tagId: 1,
                               titleText: checkBoxText,
                               state: .default,
                               action: checkBoxAction,
                               hasGhostButton: (checkboxGhostBtn.isNull ? false : true),
                               ghostButtonLabel: checkboxGhostBtn?.title ?? "")
        case .message(let titleText, let descriptionText, let helperText, let primaryBtn, let ghostBtn):
            handleVerticalButton(primaryBtn: primaryBtn, ghostBtn: ghostBtn, checkboxGhostBtn: nil)
            messageView.isHidden = false
            messageView.titleLabel.text = titleText
            messageView.descriptionLabel.text = descriptionText
            if let text = helperText {
                messageView.helperText.text = text
            } else {
                messageView.helperText.isHidden = true
            }
        case .listExpand(let labeltext, let valueText, let iconImage, let iconAction, let primaryBtn, let ghostBtn, let valueSize):
            handleVerticalButton(primaryBtn: primaryBtn, ghostBtn: ghostBtn, checkboxGhostBtn: nil)
            listExpandView.isHidden = false
            listExpandView.textLeftLabel.text = labeltext
            listExpandView.textRightLabel.text = valueText
            listExpandView.textRightLabel.font = valueSize.size
            
            if let image = iconImage {
                listExpandView.iconImage = image
            } else {
                listExpandView.imageContainerView.isHidden = true
            }
            listExpandView.expandAction = iconAction
        case .secondaryHorizontal(let primaryBtn, let secondaryBtn):
            horizontalStickyButtonView.setup(
                style: .scondary(
                    secondaryButtonText: secondaryBtn.title,
                    secondaryButtonAction: secondaryBtn.onClick),
                primaryButtonText: primaryBtn.title,
                primaryButtonAction: primaryBtn.onClick
            )
            primaryButton.isHidden = true
            ghostButton.isHidden = true
            horizontalStickyButtonView.isHidden = false
        case .ghostHorizontal(let primaryBtn, let ghostBtn):
            horizontalStickyButtonView.setup(
                style: .ghost(
                    ghostButtonText: ghostBtn.title,
                    ghostButtonAction: ghostBtn.onClick),
                primaryButtonText: primaryBtn.title,
                primaryButtonAction: primaryBtn.onClick)
            primaryButton.isHidden = true
            ghostButton.isHidden = true
            horizontalStickyButtonView.isHidden = false
        case .radio(let leftRadioText,
                    let leftRadioIsSelected,
                    let leftRadioAction,
                    let rightRadioText,
                    let rightRadioIsSelected,
                    let rightRadioAction,
                    let primaryBtn,
                    let primaryBtnIsEnable):
            handleVerticalButton(primaryBtn: primaryBtn, ghostBtn: nil, checkboxGhostBtn: nil)
            radioView.isHidden = false
            radioView.setup(leftRadioText: leftRadioText,
                            leftRadioIsSelected: leftRadioIsSelected,
                            leftRadioAction: leftRadioAction,
                            rightRadioText: rightRadioText,
                            rightRadioIsSelected: rightRadioIsSelected,
                            rightRadioAction: rightRadioAction)
            primaryButton.isUserInteractionEnabled = primaryBtnIsEnable
        }
    }
    
    public func setShadow(isShowShadow: Bool = true) {
        baseView.dsShadowDrop(isHidden: !isShowShadow, style: .top)
    }

    public func setShadowWithScrollView(scrollView: UIScrollView) {
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        DispatchQueue.main.async { [weak self] in
            let canScrollVertically = scrollView.contentSize.height > scrollView.frame.height
            self?.setShadow(isShowShadow: canScrollVertically)
        }
    }
    
    public func setAccessibilityIdentifier(style: DSStickyButtonStyleAccessibilityIdentifier,
                                           id: String? = nil) {
        self.accessibilityIdentifier = id
        switch style {
        case .vertical(let primaryButtonId,
                       let primaryButtonLabelId,
                       let ghostButtonId,
                       let ghostButtonLabelId):
            self.primaryButton.setAccessibilityIdentifier(id: primaryButtonId,
                                                          titleLabelId: primaryButtonLabelId)
            self.ghostButton.setAccessibilityIdentifier(id: ghostButtonId,
                                                        titleLabelId: ghostButtonLabelId)
        case .ghostHorizontal(let primaryButtonId,
                              let primaryButtonLabelId,
                              let ghostButtonId,
                              let ghostButtonLabelId):
            self.horizontalStickyButtonView.primaryButton.setAccessibilityIdentifier(
                id: primaryButtonId, titleLabelId: primaryButtonLabelId)
            self.horizontalStickyButtonView.ghostButton.setAccessibilityIdentifier(
                id: ghostButtonId, titleLabelId: ghostButtonLabelId)
        case .secondaryHorizontal(let primaryButtonId,
                                  let primaryButtonLabelId,
                                  let secondaryButtonId,
                                  let secondaryButtonLabelId):
            self.horizontalStickyButtonView.primaryButton.setAccessibilityIdentifier(
                id: primaryButtonId, titleLabelId: primaryButtonLabelId)
            self.horizontalStickyButtonView.secondaryButton.setAccessibilityIdentifier(
                id: secondaryButtonId, titleLabelId: secondaryButtonLabelId)
        case .checkbox(let checkboxId,
                       let primaryButtonId,
                       let primaryButtonLabelId,
                       let ghostButtonId,
                       let ghostButtonLabelId):
            self.checkboxView.accessibilityIdentifier = checkboxId
            self.primaryButton.setAccessibilityIdentifier(id: primaryButtonId,
                                                          titleLabelId: primaryButtonLabelId)
            self.ghostButton.setAccessibilityIdentifier(id: ghostButtonId,
                                                        titleLabelId: ghostButtonLabelId)
        case .message(let titleTextId,
                      let descriptionTextId,
                      let helperTextId,
                      let primaryButtonId,
                      let primaryButtonLabelId,
                      let ghostButtonId,
                      let ghostButtonLabelId):
            self.messageView.titleLabel.accessibilityIdentifier = titleTextId
            self.messageView.descriptionLabel.accessibilityIdentifier = descriptionTextId
            self.messageView.helperText.accessibilityIdentifier = helperTextId
            self.primaryButton.setAccessibilityIdentifier(id: primaryButtonId,
                                                          titleLabelId: primaryButtonLabelId)
            self.ghostButton.setAccessibilityIdentifier(id: ghostButtonId,
                                                        titleLabelId: ghostButtonLabelId)
        case .listExpand(let labeltextId,
                         let valueTextId,
                         let iconImageId,
                         let primaryButtonId,
                         let primaryButtonLabelId,
                         let ghostButtonId,
                         let ghostButtonLabelId):
            self.listExpandView.textLeftLabel.accessibilityIdentifier = labeltextId
            self.listExpandView.textRightLabel.accessibilityIdentifier = valueTextId
            self.listExpandView.iconImage.image.accessibilityIdentifier = iconImageId
            self.primaryButton.setAccessibilityIdentifier(id: primaryButtonId,
                                                          titleLabelId: primaryButtonLabelId)
            self.ghostButton.setAccessibilityIdentifier(id: ghostButtonId,
                                                        titleLabelId: ghostButtonLabelId)
        case .radio(let leftRadioId,
                    let rightRadioId,
                    let primaryButtonId,
                    let primaryButtonLabelId):
            self.radioView.leftRadioView.accessibilityIdentifier = leftRadioId
            self.radioView.rightRadioView.accessibilityIdentifier = rightRadioId
            self.primaryButton.setAccessibilityIdentifier(id: primaryButtonId,
                                                          titleLabelId: primaryButtonLabelId)
        }
    }
}

// MARK: - Action
extension DSStickyButtonView {
    @objc func didTapPrimaryButton(_ sender: UITapGestureRecognizer) {
        primaryActionHandler?()
    }
    
    @objc func didTapkGhostButton(_ sender: UITapGestureRecognizer) {
        ghostActionHandler?()
    }
}

extension DSStickyButtonView: DSSelectionCheckboxDelegate {
    public func onTapGhostButton(_ tagId: Int) {
        checkboxGhostButtonActionHandler?()
    }
}

// MARK: - Private
private extension DSStickyButtonView {
    func commonInit() {
        setupXib(xibName: "DSStickyButtonView")
        setupUI()
        setupGesture()
    }
    
    func handleVerticalButton(primaryBtn: DSButtonViewModel, ghostBtn: DSButtonViewModel?, checkboxGhostBtn: DSButtonViewModel?) {
        if let ghostBtn = ghostBtn {
            ghostButton.isHidden = false
            ghostButton.largeGhostText(text: ghostBtn.title)
            ghostActionHandler = ghostBtn.onClick
        } else {
            ghostButton.isHidden = true
        }
        primaryButton.largePrimaryText(text: primaryBtn.title)
        primaryActionHandler = primaryBtn.onClick
        
        checkboxGhostButtonActionHandler = checkboxGhostBtn?.onClick
    }

    func setupUI() {
        checkboxView.isHidden = true
        messageView.isHidden = true
        listExpandView.isHidden = true
        horizontalStickyButtonView.isHidden = true
        radioView.isHidden = true
    }
    
    func setupGesture() {
        let tapGesturePrimary = UITapGestureRecognizer(target: self, action: #selector(didTapPrimaryButton(_:)))
        primaryButton.addGestureRecognizer(tapGesturePrimary)
        
        let tapGestureGhost = UITapGestureRecognizer(target: self, action: #selector(didTapkGhostButton(_:)))
        ghostButton.addGestureRecognizer(tapGestureGhost)
    }
}
