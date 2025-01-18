//
//  DSCommonPaymentValueRadioView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/11/2567 BE.
//

import UIKit

// MARK: - DataSource
public protocol DSCommonPaymentValueRadioSource: AnyObject {
    /// Using set data
    func dscommonPaymentValueRadioView(in view: DSCommonPaymentValueRadioView) -> DSCommonPaymentValueRadioViewModel
}

// MARK: - Delegate
public protocol DSCommonPaymentValueRadioDelegate: AnyObject {
    func didSelect(_ view: DSCommonPaymentValueRadioView, tagId: Int)
    func didToggleBalance(_ view: DSCommonPaymentValueRadioView, tagId: Int, state: DSCommonPaymentValueRadioBalanceState)
}

extension DSCommonPaymentValueRadioDelegate {
    func didToggleBalance(_ view: DSCommonPaymentValueRadioView, tagId: Int, state: DSCommonPaymentValueRadioBalanceState) {}
}

public class DSCommonPaymentValueRadioView: UIView {
    @IBOutlet private weak var selectionView: UIView!
    @IBOutlet private weak var radioView: RadioView!
    @IBOutlet private weak var mainVStackView: UIStackView!
    /// title
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleStackView: UIStackView!
    /// value
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var valueStackView: UIStackView!
    @IBOutlet private weak var valueSkeltionContainerView: UIView!
    @IBOutlet private weak var valueSkeletonView: DSSkeletonLoading!
    /// desc
    @IBOutlet private weak var descLabel: UILabel!
    /// balance label
    @IBOutlet private weak var balanceLabel: UILabel!
    /// balance value
    @IBOutlet private weak var balanceValueIcon: DSClickableIconGeneralIcon!
    @IBOutlet private weak var balanceValueIconView: UIView!
    @IBOutlet private weak var balanceValueSkeletonContainerView: UIView!
    @IBOutlet private weak var balanceValueSkeletonView: DSSkeletonLoading!
    @IBOutlet private weak var balanceValueLabel: UILabel!
    /// contentStackView
    @IBOutlet private weak var contentStackView: UIStackView!
    /// strikethrough
    @IBOutlet private weak var strikethroughLabel: UILabel!
    /// custom content
    @IBOutlet private weak var contentView: UIView!
    ///
    @IBOutlet private weak var parentView: UIView!
    
    // mandatory
    private var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    // optional
    private var valueText: String? {
        didSet {
            valueLabel.text = valueText
            updateValueVisibility()
            updatePriorityValue()
        }
    }
    private var descriptionText: String? {
        didSet {
            descLabel.text = descriptionText
        }
    }
    
    private var valueStrikethroughText: String? {
        didSet {
            updateViewAndStrikethroughText()
            updatePriorityValue()
        }
    }
    private var balanceText: String? {
        didSet {
            balanceLabel.text = balanceText
        }
    }
    private var balanceValueText: String?
    
    private var balanceState: DSCommonPaymentValueRadioBalanceState = .displayed {
        didSet {
            updateBalanceVisibility()
        }
    }
    
    private var valueState: DSCommonPaymentValueRadioValueState = .show {
        didSet {
            updateValueVisibility()
        }
    }
    
    // value style
    private var valueStyle: DSCommonPaymentValueRadioStyle = .general {
        didSet {
            valueLabel.textColor = valueStyle.color
        }
    }
    
    // DataSource
    private weak var dataSource: DSCommonPaymentValueRadioSource?
    // Delegate
    private weak var delegate: DSCommonPaymentValueRadioDelegate?
    
    public var tagId: Int = 0 {
        didSet {
            tag = tagId
        }
    }
    
    // toggle
    public var isSelected: Bool = false {
        didSet {
            updateState()
        }
    }
    
    public var isEnabled: Bool = false {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setViews()
    }
    
    // MARK: - Public
    public func setUp(dataSource: DSCommonPaymentValueRadioSource,
                      delegate: DSCommonPaymentValueRadioDelegate?,
                      tagId: Int? = 0) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.tagId = tagId ?? 0
        self.updateData()
    }
    
    public func set(isSelected: Bool? = nil, isEnabled: Bool? = nil) {
        if isSelected.isNotNull {
            self.isSelected = isSelected ?? false
        }
        
        if isEnabled.isNotNull {
            self.isEnabled = isEnabled ?? false
        }
    }
    
    public func setValueState(valueState: DSCommonPaymentValueRadioValueState) {
        self.valueState = valueState
    }
    
    public func setValue(valueText: String) {
        self.valueText = valueText
    }
    
    public func setValueStrikethrough(valueStrikethroughText: String) {
        self.valueStrikethroughText = valueStrikethroughText
    }
    
    public func setValueStyle(valueStyle: DSCommonPaymentValueRadioStyle) {
        self.valueStyle = valueStyle
    }
    
    public func setBalanceState(balanceState: DSCommonPaymentValueRadioBalanceState) {
        self.balanceState = balanceState
    }
    
    public func setBalanceValue(balanceValueText: String) {
        self.balanceValueText = balanceValueText
    }
    
    public func reload() {
        updateData()
        mainVStackView.layoutIfNeeded()
    }
}

// MARK: - Action
private extension DSCommonPaymentValueRadioView {
    @objc func handleAction(_ sender: Any) {
        guard !isEnabled else { return }
        delegate?.didSelect(self, tagId: tagId)
    }
}

extension DSCommonPaymentValueRadioView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == balanceValueIcon {
            return false
        }
        return true
    }
}

private extension DSCommonPaymentValueRadioView {
    func setViews() {
        // set UI
        titleLabel.setUp(
            font: DSFont.labelList,
            textColor: DSColor.componentLightDefault,
            numberOfLines: 0
        )
        
        valueLabel.setUp(
            font: DSFont.valueList,
            textColor: DSColor.componentLightDefault,
            numberOfLines: 0
        )
        
        descLabel.setUp(
            font: DSFont.labelSelectionXSmall,
            textColor: DSColor.componentLightDesc,
            numberOfLines: 0
        )
        
        strikethroughLabel.setUp(
            font: DSFont.valueStrikethrough,
            textColor: DSColor.componentLightDesc,
            numberOfLines: 0
        )
        balanceLabel.setUp(
            font: DSFont.labelXSmall,
            textColor: DSColor.componentLightDesc,
            numberOfLines: 0
        )
        balanceValueLabel.setUp(
            font: DSFont.valueListXSmall,
            textColor: DSColor.componentLightDesc,
            numberOfLines: 0
        )
        
        valueSkeletonView.setup(style: .rounded)
        balanceValueSkeletonView.setup(style: .rounded)
        
        valueSkeletonView.isHidden = true
        valueSkeltionContainerView.isHidden = true
        balanceValueSkeletonView.isHidden = true
        balanceValueSkeletonContainerView.isHidden = true
        
        balanceValueIcon.setup(
            viewModel: DSClickableIconGeneralIconViewModel(
                tagId: .zero,
                state: .active,
                theme: .light,
                size: .medium,
                imageType: .image(DSIcons.icon24OutlineeyeOff.image),
                isBadged: false
            ),
            action: { _ in
                let newState: DSCommonPaymentValueRadioBalanceState
                switch self.balanceState {
                case .masked:
                    newState = .noMask
                case .noMask:
                    newState = .masked
                default:
                    newState = self.balanceState
                }
                self.balanceState = newState
                self.delegate?.didToggleBalance(self, tagId: self.tagId, state: newState)
            }
        )
        
        bringSubviewToFront(balanceValueIcon)
        // set Gesture
        setupGesture()
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAction(_:)))
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
    }
    
    func updateData() {
        guard let dataSource = dataSource else { return }
        let source = dataSource.dscommonPaymentValueRadioView(in: self)
        titleText = source.getLabel()
        valueText = source.getValue()
        descriptionText = source.getDescription()
        valueStrikethroughText = source.getValueStrikethrough()
        balanceText = source.getBalanceLabel()
        balanceValueText = source.getBalanceValue()
        
        if let style = source.getValueStyle() {
            valueStyle = style
        }
        
        if let newBalanceState = source.getBalanceState() {
            balanceState = newBalanceState
        }
        
        if let newValueState = source.getValueState() {
            valueState = newValueState
        }
        
        updateValueVisibility()
        updateBalanceVisibility()
        
        // set hidden
        descLabel.isHidden = source.getIsDescriptionHidden()
        strikethroughLabel.isHidden = source.getIsValueStrikethroughHidden()
        
        if let expandView = source.getContentView() {
            parentView.isHidden = false
            contentView.isHidden = false
            setUpExpandableView(with: expandView)
        } else {
            parentView.isHidden = true
            contentView.isHidden = true
        }
        isEnabled = source.getIsEnabled()
        isSelected = source.getIsSelected()
    }
    
    func updatePriorityValue() {
        if valueLabel.intrinsicContentSize.width >= strikethroughLabel.intrinsicContentSize.width {
            setPriorityLabel(heightPriority: valueLabel, lowPriority: strikethroughLabel)
        } else {
            setPriorityLabel(heightPriority: strikethroughLabel, lowPriority: valueLabel)
        }
    }
    
    func setPriorityLabel(heightPriority: UILabel, lowPriority: UILabel) {
        heightPriority.setContentHuggingPriority(
            .required,
            for: .horizontal
        )
        
        heightPriority.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
        
        lowPriority.setContentHuggingPriority(
            UILayoutPriority(251),
            for: .horizontal
        )
        
        lowPriority.setContentCompressionResistancePriority(
            UILayoutPriority(750),
            for: .horizontal
        )
    }
    
    // update state
    func updateState() {
        var state = radioView.state
        if isSelected {
            state = isEnabled ? .disableSelected : .selected
        } else {
            state = isEnabled ? .disableUnselected : .default
        }
        radioView.state = state
    }
    
    func setUpExpandableView(with view: UIView?) {
        guard let view = view,
              contentView != view else { return }
        contentView?.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        mainVStackView.layoutIfNeeded()
    }
    
    func updateValueVisibility() {
        switch valueState {
        case .loading:
            valueLabel.isHidden = true
            valueStackView.isHidden = true
            valueSkeletonView.isHidden = false
            valueSkeltionContainerView.isHidden = false
            
            titleStackView.isHidden = false
            valueSkeletonView.startAnimation()
        case .show:
            let shouldHideValue = valueText?.isEmpty ?? true
            valueStackView.isHidden = shouldHideValue
            valueLabel.isHidden = false
            valueSkeletonView.isHidden = true
            valueSkeltionContainerView.isHidden = true
            valueSkeletonView.stopAnimation()
        case .hide:
            valueLabel.isHidden = true
            valueStackView.isHidden = true
            valueSkeletonView.isHidden = true
            valueSkeltionContainerView.isHidden = true
            valueSkeletonView.stopAnimation()
        }
    }
    
    func updateBalanceVisibility() {
        switch balanceState {
        case .loading:
            balanceValueLabel.isHidden = true
            balanceValueIcon.isHidden = true
            balanceValueIconView.isHidden = true
            
            balanceValueSkeletonView.isHidden = false
            balanceValueSkeletonContainerView.isHidden = false
            
            balanceValueSkeletonView.startAnimation()
        case .masked:
            balanceValueLabel.isHidden = false
            balanceValueIcon.isHidden = false
            balanceValueIconView.isHidden = false
            
            balanceValueSkeletonView.isHidden = true
            balanceValueSkeletonContainerView.isHidden = true
            
            balanceValueSkeletonView.stopAnimation()
            balanceValueLabel.setMaskedText()
            updateBalanceIconState(isMasked: true)
        case .noMask:
            balanceValueLabel.isHidden = false
            balanceValueIcon.isHidden = false
            balanceValueIconView.isHidden = false
            
            balanceValueSkeletonView.isHidden = true
            balanceValueSkeletonContainerView.isHidden = true
            
            balanceValueSkeletonView.stopAnimation()
            balanceValueLabel.resetToNormalText(balanceValueText)
            updateBalanceIconState(isMasked: false)
        case .displayed:
            let shouldHideBalanceLabel = balanceText?.isEmpty ?? true
            balanceLabel.isHidden = shouldHideBalanceLabel
            
            let shouldHideBalanceValue = balanceValueText?.isEmpty ?? true
            balanceValueLabel.isHidden = shouldHideBalanceValue
            
            let shouldHideContentStackView = shouldHideBalanceLabel && shouldHideBalanceValue
            contentStackView.isHidden = shouldHideContentStackView
            
            balanceValueLabel.isHidden = false
            balanceValueIcon.isHidden = true
            balanceValueIconView.isHidden = true
            
            balanceValueSkeletonView.isHidden = true
            balanceValueSkeletonContainerView.isHidden = true
            
            balanceValueSkeletonView.stopAnimation()
            balanceValueLabel.resetToNormalText(balanceValueText)
        }
    }
    
    func updateBalanceIconState(isMasked: Bool) {
        balanceValueIcon.imageType = .image(isMasked ? DSIcons.icon24OutlineeyeOff.image : DSIcons.icon24OutlineEye.image)
    }
    
    func updateViewAndStrikethroughText() {
        guard let dataSource = dataSource,
              let text = valueStrikethroughText
        else { return }
        
        var source = dataSource.dscommonPaymentValueRadioView(in: self)
        source.setValueStrikethrough(text: text)
        
        strikethroughLabel.isHidden = source.getIsValueStrikethroughHidden()
        strikethroughLabel.setStrikeThrough(text: text, font: DSFont.valueStrikethrough)
    }
}
