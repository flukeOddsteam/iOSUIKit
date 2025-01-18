//
//  CheckboxListExpandDescriptionContentView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/4/2566 BE.
//

import UIKit

final class CheckboxListExpandDescriptionContentView: UIView {
    
    @IBOutlet weak var leftDescriptionLabel: UILabel!
    @IBOutlet weak var rightDescriptionLabel: UILabel!
    @IBOutlet weak var leftContainerView: UIView!
    @IBOutlet weak var rightContainerView: UIView!
    @IBOutlet weak var widthContentContainerConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(contentMultipiler: CGFloat, style: DSCheckboxListMessageExpandableDescStyle) {
        switch style {
        case .labelDescOnly(let description):
            leftDescriptionLabel.text = description
            rightDescriptionLabel.text = nil
            widthContentContainerConstraint.isActive = false
            rightContainerView.isHidden = true
            leftContainerView.isHidden = false
            
        case .valueDescOnly(let description):
            rightDescriptionLabel.text = description
            leftDescriptionLabel.text = nil
            widthContentContainerConstraint.isActive = true
            leftContainerView.isHidden = false
            rightContainerView.isHidden = false
            widthContentContainerConstraint.setMultiplier(multiplier: contentMultipiler)

        case .labelAndValueDesc(let labelDescription, let valueDescription):
            leftDescriptionLabel.text = labelDescription
            rightDescriptionLabel.text = valueDescription
            widthContentContainerConstraint.isActive = true
            leftContainerView.isHidden = false
            rightContainerView.isHidden = false
            widthContentContainerConstraint.setMultiplier(multiplier: contentMultipiler)
        }
        
        layoutIfNeeded()
    }
}

// MARK: - Private
private extension CheckboxListExpandDescriptionContentView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        leftDescriptionLabel.textColor = DSColor.componentLightDesc
        leftDescriptionLabel.font = DSFont.labelInput
        
        rightDescriptionLabel.textColor = DSColor.componentLightDesc
        rightDescriptionLabel.font = DSFont.labelInput
    }
}
