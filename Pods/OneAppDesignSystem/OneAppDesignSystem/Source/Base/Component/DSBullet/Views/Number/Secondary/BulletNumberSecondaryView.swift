//
//  DSBulletNumberSecondaryView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/1/2566 BE.
//

import UIKit

final class BulletNumberSecondaryView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var prefixLabel: UILabel!
    @IBOutlet weak var prefixContainerView: UIView!
    
    @IBOutlet weak var bulletContainerView: UIView!
    @IBOutlet weak var bulletView: BulletView!
    
    private var style: DSBulletNumberSecondaryStyle = .bullet
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(
        viewModel: DSBulletNumberSecondaryViewModel,
        prefix: String? = nil
    ) {
        self.titleLabel.text = viewModel.title
        self.prefixLabel.text = prefix
        self.style = viewModel.style
        updateStyle()
    }
}

// MARK: - Private
private extension BulletNumberSecondaryView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.textColor = DSColor.componentLightDesc
        titleLabel.font = DSFont.paragraphSmall
        
        prefixLabel.textColor = DSColor.componentLightDesc
        prefixLabel.font = DSFont.paragraphSmall

        bulletView.style = .secondary
    }
    
    func updateStyle() {
        switch style {
        case .bullet:
            bulletContainerView.isHidden = false
            prefixContainerView.isHidden = true
        case .number:
            bulletContainerView.isHidden = true
            prefixContainerView.isHidden = false
        case .description:
            bulletContainerView.isHidden = true
            prefixContainerView.isHidden = true
        }
    }
}
