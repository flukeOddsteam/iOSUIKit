//
//  DSBulletSecondaryView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/1/2566 BE.
//

import UIKit

final class BulletSecondaryView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bulletView: BulletView!
    @IBOutlet weak var bulletContainerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(viewModel: DSBulletSecondaryViewModel) {
        titleLabel.text = viewModel.title
        bulletContainerView.isHidden = !viewModel.isShowBullet
    }
}

// MARK: - Private
private extension BulletSecondaryView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        bulletView.style = .secondary
        
        titleLabel.textColor = DSColor.componentLightDesc
        titleLabel.font = DSFont.paragraphSmall
    }
}
