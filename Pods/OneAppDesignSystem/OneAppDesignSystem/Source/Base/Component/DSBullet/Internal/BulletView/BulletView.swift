//
//  BulletView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/1/23.
//

import UIKit

enum DSBulletViewStyle {
    case primaryNevy
    case primaryGrey
    case primaryWhite
    case secondary
    case remarkGrey
    case remarkWhite
}

final class BulletView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var circleWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    var style: DSBulletViewStyle = .primaryNevy {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(bulletViewStyle: DSBulletViewStyle) {
        self.style = bulletViewStyle
    }
}

// MARK: - Private
private extension BulletView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        circleView.setCircle()
    }
    
    func updateAppearance() {
        circleView.setBorder(width: style.borderWidth, color: style.borderColor)
        circleView.backgroundColor = style.backgroundColor
        circleWidthConstraint.constant = style.circleViewSize
        circleHeightConstraint.constant = style.circleViewSize
        contentViewWidthConstraint.constant = style.contentViewSize
        contentViewHeightConstraint.constant = style.contentViewSize
        circleView.layer.cornerRadius = style.circleViewSize / 2
    }
}
