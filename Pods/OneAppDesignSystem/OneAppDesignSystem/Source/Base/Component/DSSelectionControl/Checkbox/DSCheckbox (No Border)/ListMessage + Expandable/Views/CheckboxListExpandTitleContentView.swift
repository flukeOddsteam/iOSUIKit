//
//  CheckboxListExpandTitleContentView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/4/2566 BE.
//

import UIKit

protocol CheckboxListExpandTitleContentViewDelegate: AnyObject {
    func checkboxListExpandContentDidTapExpand(_ view: CheckboxListExpandTitleContentView)
}

final class CheckboxListExpandTitleContentView: UIView {
    
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueExpandView: CheckboxValueExpandView!
    @IBOutlet weak var widthContainerConstraint: NSLayoutConstraint!
    
    weak var delegate: CheckboxListExpandTitleContentViewDelegate?
    private var multipiler: CGFloat = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(title: String, value: String, isEnabledExpandable: Bool, contentMultipiler: CGFloat) {
        self.titleLabel.text = title
        self.multipiler = contentMultipiler
        self.valueExpandView.setup(title: value, isEnabledExpand: isEnabledExpandable)
        
        self.updateMultipiler()
    }
    
    func updateExpandState(state: DSCheckboxListMessageExpandableState) {
        valueExpandView.state = state
    }
}

// MARK: - CheckboxValueExpandViewDelegate
extension CheckboxListExpandTitleContentView: CheckboxValueExpandViewDelegate {
    func checkboxValueExpandDidTapped(_ view: CheckboxValueExpandView) {
        delegate?.checkboxListExpandContentDidTapExpand(self)
    }
}

// MARK: - Private
private extension CheckboxListExpandTitleContentView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.font = DSFont.labelList
        
        valueExpandView.delegate = self
    }
    
    func updateMultipiler() {
        widthContainerConstraint.setMultiplier(multiplier: multipiler)
    }
}
