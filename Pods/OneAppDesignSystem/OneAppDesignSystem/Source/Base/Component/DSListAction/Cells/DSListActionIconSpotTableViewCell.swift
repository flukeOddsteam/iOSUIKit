//
//  DSListActionIconSpotTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/11/2567 BE.
//

import Foundation
import UIKit

public final class DSListActionIconSpotTableViewCell: UITableViewCell, NibLoadable {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var leftIconImageView: UIImageView!
    @IBOutlet weak var rightIconView: UIView!
    @IBOutlet weak var rightIconImageView: UIImageView!
    @IBOutlet weak var bottomBorder: UIView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    public func configure(viewModel: ListActionIconSpotViewModel, isShowBottomLine: Bool) {
        label.text = viewModel.text
        label.font = viewModel.textStyle.font
        
        switch viewModel.hideRightIcon {
        case .all:
            rightIconView.isHidden = !viewModel.rightIcon.isNotNull
            rightIconImageView.isHidden = !viewModel.rightIcon.isNotNull
        case .onlyIcon:
            rightIconView.isHidden = false
            rightIconImageView.isHidden = !viewModel.rightIcon.isNotNull
        }
        
        leftIconImageView.image = viewModel.leftImage.image
        rightIconImageView.image = viewModel.rightIcon?.image.withRenderingMode(.alwaysTemplate)
        
        bottomBorder.isHidden = !isShowBottomLine
    }
    
    public func setAccessibilityIdentifier(id: String, titleLableId: String) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = titleLableId
    }
}

// MARK: - Private
private extension DSListActionIconSpotTableViewCell {
    func setupUI() {
        label.textColor = DSColor.componentLightDefault
        label.numberOfLines = 2
        bottomBorder.backgroundColor = DSColor.componentDividerBackgroundSmall
        rightIconImageView.tintColor = DSColor.componentLightDefault
        leftIconImageView.tintColor = DSColor.componentLightDefault
        
        rightIconImageView.tintAdjustmentMode = .normal
        leftIconImageView.tintAdjustmentMode = .normal
    }
}
