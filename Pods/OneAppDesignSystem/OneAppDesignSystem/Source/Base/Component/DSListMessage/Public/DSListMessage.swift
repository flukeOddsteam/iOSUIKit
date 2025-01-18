//
//  DSListMessage.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/9/2565 BE.
//

import UIKit

public enum DSListMessageType {
    case large(viewModel: DSListMessageViewModel,
               iconAction: () -> Void = {})
    case small(viewModel: DSListMessageViewModel,
               iconAction: () -> Void = {})
    case largeExpandable(viewModel: DSListMessageExpandableViewModel,
                         tabAction: ((Bool) -> Void)? = nil)
}

public enum DSListMessageTypeAccessibilityIdentifier {
    case large(labelId: String,
               valueId: String,
               iconPosition: DSListMessageIconPosition?,
               clickableIconId: String = "")
    case small(labelId: String,
               valueId: String,
               iconPosition: DSListMessageIconPosition?,
               clickableIconId: String = "")
    case largeExpandable(labelId: String,
                         valueId: String,
                         descriptionLabelId: String = "",
                         descriptionValueId: String = "",
                         prefixPillId: String = "",
                         prefixPillLabelId: String = "",
                         isExpandable: ListMessageIsExpandable? = nil)
}

public enum ListMessageIsExpandable: Equatable {
    case expandable(iconExpandImageViewId: String,
                    prefixLabelId: String,
                    prefixValueId: String,
                    rightButtonId: String,
                    rightButtonTitleLabelId: String,
                    leftButtonId: String,
                    leftButtonTitleLabelId: String)
}

public enum DSListMessageStyle {
    case horizontal
    case vertical
}

public enum DSListMessageIconPosition {
    case label
    case value
}

/**
 Custom component DSListMessage

 **List/Message/Large**
 
 ![image](/DocumentationImages/ds-list-message-large.png)

 **List/Message/Small**
 
 ![image](/DocumentationImages/ds-list-message-small.png)

 **List/Message/Large Expandable Label + Desc + Expand**
 
 ![image](/DocumentationImages/ds-list-message-large-shortdesc-expand.png)

 **List/Message/Large Expandable Label + Desc + Status Pill + Tag Pill**
 
 ![image](/DocumentationImages/ds-list-message-large-expandable-shortlabel-desc-pill.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSListMessage` class to the UIView
 2. Binding constraint and don't set `width` and `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
 
 For example: Not sending iconPosition parameter, List message will hide icon.
  ```
 @IBOutlet weak var listMessage: DSListMessage!
  
 
  override func viewDidLoad() {
     super.viewDidLoad()
           
     // Example: Message list small
     let smallViewModel = DSListMessageViewModel(style: .horizontal,
                                                 label: "Label",
                                                 value: "Value")
     listMessage.setup(type: .small(viewModel: smallViewModel))
 
    // Example: Message list large
    let largeViewModel = DSListMessageViewModel(style: .horizontal,
                                                label: "Label",
                                                value: "Value")
    listMessage.setup(type: .large(viewModel: smallViewModel))
        
    // Example: Message list Exapanable
    let exapanViewModel = DSListMessageExpandableViewModel(
        canExpand: true,
        label: "Short Label",
        value: "Value 1 Line",
        labelDesc: "Desc(Optional)",
        valueDesc: "Desc(Optional)",
        contentList: contentList,
        leftButton: seemoreButton,
        rightButton: editButton
    )
    listMessage.setup(
        type: .largeExpandable(
            viewModel: exapanViewModel,
            tabAction: expandAction
        )
    )
  ```
  Set  color for bottom boder:
  ```
  bottomBorder.backgroundColor = .componentDividerBackgroundSmall
  ```
 
  Setting the value of this property to true hides bottomBorder and setting it to false shows bottomBorder. The default value is false.
  ```
  bottomBorder.isHidden = false
  ```
 
  How to use DSListMessageViewModel
  Parameter | Type + Information
  --- | ---
  `style` | `DSListMessageStyle` Style of list message.
  `label` | `String`  Label of list message never be nil.
  `value` | `String` Value of list message never be nil.
  `iconPosition` | `DSListMessageIconPosition?` Position of icon in list message if   nill will hide the icon. (optional).
  `error` | `String?` Error message of list message. support for only large type. (optional).
  `valueError` | `String?` Error message related to the value (optional).
  `labelStyle` | `DSListMessageLabelStyle` Style for the label text.
  `valueStyle` | `DSListMessageValueStyle` Style font for the value text.
  `valueColor` | `DSListMessageValueColor` Style color for the value text.
  ```
  public struct DSListMessageViewModel {
     let style: DSListMessageStyle
     let label: String
     let value: String
     var iconPosition: DSListMessageIconPosition?
     let error: String?
     let valueError: String?
     let labelStyle: DSListMessageLabelStyle
     let valueStyle: DSListMessageValueStyle
     let valueColor: DSListMessageValueColor
  }
  ```
 
 How to use DSListMessageExpandableViewModel
  Parameter | Type + Information
  --- | ---
  `canExpand` | `Bool` Indicate the list message can be expanded or not.
  `label` | `String`  Label of list message never be nil.
  `value` | `String` Value of list message never be nil.
  `isExpand` | `Bool` Default is false for visibel of expan list.
  `labelDesc` | `String`  LabelDesc of list message can be nil.
  `valueDesc` | `String`  LabelDesc of list message can be nil.
  `contentList` | `[DSMessageListModel]?`  Datasource of expanable list.
  `leftButton` | `DSButtonViewModel?`  LeftButton of expanable list require action and title.
  `rightButton` | `DSButtonViewModel?`  RightButton of expanable list require action and title.
  `pill` | `DSCollectionPillViewModel?` Pill viewmodel.
 ```
 public struct DSListMessageExpandableViewModel {
     var canExpand: Bool
     var label: String
     var value: String
     var isExpand: Bool = false
     var labelDesc: String?
     var valueDesc: String?
     var contentList: [DSMessageListModel] = []
     var leftButton: DSButtonViewModel?
     var rightButton: DSButtonViewModel?
     var pill: DSCollectionPillViewModel?
 }
 ```
 */
public final class DSListMessage: UIView {
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelButton: DSClickableIconBadge!
    @IBOutlet weak var valueView: UIView!
    @IBOutlet weak var valueText: UILabel!
    @IBOutlet weak var valueButton: DSClickableIconBadge!
    @IBOutlet weak var valueHelperTextContainer: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var helperTextView: DSHelperTextView!
    @IBOutlet weak var valueHelperText: DSHelperTextView!
    @IBOutlet weak var valueStackView: UIStackView!
    @IBOutlet weak var valueContentStackView: UIStackView!
    @IBOutlet public weak var bottomBorder: UIView!
    @IBOutlet weak var topPaddingStackView: NSLayoutConstraint!
    @IBOutlet weak var bottomPaddingStackView: NSLayoutConstraint!
    @IBOutlet weak var topPaddingLabel: NSLayoutConstraint!
    @IBOutlet weak var bottomPaddingLabel: NSLayoutConstraint!
    @IBOutlet weak var topPaddingValue: NSLayoutConstraint!
    @IBOutlet weak var bottomPaddingValue: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionValue: UILabel!
    @IBOutlet weak var widthValueButton: NSLayoutConstraint!
    @IBOutlet weak var heightValueButton: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabelView: UIView!
    @IBOutlet weak var descriptionValueView: UIView!
    @IBOutlet weak var iconExpandImageView: UIImageView!
    @IBOutlet weak var iconExpandView: UIView!
    @IBOutlet weak var widthValueView: NSLayoutConstraint!
    @IBOutlet weak var pillContentView: DSMessageContentPillView!
    
    @IBOutlet weak var topStack: UIStackView!
    // Expand
    private var expandAction: ((Bool) -> Void)?
    @IBOutlet private weak var expanParentView: UIView!
    @IBOutlet private weak var expandView: DSMessageContentListView!
    @IBOutlet private weak var widthRatio: NSLayoutConstraint!
    @IBOutlet weak var containerPillView: UIView!
    
    @IBOutlet weak var helperTextContainerView: UIView!
    // MARK: - Private properties
    private var iconAction: () -> Void = {}
    
    // Variables to set accessibility identifier
    private var prefixPillId: String = ""
    private var prefixPillLabelId: String = ""
    private var prefixLabelExpanableContentListId: String = ""
    private var prefixValueExpanableContentListId: String = ""
    private var rightButtonExpanableId: String = ""
    private var rightButtonTitleLabelId: String = ""
    private var leftButtonExpanableId: String = ""
    private var leftButtonTitleLabelId: String = ""
    
    // MARK: - Public properties
    public var type: DSListMessageType?
    
    /// support short style only (DSListMessageExpandableStyle)
    /**
    
    Example:
    ```
    ratio = 50/50 or 70/30
    */
    public var ratio: CGFloat = 1 {
        didSet {
            widthRatio = widthRatio.setMultiplier(multiplier: ratio)
        }
    }
    public var isExpanded: Bool = false {
        didSet {
            expandView.isHidden = !isExpanded
            iconExpandImageView.image = isExpanded ? DSIcons.icon24OutlineChevronUp.image : DSIcons.icon24OutlineChevronDown.image
            expandAction?(isExpanded)
        }
    }
    
    /// Variable  for update style`textColor` and `font` of `labelText`.  default is `.regular`
    public var labelStyle: DSListMessageLabelStyle = .regular {
        didSet {
            updateLabelStyle()
        }
    }
    
    /// Variable  for update style `font` of `valueText`.  default is `.regular`
    public var valueStyle: DSListMessageValueStyle = .regular {
        didSet {
            updateValueStyle()
        }
    }
    
    /// Variable  for update style`textColor` ` of `valueText`.  default is `.navy`
    public var valueColor: DSListMessageValueColor = .navy {
        didSet {
            updateValueColor()
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Parameter | Type + Information
    /// --- | ---
    /// `type` | `DSListMessageType` Type of list message.
    public func setup(type: DSListMessageType) {
        setType(type: type)
        self.type = type
    }

    public func setBottomBorder(visible isVisible: Bool) {
        bottomBorder.isHidden = !isVisible
    }

    public func setAccessibilityIdentifier(id: String, type: DSListMessageTypeAccessibilityIdentifier) {
        self.accessibilityIdentifier = id
        
        switch type {
        case .large(let labelId, let valueId, let iconPosition, let clickableIconId):
            self.labelText.accessibilityIdentifier = labelId
            self.valueText.accessibilityIdentifier = valueId
            switch iconPosition {
            case .label:
                self.labelButton.setAccessibilityIdentifier(id: clickableIconId)
            case .value:
                self.valueButton.setAccessibilityIdentifier(id: clickableIconId)
            case .none:
                break
            }
        case .small(let labelId, let valueId, let iconPosition, let clickableIconId):
            self.labelText.accessibilityIdentifier = labelId
            self.valueText.accessibilityIdentifier = valueId
            switch iconPosition {
            case .label:
                self.labelButton.setAccessibilityIdentifier(id: clickableIconId)
            case .value:
                self.valueButton.setAccessibilityIdentifier(id: clickableIconId)
            case .none:
                break
            }
        case .largeExpandable(let labelId,
                              let valueId,
                              let descriptionLabelId,
                              let descriptionValueId,
                              let prefixPillId,
                              let prefixPillLabelId,
                              let isExpandable):
            self.labelText.accessibilityIdentifier = labelId
            self.valueText.accessibilityIdentifier = valueId
            self.descriptionLabel.accessibilityIdentifier = descriptionLabelId
            self.descriptionValue.accessibilityIdentifier = descriptionValueId
            self.prefixPillId = prefixPillId
            self.prefixPillLabelId = prefixPillLabelId
            switch isExpandable {
            case .expandable(let iconExpandImageViewId,
                             let prefixLabelId,
                             let prefixValueId,
                             let rightButtonId,
                             let rightButtonTitleLabelId,
                             let leftButtonId,
                             let lefttButtonTitleLabelId):
                self.iconExpandView.accessibilityIdentifier = iconExpandImageViewId
                self.prefixLabelExpanableContentListId = prefixLabelId
                self.prefixValueExpanableContentListId = prefixValueId
                self.rightButtonExpanableId = rightButtonId
                self.rightButtonTitleLabelId = rightButtonTitleLabelId
                self.leftButtonExpanableId = leftButtonId
                self.leftButtonTitleLabelId = lefttButtonTitleLabelId
            case .none:
                break
            }
        }
    }
}

// MARK: - Action
extension DSListMessage {
    @IBAction func labelButtonTapped(_ sender: Any) {
        iconAction()
    }
    @IBAction func valueButtonTapped(_ sender: Any) {
        iconAction()
    }
}

// MARK: - Private
private extension DSListMessage {
    
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        bottomBorder.backgroundColor = DSColor.componentDividerBackgroundSmall
        expanParentView.isHidden = true
        descriptionLabel.font = DSFont.labelInput
        descriptionLabel.textColor = DSColor.componentLightDesc
        descriptionLabelView.isHidden = true
        descriptionValue.font = DSFont.labelInput
        descriptionValue.textColor = DSColor.componentLightDesc
        descriptionValueView.isHidden = true
        iconExpandView.isHidden = true
        iconExpandImageView.image = DSIcons.icon24OutlineChevronDown.image
        iconExpandImageView.tintAdjustmentMode = .normal
        containerPillView.isHidden = true
        pillContentView.isHidden = true
        valueHelperText.isHidden = true
    }

    func setIcon(position: DSListMessageIconPosition?) {
        if let position = position {
            switch position {
            case .label:
                labelButton.isHidden = false
                valueButton.isHidden = true
                labelButton.setup(style: .normal, image: DSIcons.icon24OutlineInfo.image)
            case .value:
                labelButton.isHidden = true
                valueButton.isHidden = false
                valueButton.setup(style: .normal, image: DSIcons.icon24OutlineInfo.image)
            }
        } else {
            labelButton.isHidden = true
            valueButton.isHidden = true
        }
    }
    
    func setType(type: DSListMessageType) {
        switch type {
        case .large(let viewModel, let iconAction):
            labelStyle = viewModel.labelStyle
            valueStyle = viewModel.valueStyle ?? .bold
            valueColor = .navy
            labelText.text = viewModel.label
            valueText.text = viewModel.value
            setStyleLarge(style: viewModel.style)
            setIcon(position: viewModel.iconPosition)
            bottomBorder.isHidden = false
            self.iconAction = iconAction
            helperTextContainerView.isHidden = viewModel.error.isNilOrEmpty
            valueView.isHidden = viewModel.value.isEmpty && viewModel.valueError.isNilOrEmpty

            valueContentStackView.isHidden = viewModel.valueError.isNotNilAndNotEmpty
            iconExpandView.isHidden = true
            valueHelperTextContainer.isHidden = viewModel.valueError.isNilOrEmpty
            valueHelperText.isHidden = viewModel.valueError.isNilOrEmpty
            if let error = viewModel.error {
                helperTextView.setup(textLeft: error, isError: true)
            }

            if let valueError = viewModel.valueError, valueError.isNotEmpty {
                valueHelperText.setup(textLeft: valueError, isError: true)
            }
        case .small(let viewModel, let iconAction):
            labelStyle = viewModel.labelStyle
            valueStyle = viewModel.valueStyle ?? .regular
            valueColor = (valueStyle == .regular || valueStyle == .medium) ? (viewModel.valueColor ?? .navy) : .navy
            labelText.text = viewModel.label
            valueText.text = viewModel.value
            setStyleSmall(style: viewModel.style)
            setIcon(position: viewModel.iconPosition)
            bottomBorder.isHidden = true
            self.iconAction = iconAction
            helperTextContainerView.isHidden = true
            valueView.isHidden = viewModel.value.isEmpty && viewModel.valueError.isNilOrEmpty
            valueContentStackView.isHidden = viewModel.valueError.isNotNilAndNotEmpty
            iconExpandView.isHidden = true
            valueHelperTextContainer.isHidden = viewModel.valueError.isNilOrEmpty
            valueHelperText.isHidden = viewModel.valueError.isNilOrEmpty
            if let valueError = viewModel.valueError {
                valueHelperText.setup(textLeft: valueError, isError: true)
            }
        case .largeExpandable(let viewModel, let tabCallback):
            labelStyle = .regular
            valueStyle = .bold
            valueColor = .navy
            labelText.text = viewModel.label
            valueText.text = viewModel.value
            setDescription(viewModel: viewModel)
            setStyleLargeExpandable(canExpand: viewModel.canExpand)
            expanParentView.isHidden = true
            setIcon(position: nil)
            valueText.font = DSFont.valueList
            expandView.setup(viewModel: viewModel)
            setCollectionPill(viewModel: viewModel.pill)
            expandAction = tabCallback
            expandView.ratio = viewModel.ratio
            helperTextContainerView.isHidden = true
            valueHelperText.isHidden = true
            valueHelperTextContainer.isHidden = true
            if viewModel.isExpand {
                self.isExpanded = viewModel.isExpand
                expandViewAnimate(isAnimate: false)
            }
            expandView.setAccessibilityIdentifier(prefixLabelId: self.prefixLabelExpanableContentListId,
                                                  prefixValueId: self.prefixValueExpanableContentListId,
                                                  rightButtonId: self.rightButtonExpanableId,
                                                  rightButtonLabelId: self.rightButtonTitleLabelId,
                                                  leftButtonId: self.leftButtonExpanableId,
                                                  leftButtonLabelId: self.leftButtonTitleLabelId)
        }
    }
    
    func setDescription(viewModel: DSListMessageExpandableViewModel) {
        if let labelDesc = viewModel.labelDesc {
            descriptionLabelView.isHidden = false
            descriptionLabel.text = labelDesc
        } else {
            descriptionLabelView.isHidden = true
        }
        
        if let valueDesc = viewModel.valueDesc {
            descriptionValueView.isHidden = false
            descriptionValue.text = valueDesc
        } else {
            descriptionValueView.isHidden = true
        }
    }
    
    func setPadding(constraints: [NSLayoutConstraint], value: CGFloat) {
        constraints.forEach {
            $0.constant = value
        }
    }

    func updateLabelStyle() {
        labelText.textColor = labelStyle.textColor
        labelText.font = labelStyle.font
    }
    
    func updateValueStyle() {
        valueText.font = valueStyle.font
    }
    
    func updateValueColor() {
        valueText.textColor = valueColor.textColor
    }
}

// MARK: - Private DSListMessage + Large
private extension DSListMessage {
    func setStyleSmall(style: DSListMessageStyle) {
        switch style {
        case .horizontal:
            stackView.axis = .horizontal
            valueStackView.semanticContentAttribute = .forceRightToLeft
            valueText.textAlignment = .right
            stackView.spacing = 8
            setPadding(constraints: [topPaddingStackView, bottomPaddingStackView], value: 0)
            setPadding(constraints: [topPaddingLabel, bottomPaddingLabel, topPaddingValue, bottomPaddingValue], value: 8)
        case .vertical:
            stackView.axis = .vertical
            valueStackView.semanticContentAttribute = .forceLeftToRight
            valueText.textAlignment = .left
            stackView.spacing = 0
            setPadding(constraints: [topPaddingStackView, bottomPaddingStackView], value: 4)
            setPadding(constraints: [topPaddingLabel, bottomPaddingLabel, topPaddingValue, bottomPaddingValue], value: 4)
        }
    }
}

// MARK: - Private DSListMessage + Large
private extension DSListMessage {
    func setStyleLarge(style: DSListMessageStyle) {
        switch style {
        case .horizontal:
            stackView.axis = .horizontal
            valueStackView.semanticContentAttribute = .forceRightToLeft
            valueText.textAlignment = .right
            stackView.spacing = 8
            setPadding(constraints: [topPaddingStackView, bottomPaddingStackView], value: 8)
            setPadding(constraints: [topPaddingLabel, bottomPaddingLabel, topPaddingValue, bottomPaddingValue], value: 8)
        case .vertical:
            stackView.axis = .vertical
            valueStackView.semanticContentAttribute = .forceLeftToRight
            valueText.textAlignment = .left
            stackView.spacing = 0
            setPadding(constraints: [topPaddingStackView, bottomPaddingStackView], value: 8)
            setPadding(constraints: [topPaddingLabel, bottomPaddingLabel, topPaddingValue, bottomPaddingValue], value: 8)
        }
    }
}

// MARK: - Public DSListMessage + Exapanable
public extension DSListMessage {
    // tab to expand via external.
    func tabViewExpand(isAnimate: Bool = true) {
        isExpanded = !isExpanded
        expandViewAnimate(isAnimate: isAnimate)
    }
}

// MARK: - Private DSListMessage + Exapanable
private extension DSListMessage {
    func setStyleLargeExpandable(canExpand: Bool) {
        stackView.axis = .horizontal
        valueStackView.semanticContentAttribute = .forceRightToLeft
        valueText.textAlignment = .right
        stackView.spacing = 8
        
        if descriptionLabelView.isHidden && descriptionValueView.isHidden {
            setPadding(constraints: [bottomPaddingLabel, bottomPaddingValue], value: 8)
            
        } else {
            setPadding(constraints: [bottomPaddingLabel, bottomPaddingValue], value: 4)}
        
        setPadding(constraints: [topPaddingStackView, bottomPaddingStackView, topPaddingLabel, topPaddingValue], value: 8)

        widthValueView.priority = .defaultLow
        labelButton.isHidden = true
        iconExpandView.isHidden = !canExpand
        if canExpand {
            setupTabView()
        }
    }
    
    func expandViewAnimate(isAnimate: Bool = true) {
        if isAnimate {
            let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { [weak self] in
                guard let self = self else { return }
                self.expanParentView.isHidden = !self.expanParentView.isHidden
                self.topStack.layoutIfNeeded()
            }
            animation.startAnimation()
        } else {
            self.expanParentView.isHidden = !self.expanParentView.isHidden
            self.topStack.layoutIfNeeded()
        }
        
        if !expanParentView.isHidden {
            bottomPaddingStackView.constant = 0
        } else {
            bottomPaddingStackView.constant = 8
        }
    }
    
    // in case UITapGestureRecognizer for Expand only
    func setupTabView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        stackView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        tabViewExpand()
    }
}

// MARK: - Private Method Collection Pill.
private extension DSListMessage {
    func setCollectionPill(viewModel: DSCollectionPillViewModel?) {
        if let viewModel = viewModel {
            pillContentView.setup(viewModel: getCollectionPillViewModel(by: viewModel))
            pillContentView.setupAccessibilityIdentifier(prefixPillId: self.prefixPillId,
                                                         prefixPillLabelId: self.prefixPillLabelId)
            pillContentView.isHidden = false
            containerPillView.isHidden = false
        } else {
            containerPillView.isHidden = true
            pillContentView.isHidden = true
        }
    }
    
    func getCollectionPillViewModel(by data: DSCollectionPillViewModel) -> [DSMessageContentPillViewModel] {
        var contentTagViewModel: [DSMessageContentPillViewModel] = []
        
        if let pillStatus = data.status {
            let contentTagStatus: DSMessageContentPillViewModel = DSMessageContentPillViewModel(style: .status(pillStatus.style), title: pillStatus.title)
            contentTagViewModel.append(contentTagStatus)
        }
        
        let contentTag: [DSMessageContentPillViewModel] = data.tag?.map { DSMessageContentPillViewModel(style: .tag, title: $0) } ?? []
        contentTagViewModel.append(contentsOf: contentTag)
        
        return contentTagViewModel
    }
}
