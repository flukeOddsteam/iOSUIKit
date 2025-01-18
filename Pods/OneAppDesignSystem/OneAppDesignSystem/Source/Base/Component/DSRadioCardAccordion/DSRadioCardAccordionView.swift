//
//  DSRadioCardAccordion.swift
//  OneAppDesignSystem
//
//  Created by TTB on 30/10/2567 BE.
//

import UIKit

public protocol DSRadioCardAccordionDataSource: AnyObject {
    func updateResource(_ view: DSRadioCardAccordionView) -> DSRadioCardAccordionViewModel
    func addContentView(_ view: DSRadioCardAccordionView) -> UIView?
}

public protocol DSRadioCardAccordionDelegate: AnyObject {
    func onClick(_ view: DSRadioCardAccordionView, didSelect tagId: Int)
}

private enum Constants {
    static let defaultStackViewBottomConstraint: CGFloat = 16.0
    static let expandedStackViewBottomConstraint: CGFloat = 0.0
    static let defaultAnimationTimeInterval: CGFloat = 0.3
    static let unCheckedAnimationTimeInterval: CGFloat = 0.2
}

public class DSRadioCardAccordionView: UIView {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var radioView: RadioView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueView: UIView!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var descriptionView: UIView!
    @IBOutlet private weak var expandableView: UIView!
    /// Selection view for trigger `didSelect` callback
    @IBOutlet private weak var selectionView: UIView!
    /// Constraints
    @IBOutlet private weak var stackViewBottomConstraint: NSLayoutConstraint!
    
    /// Variable for updating state of DSRadioCardView
    public var state: DSSelectionRadioCardAccordionState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    /// Private
    private var tagId: Int = 0 {
        didSet {
            tag = tagId
        }
    }
    private var title: String!
    private var value: String?
    private var desc: String?
    private var contentView: UIView?
    
    // DataSource
    private var dataSource: DSRadioCardAccordionDataSource?
    // Delegate
    private weak var delegate: DSRadioCardAccordionDelegate?
    
    /// State
    private var isChecked: Bool = false {
        didSet {
            state = isChecked ? .selected : .default
            isExpanded = isChecked
            updateExpandableView(isAnimate)
        }
    }
    private var isExpanded: Bool = false {
        didSet {
            stackViewBottomConstraint.constant = isExpanded ? Constants.expandedStackViewBottomConstraint : Constants.defaultStackViewBottomConstraint
            updateExpandableView(isAnimate)
        }
    }
    private var isAnimate: Bool = false
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    // MARK: - Public
    public func setUp(
        dataSource: DSRadioCardAccordionDataSource,
        delegate: DSRadioCardAccordionDelegate
    ) {
        self.delegate = delegate
        self.dataSource = dataSource
        
        updateRadioCardAccordionView()
        setUpLabel()
    }
    
    public func setCheck(isCheck: Bool, isAnimate: Bool = false) {
        let shouldUpdateCheck = self.isChecked != isCheck
        let shouldCollapse = !isCheck && isExpanded
        let shouldUpdateAnimate = self.isAnimate != isAnimate

        if shouldUpdateCheck {
            self.isChecked = isCheck
        }

        if shouldCollapse {
            isExpanded = false
        }

        if shouldUpdateAnimate {
            self.isAnimate = isAnimate
        }
    }
    
    public func removeContentView() {
        contentView?.removeSubviews()
        updateExpandableView(isAnimate)
    }
    
    public func reloadData() {
        expandableView.layoutIfNeeded()
    }
}

// MARK: - Private
private extension DSRadioCardAccordionView {
    func setView() {
        setupXib()
        updateAppearance()

        selectionView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(selectionAreaDidTap)
            )
        )
        
        descriptionView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(selectionAreaDidTap)
            )
        )
    }
    
    func setUpLabel() {
        titleLabel.text = title
        valueView.isHidden = value?.isEmpty ?? true
         if let value = value {
             valueLabel.text = value
         }
         
        descriptionView.isHidden = desc?.isEmpty ?? true
        if let description = self.desc,
            !description.isEmpty {
             descriptionLabel.text = description
         }
    }
    
    func setUpExpandableView(with view: UIView?) {
        guard let view = view,
                contentView != view else { return }
        defer { contentView = view }
        contentView?.removeFromSuperview()
        expandableView?.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: expandableView.topAnchor),
            view.trailingAnchor.constraint(equalTo: expandableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: expandableView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: expandableView.leadingAnchor)
        ])
    }
    
    func updateAppearance() {
        /// set style
        titleLabel.setUp(
            font: DSFont.labelSelectionMedium,
            textColor: DSColor.componentLightDefault,
            numberOfLines: 0
        )
        
        valueLabel.setUp(
            font: DSFont.labelSelectionBold,
            textColor: DSColor.componentLightDefault,
            numberOfLines: 1
        )
        
        descriptionLabel.setUp(
            font: DSFont.paragraphSmall,
            textColor: DSColor.componentLightDesc,
            numberOfLines: 0
        )
        
        radioView?.state = DSSelectionRadioState(state)
        layer.cornerRadius = state.radioCardAccordionCornerRadius
        containerView.layer.borderWidth = state.radioCardAccordionBorderWidth
        containerView.layer.borderColor = state.radioCardAccordionBorderColor.cgColor
        containerView.layer.cornerRadius = state.radioCardAccordionCornerRadius
        containerView.backgroundColor = state.radioCardAccordionBackgroundColor
        containerView.dsShadowDrop(isHidden: !state.radioCardAccordionShadowEnabled, style: .bottom)
    }
    
    func updateExpandableView(_ animated: Bool) {
        let isHidden = !isExpanded
        if animated {
            let animator = UIViewPropertyAnimator(
                duration: isHidden ? Constants.unCheckedAnimationTimeInterval : Constants.defaultAnimationTimeInterval,
                curve: .easeInOut
            ) { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.expandableView.isHidden = isHidden
            }

            animator.addCompletion { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.expandableView.isHidden = isHidden
            }
            
            animator.startAnimation()
        } else {
            expandableView.isHidden = isHidden
        }
        stackView.layoutIfNeeded()
    }
    
    // MARK: - Action
    @objc func selectionAreaDidTap() {
        guard state.isUserInteractonEnabled else {
            return
        }
        guard !isChecked else { return }
        delegate?.onClick(self, didSelect: tagId)
    }
    
    func updateRadioCardAccordionView() {
        guard let result = dataSource?.updateResource(self)
        else { return }
        
        self.tagId = result.tagId
        self.title = result.title
        self.value = result.value
        self.desc = result.description
        self.isExpanded = result.isExpanded
        self.state = result.state
        
        updateContentView()
    }
    
    func updateContentView() {
        guard let contentView = dataSource?.addContentView(self)
        else { return }
        
        setUpExpandableView(with: contentView)
    }
}

fileprivate extension DSSelectionRadioState {
    init(_ state: DSSelectionRadioCardAccordionState) {
        switch state {
        case .default:
            self = .default
        case .selected:
            self = .selected
        case .disableUnselected:
            self = .disableUnselected
        case .disableSelected:
            self = .disableSelected
        }
    }
}
