//
//  DSBulletKeyHighLightView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/1/23.
//

import UIKit

final class BulletKeyHighLightView: UIView {

    @IBOutlet weak var bulletImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(viewModel: DSBulletKeyHighLightViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.titleColor.textColor
        
        switch viewModel.titleColor {
        case .nevy:
            bulletImageView.setColor(color: DSColor.componentSummaryDefault)
        case .grey:
            bulletImageView.setColor(color: DSColor.componentSummaryDesc)
        case .white:
            bulletImageView.setColor(color: .white)
        }
    }
    
}

// MARK: - Private
private extension BulletKeyHighLightView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        bulletImageView.image = DSIcons.icon16Check.image.withRenderingMode(.alwaysTemplate)
        bulletImageView.setColor(color: DSColor.componentLightDefault)
        bulletImageView.tintAdjustmentMode = .normal

        titleLabel.font = DSFont.paragraphSmall
        titleLabel.textColor = DSColor.componentLightDefault
    }
}
