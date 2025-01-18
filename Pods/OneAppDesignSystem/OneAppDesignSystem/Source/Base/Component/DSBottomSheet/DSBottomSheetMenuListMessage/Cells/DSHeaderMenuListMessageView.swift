//
//  DSHeaderMenuListMessageView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 1/2/2566 BE.
//

import UIKit

final class DSHeaderMenuListMessageView: UIView {
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

private extension DSHeaderMenuListMessageView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.font = DSFont.h2
        titleLabel.textColor = DSColor.componentLightDefault
    }
}
