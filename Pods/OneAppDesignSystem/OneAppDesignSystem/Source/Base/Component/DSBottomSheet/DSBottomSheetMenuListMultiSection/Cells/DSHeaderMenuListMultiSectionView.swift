//
//  DSHeaderMenuListMultiSectionView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/10/24.
//

import UIKit

final class DSHeaderMenuListMultiSectionView: UIView {
    @IBOutlet weak var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
    
    func setAccessibilityIdentifier(titleLabelId: String) {
        self.titleLabel.accessibilityIdentifier = titleLabelId
    }
}

private extension DSHeaderMenuListMultiSectionView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.font = DSFont.h2
        titleLabel.textColor = DSColor.componentLightDefault
    }
}
