//
//  DSRadioCardView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/11/2565 BE.
//

import UIKit

private enum Constants {
    static let numberOfLine: Int = 0
}

/// Delegate for DSRadioCardView
public protocol DSSelectionRadioCardDelegate: AnyObject {
    /// Tell the delegate  of DSRadioCardView when small ghost button is checked
    func onTapGhostButton(_ tagId: Int)
}
    
/**
 Custom component DSRadioCardView for Design System
 
 ![image](/DocumentationImages/ds-selection-radio-card.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSRadioCardView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
        @IBOutlet weak var radioCard1: DSRadioCardView!
         
        override func viewDidLoad() {
            super.viewDidLoad()
        // Case: Radio / Card Message List + Action
        let vm1 = DSRadioCardViewModel(tagId: 001,
                                   label: "Label",
                                   value: "Value",
                                   labelDesc: "Desc(Optional)",
                                   cardButton: seemoreButton,
                                   pill: pillDefault,
                                   enableExpanded: false)
     ```
 
    Set label and set state as default for DSRadioCardView:
    Set action as whatever you want it to do when DSRadioCardView is  tapped on:
     ```
         radioCard1.setup(viewModel: vm1,
                             state: .default,
                             action: { [unowned self] state in
             debugPrint("viewId: \(radioCard1.tagId), value: \(radioCard1.cardValue), index: \(radioCard1.pillSelectionIndex ?? 0)")
         })
     ```
 */
public final class DSRadioCardView: UIView {

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
    @IBOutlet private weak var radioView: RadioView!
    @IBOutlet private weak var selectionView: UIView!
    @IBOutlet private weak var expandView: DSSelectionOfExpandView!
    @IBOutlet private weak var cardButtonView: UIView!
    @IBOutlet private weak var cardButton: DSGhostButton!
    @IBOutlet private weak var containerPillView: UIView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var pillContentView: DSMessageContentPillView!
    
    // MARK: - Private variable
    private var ghostAction: (() -> Void)?
    private var viewModel: DSRadioCardViewModel?

    // Expand
    private var expandAction: ((Bool) -> Void)?
    private var isCanExpand: Bool = false

    // MARK: - Public
    
    /// Variable for show / not show  the seeMore button
    public var enableExpanded: Bool = true {
        didSet {
            updateExpandViewAppearance()
        }
    }
    
    public var isExpanded: Bool = false {
        didSet {
            iconImage.image = isExpanded ? DSIcons.icon24OutlineChevronUp.image : DSIcons.icon24OutlineChevronDown.image
            expandAction?(isExpanded)
        }
    }
    public var pillSelectionIndex: Int?
    public var cardValue: String = ""

    /// Delegate of DSRadioCardView
    public weak var delegate: DSSelectionRadioCardDelegate?
    
    /// Variable for setting tag ID of DSRadioCardView
    public var tagId: Int = 0
    
    /// Variable for updating titleText, which is a label of DSRadioCardView
    public var titleText: String = "" {
        didSet {
            updateTitle()
        }
    }
    
    /// Variable for updating state of DSRadioCardView
    public var state: DSSelectionRadioState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    /// Variable for setting action of DSRadioCardView
    public var action: DSSelectionRadioCardAction?
    
    /// For setup DSRadioCardView
    ///
    /// Parameter for setup DSRadioCardView
    /// - Parameter viewModel: DSRadioCardViewModel to display on DSRadioCardView.
    /// - Parameter state: state of DSRadioCardView.
    /// - Parameter action: action when tap on DSRadioCardView.
    public func setup(viewModel: DSRadioCardViewModel, state: DSSelectionRadioState, action: DSSelectionRadioCardAction? = nil) {
        self.viewModel = viewModel
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
        
        setupGhostButton()

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
            
            if viewModel.enableExpanded {
               setupExpandTab()
            } else {
               self.enableExpanded = false
            }
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
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           titleLabelId: String? = nil,
                                           valueLabelId: String? = nil,
                                           iconImageId: String? = nil,
                                           radioViewId: String? = nil,
                                           descLabelId: String? = nil,
                                           cardButtonId: String? = nil,
                                           cardButtonLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.valueLabel.accessibilityIdentifier = valueLabelId
        self.iconImage.accessibilityIdentifier = iconImageId
        self.radioView.accessibilityIdentifier = radioViewId
        self.descLabel.accessibilityIdentifier = descLabelId
        self.cardButton.setAccessibilityIdentifier(id: cardButtonId,
                                                   titleLabelId: cardButtonLabelId)
    }
}

// MARK: - Action
extension DSRadioCardView {
    @objc func radioCardViewDidTapped(_ sender: Any) {
        guard state.isUserInteractonEnabled else {
            return
        }
        action?(state)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.onTapGhostButton(tagId)
    }
    
    @objc func clickCardButton(_ sender: UITapGestureRecognizer) {
        ghostAction?()
    }
}

// MARK: - Private
private extension DSRadioCardView {
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
        self.radioView?.state = state
        self.layer.cornerRadius = state.radioCardCornerRadius
        containerView.layer.borderWidth = state.radioCardBorderWidth
        containerView.layer.borderColor = state.radioCardBorderColor.cgColor
        containerView.layer.cornerRadius = state.radioCardCornerRadius
        containerView.backgroundColor = state.radioCardBackgroundColor
        containerView.dsShadowDrop(isHidden: !state.radioCardShadowEnabled, style: .bottom)
        expandView.layer.cornerRadius = state.radioCardCornerRadius
        expandView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
     
    func updateTitle() {
        self.titleLabel.text = titleText
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(radioCardViewDidTapped(_:)))
        self.selectionView.addGestureRecognizer(tap)

        let onTapGhostButton = UITapGestureRecognizer(target: self, action: #selector(clickCardButton(_:)))
        self.cardButton.addGestureRecognizer(onTapGhostButton)
    }

    func setupGhostButton() {
        self.cardButtonView.isHidden = viewModel?.ghostButton.isNull ?? true

        guard let viewModel, let button = viewModel.ghostButton else {
            return
        }

        self.ghostAction = button.action

        if let leftIcon = button.leftIcon {
            self.cardButton.smallGhostNoPaddingLeftAndRightIconLeft(text: button.title, icon: leftIcon.image)
        } else if let rightIcon = button.rightIcon {
            self.cardButton.smallGhostNoPaddingLeftAndRightIconRight(text: button.title, icon: rightIcon.image)
        } else {
            self.cardButton.smallGhostTextOnlyNoPadding(text: button.title)
        }
    }

    func updateExpandViewAppearance() {
        self.expandIconView.isHidden = !self.enableExpanded
        self.expandIconView.isUserInteractionEnabled = !self.enableExpanded
        self.isCanExpand = self.enableExpanded
        self.isExpanded = self.enableExpanded
    }
}

// MARK: - Private DSRadioCardView + Exapanable
private extension DSRadioCardView {
    func expandViewAnimate(isAnimate: Bool = true) {
        if isAnimate {
            let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { [weak self] in
                guard let self = self else { return }
                self.expandView.isHidden = !self.expandView.isHidden
                self.expandView.tableView.reloadData()
                self.mainStackView.layoutIfNeeded()
            }
            animation.startAnimation()
        } else {
            self.expandView.isHidden = !self.expandView.isHidden
            self.expandView.tableView.reloadData()
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
private extension DSRadioCardView {
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
extension DSRadioCardView: DSSelectionOfExpandViewDelegate {
    public func didChangeValueOfPill(value: String, index: Int) {
        self.pillSelectionIndex = index
        self.valueLabel.text = value
        cardValue = value
        // If state is checked component must update option value.
        if state == .selected {
            action?(state)
        }
        
        self.expandView.tableView.reloadData()
    }
}
