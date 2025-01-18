//
//  RadioListMessageAccentCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/9/2567 BE.
//

import UIKit

final class RadioListMessageAccentCell: UITableViewCell, NibLoadable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var subValueLabel: UILabel!
    @IBOutlet weak var widthLeftContainerConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(viewModel: DSRadioListMessageViewModel.ListItemViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        subValueLabel.setStrikeThrough(text: viewModel.subValue ?? "")
        widthLeftContainerConstraint.setMultiplier(multiplier: viewModel.ratio)
    }
}

// MARK: - Private
private extension RadioListMessageAccentCell {
    func setupUI() {
        selectionStyle = .none
        
        titleLabel.setUp(
            font: DSFont.labelList,
            textColor: DSColor.componentLightLabel,
            numberOfLines: .zero
        )
        
        valueLabel.setUp(
            font: DSFont.valueList,
            textColor: DSColor.componentLightOutcome,
            numberOfLines: .zero
        )
        
        subValueLabel.setUp(
            font: DSFont.labelInput,
            textColor: DSColor.componentSummaryDesc,
            numberOfLines: .zero
        )
    }
}
