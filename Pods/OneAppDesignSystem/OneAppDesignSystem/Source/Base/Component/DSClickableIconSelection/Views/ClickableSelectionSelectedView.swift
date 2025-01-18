//
//  ClickableSelectionVerifyView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/3/2566 BE.
//

import UIKit

private enum Constants {
    
}

final class ClickableSelectionSelectedView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var state: ClickableSelectionSelectedState = .default {
        didSet {
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
}

// MARK: - Private
private extension ClickableSelectionSelectedView {
    
    func commonInit() {
        setupXib()
        setupUI()
        updateState()
    }
    
    func setupUI() {
        
        backgroundColor = .clear

        containerView.setCircle()
        
        let image = DSIcons.icon16Check.image.withRenderingMode(.alwaysTemplate)
        iconImageView.image = image
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = DSColor.componentLightBackgroundOnPress
        iconImageView.tintAdjustmentMode = .normal
    }
    
    func updateState() {
        UIView.setAnimationsEnabled(false)
        let appearance: ClickableSelectionSelectedAppearance = state
        containerView.backgroundColor = appearance.backgroundColor
        UIView.setAnimationsEnabled(true)
    }
}
