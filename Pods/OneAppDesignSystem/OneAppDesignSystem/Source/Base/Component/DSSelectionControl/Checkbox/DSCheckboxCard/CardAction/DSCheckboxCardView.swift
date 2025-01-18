//
//  DSCheckboxCardView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/10/2565 BE.
//

import UIKit

private enum Constants {
    static let numberOfLine: Int = 0
}

/// Delegate for DSCheckboxCardView
public protocol DSSelectionCheckboxCardDelegate: AnyObject {
    /// Tell the delegate  of DSCheckbox when small ghost button is checked
    func onTapGhostButton(_ tagId: Int)
}

public enum ExpandType {
    case list(datas: [DSSelectionListModel])
    case option(datas: DSSelectionOfExpandViewModel)
}

public struct DSCheckboxCardExpandViewModel {
    var expandType: ExpandType?
    var button: DSButtonViewModel?
}

/// For setup DSCheckboxCardViewModel
///
/// Parameter for setup DSCheckboxView
/// - Parameter tagId: tag ID of DSCheckboxView.
/// - Parameter label: text to display as label of DSCheckboxView.
/// - Parameter value: text to display as value of DSCheckboxView.
/// - Parameter isShowExpandList: Handle display expandview.
/// - Parameter labelDesc: text to display as labelDesc of DSCheckboxView.
/// - Parameter cardButton: optional button of DSCheckboxView.
/// - Parameter pill: DSCollectionPillViewModel to initial pill in card of DSCheckboxView.
/// - Parameter expandViewModel: expand info card of DSCheckboxView.
public struct DSCheckboxCardViewModel {
    var tagId: Int
    var label: String
    var value: String?
    var isShowExpandList: Bool = false
    var labelDesc: String?
    var cardButton: DSButtonViewModel?
    var pill: DSCollectionPillViewModel?
    var expandViewModel: DSCheckboxCardExpandViewModel?

    public init(tagId: Int, label: String, value: String?, isShowExpandList: Bool = false, labelDesc: String? = nil, expandViewModel: DSCheckboxCardExpandViewModel? = nil, cardButton: DSButtonViewModel? = nil, contentList: [DSMessageListModel] = [], pill: DSCollectionPillViewModel? = nil) {
        self.tagId = tagId
        self.label = label
        self.value = value
        self.isShowExpandList = isShowExpandList
        self.labelDesc = labelDesc
        self.cardButton = cardButton
        self.expandViewModel = expandViewModel
        self.pill = pill
    }
}

public typealias DSSelectionCheckboxCardAction = ((_ currentState: DSSelectionCheckboxState) -> Void)

/**
 Custom component DSCheckboxCardView for Design System
 
 ![image](/DocumentationImages/ds-checkbox-card-view.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSCheckboxCardView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
        @IBOutlet weak var checkboxCard1: DSCheckboxCardView!
         
        override func viewDidLoad() {
            super.viewDidLoad()
        // Case: Checkbox / Card Message List + Action
        let vm1 = DSCheckboxCardViewModel(tagId: 001,
                                   label: "Label",
                                   value: "Value",
                                   labelDesc: "Desc(Optional)",
                                   cardButton: seemoreButton,
                                   pill: pillDefault)
     ```
 
    Set label and set state as default for DSCheckboxCardView:
    Set action as whatever you want it to do when DSCheckboxCardView is  tapped on:
     ```
         checkboxCard1.setup(viewModel: vm1,
                             state: .default,
                             action: { [unowned self] state in
             debugPrint("viewId: \(checkboxCard1.tagId), value: \(checkboxCard1.cardValue), index: \(checkboxCard1.pillSelectionIndex ?? 0)")
         })
     ```
 */
public final class DSCheckboxCardView: UIView {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueView: UIView!
    @IBOutlet private weak var valueLabel: UILabel! {
        didSet {
            cardValue = valueLabel.text ?? ""
        }
    }
    @IBOutlet private weak var iconImageWidth: NSLayoutConstraint!
    @IBOutlet private weak var expandIconView: UIView!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var checkboxView: DSInputCheckBox!
    @IBOutlet private weak var selectionView: UIView!
    @IBOutlet private weak var selectionCheckboxView: UIStackView!
    @IBOutlet private weak var expandView: DSSelectionOfExpandView!
    @IBOutlet private weak var cardButtonView: UIView!
    @IBOutlet private weak var cardButton: DSGhostButton!
    @IBOutlet private weak var containerPillView: UIView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var pillContentView: DSMessageContentPillView!
    
    // MARK: - Private variable
    private var buttonCardAction: () -> Void = {}
    
    // Expand
    private var isCanExpand: Bool = false
    private var expandAction: ((Bool) -> Void)?
    
    // MARK: - Public
    /// Delegate of DSCheckboxCardView
    public weak var delegate: DSSelectionCheckboxDelegate?
    
    public var isExpanded: Bool = false {
        didSet {
            iconImage.image = isExpanded ? DSIcons.icon24OutlineChevronUp.image : DSIcons.icon24OutlineChevronDown.image
            expandAction?(isExpanded)
        }
    }
    
    public var pillSelectionIndex: Int?
    
    public var cardValue: String = ""
    
    /// Variable for setting tag ID of DSCheckboxCardView
    public var tagId: Int = 0
    
    /// Variable for updating titleText, which is a label of DSCheckboxCardView
    public var titleText: String = "" {
        didSet {
            updateTitle()
        }
    }
    
    /// Variable for updating state of DSCheckboxCardView
    public var state: DSSelectionCheckboxState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    /// Variable for setting action of DSCheckboxCardView
    public var action: DSSelectionCheckboxCardAction?
    
    /// For setup DSCheckboxCardView.
    ///
    /// Parameter for setup DSCheckboxCardView.
    /// - Parameter viewModel: DSRadioCardViewModel to display on DSCheckboxCardView.
    /// - Parameter state: state of DSCheckboxCardView.
    /// - Parameter action: action when tap on DSCheckboxCardView.
    public func setup(viewModel: DSCheckboxCardViewModel, state: DSSelectionCheckboxState, action: DSSelectionCheckboxCardAction? = nil) {
        self.tagId = viewModel.tagId
        self.titleLabel.text = viewModel.label
        self.valueLabel.text = viewModel.value
        if let desc = viewModel.labelDesc {
            self.descLabel.text = desc
            self.descLabel.isHidden = false
        } else {
            self.descLabel.isHidden = true
        }
        self.state = state
        self.action = action
        self.setCollectionPill(viewModel: viewModel.pill)
        
        // Button
        if let cardButton = viewModel.cardButton,
           let iconCardButton = cardButton.icon {
            self.cardButton.smallGhostNoPaddingRightIconRight(text: cardButton.title,
                                                              icon: iconCardButton.image)
            buttonCardAction = cardButton.onClick
            
            let ontapGhostButton = UITapGestureRecognizer(target: self, action: #selector(clickCardButton(_:)))
            self.cardButton.addGestureRecognizer(ontapGhostButton)
            self.cardButtonView.isHidden = false
        }
        
        // setup expand
        self.expandIconView.isHidden = viewModel.expandViewModel == nil
        if viewModel.expandViewModel != nil {
            self.expandIconView.isUserInteractionEnabled = true
            self.isCanExpand = viewModel.isShowExpandList
            self.isExpanded = viewModel.isShowExpandList
            if let expandType = viewModel.expandViewModel?.expandType {
                self.expandView.setup(type: expandType, button: viewModel.expandViewModel?.button)
                self.expandView.delegate = self
            }
            
            if viewModel.isShowExpandList {
                expandViewAnimate(isAnimate: false)
            }
            setupExpandTab()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupUI()
        updateAppearance()
        setupGesture()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupUI()
        updateAppearance()
        setupGesture()
    }
    
    public func setAccessibilityIdentifier(id: String,
                                           checkboxId: String,
                                           titleLabelId: String,
                                           valueLabelId: String,
                                           iconImageId: String,
                                           descLabelId: String,
                                           cardButtonId: String,
                                           cardButtonLabelId: String) {
        self.accessibilityIdentifier = id
        self.checkboxView.accessibilityIdentifier = checkboxId
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.valueLabel.accessibilityIdentifier = valueLabelId
        self.iconImage.accessibilityIdentifier = iconImageId
        self.descLabel.accessibilityIdentifier = descLabelId
        self.cardButton.setAccessibilityIdentifier(id: cardButtonId,
                                                   titleLabelId: cardButtonLabelId)
    }

    @objc func clickCardButton(_ sender: UITapGestureRecognizer) {
        buttonCardAction()
    }
}

// MARK: - Action
extension DSCheckboxCardView {
    @objc func checkboxViewDidTapped(_ sender: Any) {
        guard state.isUserInteractonEnabled else {
            return
        }
        if self.state == .checked {
            self.state = .default
        } else if self.state == .default {
            self.state = .checked
        }
        action?(state)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.onTapGhostButton(tagId)
    }
}

// MARK: - Private
private extension DSCheckboxCardView {
    func setupUI() {
        self.titleLabel.font = DSFont.labelList
        self.titleLabel.textColor = DSColor.componentLightDefault
        self.valueLabel.font = DSFont.valueList
        self.valueLabel.textColor = DSColor.componentLightDefault
        self.descLabel.font = DSFont.labelInput
        self.descLabel.textColor = DSColor.componentLightDesc
        self.titleLabel.numberOfLines = Constants.numberOfLine
        iconImage.image = DSIcons.icon24OutlineChevronDown.image
        iconImage.tintAdjustmentMode = .normal

    }
    
    func updateAppearance() {
        self.checkboxView?.state = state
        self.layer.cornerRadius = state.cardCornerRadius
        containerView.layer.borderWidth = state.cardBorderWidth
        containerView.layer.borderColor = state.cardBorderColor.cgColor
        containerView.layer.cornerRadius = state.cardCornerRadius
        containerView.backgroundColor = state.cardBackgroundColor
        containerView.dsShadowDrop(isHidden: !state.cardShadowEnabled, style: .bottom)
        expandView.layer.cornerRadius = state.cardCornerRadius
        expandView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
     
    func updateTitle() {
        self.titleLabel.text = titleText
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(checkboxViewDidTapped(_:)))
       self.selectionView.addGestureRecognizer(tap)
    }
}

// MARK: - Private DSCheckboxCardView + Exapanable
private extension DSCheckboxCardView {
    func expandViewAnimate(isAnimate: Bool = true) {
        if isAnimate {
            let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { [weak self] in
                guard let self = self else { return }
                self.expandView.isHidden = !self.expandView.isHidden
                self.mainStackView.layoutIfNeeded()
            }
            animation.startAnimation()
        } else {
            self.expandView.isHidden = !self.expandView.isHidden
            self.mainStackView.layoutIfNeeded()
        }
    }
    
    // tab to expand via external.
    func tabViewExpand(isAnimate: Bool = true) {
        isExpanded = !isExpanded
        expandViewAnimate(isAnimate: isAnimate)
    }
    
    // in case UITapGestureRecognizer for Expand only
    func setupExpandTab() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleExpandTap(_:)))
        let expanViewTab = UITapGestureRecognizer(target: self, action: #selector(self.handleExpandTap(_:)))
        valueView.addGestureRecognizer(viewTap)
        expandIconView.addGestureRecognizer(expanViewTab)
    }
    
    @objc func handleExpandTap(_ sender: UITapGestureRecognizer? = nil) {
        tabViewExpand()
    }
}

// MARK: - Private Method Collection Pill.
private extension DSCheckboxCardView {
    func setCollectionPill(viewModel: DSCollectionPillViewModel?) {
        if let viewModel = viewModel {
            pillContentView.setup(viewModel: getCollectionPillViewModel(by: viewModel))
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

// MARK: - DSPillRadioDelegate
extension DSCheckboxCardView: DSSelectionOfExpandViewDelegate {
    public func didChangeValueOfPill(value: String, index: Int) {
        self.pillSelectionIndex = index
        self.valueLabel.text = value
        cardValue = value
        // If state is checked component must update option value.
        if state == .checked {
            action?(state)
        }
    }
}
