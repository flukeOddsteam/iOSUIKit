//
//  RemarkBulletPointView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/8/2567
//

import UIKit

final class RemarkBulletPointView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var circleView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - Private
private extension RemarkBulletPointView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        circleView.backgroundColor = DSColor.componentLightDesc
        circleView.setCircle()
    }
}
