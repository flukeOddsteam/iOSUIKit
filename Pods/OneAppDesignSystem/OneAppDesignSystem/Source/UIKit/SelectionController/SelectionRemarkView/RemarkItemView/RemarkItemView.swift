//
//  RemarkItemView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/8/2567 BE.
//

import UIKit

final class RemarkItemView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bulletView: RemarkBulletPointView!
    @IBOutlet weak var bulletContainerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(viewModel: RemarkItemViewModel) {
        titleLabel.text = viewModel.title
        bulletContainerView.isHidden = !viewModel.isShowBullet
    }
}

// MARK: - Private
private extension RemarkItemView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.setUp(font: DSFont.paragraphXSmall, textColor: DSColor.componentLightDesc, numberOfLines: .zero)
    }
}
