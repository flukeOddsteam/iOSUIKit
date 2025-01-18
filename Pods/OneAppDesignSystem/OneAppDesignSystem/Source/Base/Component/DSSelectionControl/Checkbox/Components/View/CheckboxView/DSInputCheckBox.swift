//
//  CheckboxView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/10/22.
//

import UIKit

public final class DSInputCheckBox: UIView {

    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var checkIconImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    public var state: DSSelectionCheckboxState = .default {
        didSet {
            updateAppearance()
        }
    }
    public var type: DSSelectionCheckboxType = .default
    public var theme: DSSelectionCheckboxTheme = .light
    
    // Private
    private var builder: SelectionCheckBoxBuilder = SelectionCheckBoxBuilder()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupUI()
        updateAppearance()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupUI()
        updateAppearance()
    }
}

// MARK: - Private
private extension DSInputCheckBox {
    func setupUI() {
        self.selectionView.setRadius(radius: .radius4px)
        self.checkIconImageView.image = DSIcons.icon16Check.image.withRenderingMode(.alwaysTemplate)
        self.checkIconImageView.tintColor = DSColor.componentPrimaryDefault
        self.checkIconImageView.tintAdjustmentMode = .normal

    }
    
    func updateAppearance() {
        let checkboxAppearanceViewModel = builder.build(state: state, type: type, theme: theme)
        self.contentView.backgroundColor = checkboxAppearanceViewModel.viewContentCheckboxColor
        self.selectionView.layer.borderColor = checkboxAppearanceViewModel.borderColor.cgColor
        self.selectionView.layer.borderWidth = state.checkboxBorderWidth
        self.selectionView.backgroundColor = checkboxAppearanceViewModel.backgroundColor
        self.checkIconImageView.isHidden = state.checkIconAppear
    }
}
