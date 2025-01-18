//
//  DSListAccountTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/12/2565 BE.
//

import UIKit

public final class DSListAccountTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var contentCardView: UIView!
    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    public func configure(viewModel: DSBottomSheetDropdownViewModel.DSBottomSheetItem) {
        titleLabel.text = viewModel.title
        firstLabel.text = viewModel.firstText
        secondLabel.text = viewModel.secondText
        accountImageView.image = viewModel.icon?.image
    }
    
    public func setAccessibilityIdentifier(id: String,
                                           titleLabelId: String,
                                           firstLabelId: String,
                                           secondLabelId: String) {
        self.accessibilityIdentifier = id
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.firstLabel.accessibilityIdentifier = firstLabelId
        self.secondLabel.accessibilityIdentifier = secondLabelId
        
    }
    
}

// MARK: - Private
private extension DSListAccountTableViewCell {
    func setUpUI() {
        contentCardView.layer.cornerRadius = 12
        contentCardView.layer.borderColor = DSColor.componentLightOutline.cgColor
        contentCardView.layer.borderWidth = 1
        
        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.font = DSFont.h3
        
        firstLabel.textColor = DSColor.pageLightDesc
        firstLabel.font = DSFont.paragraphSmall
        
        secondLabel.textColor = DSColor.pageLightDesc
        secondLabel.font = DSFont.paragraphSmall

        accountImageView.tintAdjustmentMode = .normal

    }
}
