//
//  CheckboxValueExpandView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/4/2566 BE.
//

import UIKit
protocol CheckboxValueExpandViewDelegate: AnyObject {
    func checkboxValueExpandDidTapped(_ view: CheckboxValueExpandView)
}

final class CheckboxValueExpandView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconContainerView: UIView!
    
    var state: DSCheckboxListMessageExpandableState = .collapse {
        didSet {
            updateState()
        }
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var isEnabledExpand: Bool = true {
        didSet {
            updateEnabledExpandView()
        }
    }
    
    lazy var touchGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(expandDidTapped(_:)))
    }()
    
    weak var delegate: CheckboxValueExpandViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(title: String, isEnabledExpand: Bool) {
        self.title = title
        self.isEnabledExpand = isEnabledExpand
    }
}

// MARK: - Action
extension CheckboxValueExpandView {
    @objc func expandDidTapped(_ sender: UIGestureRecognizer) {
        delegate?.checkboxValueExpandDidTapped(self)
    }
}
// MARK: - Private
private extension CheckboxValueExpandView {
    func commonInit() {
        setupXib()
        setupUI()
        updateState()
        updateEnabledExpandView()
    }
    
    func setupUI() {
        titleLabel.font = DSFont.valueList
        titleLabel.textColor = DSColor.componentLightDefault
        iconImageView.tintAdjustmentMode = .normal
    }
    
    func updateState() {
        switch state {
        case .collapse:
            iconImageView.image = DSIcons.icon24OutlineChevronDown.image
        case .expand:
            iconImageView.image = DSIcons.icon24OutlineChevronUp.image
        }
    }
    
    func updateEnabledExpandView() {
        iconContainerView.isHidden = !isEnabledExpand
        if isEnabledExpand {
            addGestureRecognizer(touchGesture)
        } else {
            removeGestureRecognizer(touchGesture)
        }
    }
}
