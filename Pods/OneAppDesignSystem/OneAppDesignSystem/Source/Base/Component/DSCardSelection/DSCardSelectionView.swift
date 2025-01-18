//
//  DSCardSelectionView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/11/2567 BE.
//

import UIKit

// MARK: - DataSource
public protocol DSCardSelectionDataSource: AnyObject {
    /// Using set data
    func dscardSelectionView(in view: DSCardSelectionView) -> DSCardSelectionViewModel?
}

// MARK: - Delegate
public protocol DSCardSelectionDelegate: AnyObject {
    func didSelect(_ view: DSCardSelectionView, tagId: Int)
}

public class DSCardSelectionView: UIView, DSCommonContainerViewInterface {
    /// IBOutlet
    @IBOutlet private weak var selectView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!

    @IBOutlet private weak var widthRatio: NSLayoutConstraint!
    
    /// Private variable
    private var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    private var valueText: String? {
        didSet {
            valueLabel.text = valueText
            valueLabel.sizeToFit()
        }
    }
    
    private var isEnabled: Bool = false {
        didSet {
            if isEnabled {
                state = .disable
            }
        }
    }
    
    private var isSelected: Bool = false {
        didSet {
            state = isSelected ? .selected : .default
        }
    }
    
    private var ratio: CGFloat = 1.0 {
        didSet {
            widthRatio = widthRatio.setMultiplier(multiplier: ratio)
        }
    }
    
    private var state: DSCardSelectionState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    // Data
    private weak var dataSource: DSCardSelectionDataSource?
    // Delegate
    private weak var delegate: DSCardSelectionDelegate?
    
    public var tagId: Int = 0 {
        didSet {
            tag = tagId
        }
    }
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupUI()
        updateAppearance()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupUI()
        updateAppearance()
        setupGesture()
    }
    
    // MARK: - Public
    public func setUp(dataSource: DSCardSelectionDataSource,
                        delegate: DSCardSelectionDelegate?) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.updateData()
    }
    
    public func set(isSelected: Bool = false,
                    isEnabled: Bool = false) {
        self.isSelected = isSelected
        self.isEnabled = isEnabled
    }
    
    public func toggleSelected() {
        self.isSelected.toggle()
    }
    
    public func reloadView() {
        updateData()
    }
    
    /// Get only
    public func getIsSelected() -> Bool {
        return isSelected
    }
    
    public func getIsEnabled() -> Bool {
        return isEnabled
    }
}

// MARK: - Action
private extension DSCardSelectionView {
    @objc func handleAction(_ sender: Any) {
        guard !isEnabled else { return }
        delegate?.didSelect(self, tagId: tagId)
    }
}

// MARK: - Private
private extension DSCardSelectionView {
    func setupUI() {
        titleLabel.setUp(font: DSFont.labelSelectionXSmall,
                         textColor: DSColor.componentLightDefault,
                         numberOfLines: 2)
        valueLabel.setUp(font: DSFont.valueListXSmall,
                         textColor: DSColor.componentLightDesc,
                         numberOfLines: 0)

        }
        
    func setupGesture() {
        addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleAction(_:))
            )
        )
    }
    
    func updateAppearance() {
        titleLabel.textColor = state.labelColor
        valueLabel.textColor = state.labelColor
        selectView.backgroundColor = state.backgroundColor
        selectView.layer.borderColor = state.borderColor.cgColor
        selectView.layer.cornerRadius = 12
        selectView.layer.borderWidth = state.borderWidth
        selectView.dsShadowDrop(isHidden: state.isShadowHidden, style: .bottom)
    }
    
    func updateData() {
        guard let dataSource = dataSource,
        let dataSourceItem = dataSource.dscardSelectionView(in: self) else { return }
        titleText = dataSourceItem.getTitle()
        valueText = dataSourceItem.getValue()
        valueLabel.isHidden = dataSourceItem.getIsValueHidden()
        isSelected = dataSourceItem.getIsSelected()
        isEnabled = dataSourceItem.getIsEnabled()
        tagId = dataSourceItem.getTagId()
        ratio = dataSourceItem.getRatio()
    }
}
