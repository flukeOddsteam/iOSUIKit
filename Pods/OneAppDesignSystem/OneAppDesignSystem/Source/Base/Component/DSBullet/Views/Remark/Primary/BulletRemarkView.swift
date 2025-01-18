//
//  DSBulletRemarkView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/1/2566 BE.
//

import UIKit

final class BulletRemarkView: UIView {
    
    @IBOutlet weak var bulletView: BulletView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(viewModel: DSBulletRemarkViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.titleColor.textColor
        
        switch viewModel.titleColor {
        case .grey:
            bulletView.style = .remarkGrey
        case .white:
            bulletView.style = .remarkWhite
        }
    }
}

// MARK: - Private
private extension BulletRemarkView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.font = DSFont.paragraphXSmall
    }
}
