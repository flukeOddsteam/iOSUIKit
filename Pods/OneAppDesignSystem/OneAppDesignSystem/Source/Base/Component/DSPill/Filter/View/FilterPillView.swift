//
//  FilterPillView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 19/4/2566 BE.
//

import UIKit

protocol FilterPillViewDelegate: AnyObject {
    func filterPillViewDidTapIconImage(_ view: FilterPillView)
}

final class FilterPillView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    weak var delegate: FilterPillViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(viewModel: DSFilterPillViewModel) {
        self.titleLabel.text = viewModel.title
        self.iconImageView.isHidden = !viewModel.isDisplayRemoveIcon
        
        self.titleLabel.textColor = viewModel.state.textColor
        self.containerView.backgroundColor = viewModel.state.backgroundColor
        self.containerView.setBorder(width: viewModel.state.borderWidth, color: viewModel.state.borderColor)
        self.containerView.layer.cornerRadius = self.containerView.frame.height / 2
    }
}

// MARK: - Action
extension FilterPillView {
    @objc func iconImageDidTapped(_ sender: UIGestureRecognizer) {
        delegate?.filterPillViewDidTapIconImage(self)
    }
}
// MARK: - Private
private extension FilterPillView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        self.titleLabel.font = DSFont.labelList
        self.iconImageView.tintColor = DSColor.componentDarkDefault
        self.iconImageView.image = DSIcons.icon24OutlineClose.image.withRenderingMode(.alwaysTemplate)
        self.iconImageView.tintAdjustmentMode = .normal

        let gesture = UITapGestureRecognizer(target: self, action: #selector(iconImageDidTapped(_:)))
        self.iconImageView.addGestureRecognizer(gesture)
        self.iconImageView.isUserInteractionEnabled = true
    }
}
