//
//  RadioCardBenefitCollectionViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 25/4/2566 BE.
//

import UIKit

final class RadioCardBenefitCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    // MARK: - IBOutlet
    @IBOutlet weak var radioCardBenefit: RadioCardBenefit!
        
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    public func setup(style: DSSelectionRadioCardBenefitListStyle = .card, viewModel: DSRadioCardBenefitViewModel, isSelected: Bool) {
        let state: DSSelectionRadioState = viewModel.isEnable ? isSelected ? .selected : .default : .disableUnselected
        self.radioCardBenefit.setup(image: viewModel.image,
                                    title: viewModel.title,
                                    amount: viewModel.amount,
                                    amountUnit: viewModel.amountUnit,
                                    style: style,
                                    state: state)
        self.isUserInteractionEnabled = viewModel.isEnable
    }
}

// MARK: - Private
private extension RadioCardBenefitCollectionViewCell {
    func commonInit() {
        self.radioCardBenefit.isUserInteractionEnabled = false
    }
}
