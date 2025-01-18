//
//  ListExpandView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/11/2565 BE.
//

import Foundation
import UIKit

public typealias StickyButtonListExpandAction = ((_ isExpand: Bool) -> Void)

final class ListExpandView: UIView {
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var expandContainerView: UIStackView!
    @IBOutlet public weak var textLeftLabel: UILabel!
    @IBOutlet public weak var textRightLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    public var iconImage: DSIcons = DSIcons.icon24OutlinePlaceholder {
        didSet {
            iconImageView.image = iconImage.image.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = DSColor.componentLightDefault
            iconImageView.tintAdjustmentMode = .normal
        }
    }
    
    var expandAction: StickyButtonListExpandAction?
    var isExpanded: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - Action
extension ListExpandView {
    @IBAction func onTabButton(sender: UITapGestureRecognizer) {
        isExpanded.toggle()
        expandAction?(isExpanded)
    }
}

// MARK: - Private
private extension ListExpandView {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        textLeftLabel.font = DSFont.labelListMedium
        textLeftLabel.textColor = DSColor.componentLightLabel
        textLeftLabel.numberOfLines = 0
        
        textRightLabel.font = DSFont.h3
        textRightLabel.textColor = DSColor.componentLightDefault
        textRightLabel.numberOfLines = 0
        
        iconImage = DSIcons.icon24OutlinePlaceholder
    }
    
    func setupGesture() {
        let taptextRightGesture = UITapGestureRecognizer(target: self, action: #selector(onTabButton(sender:)))
        textRightLabel.addGestureRecognizer(taptextRightGesture)
        
        let tapimageContainerGesture = UITapGestureRecognizer(target: self, action: #selector(onTabButton(sender:)))
        imageContainerView.addGestureRecognizer(tapimageContainerGesture)
    }
}
