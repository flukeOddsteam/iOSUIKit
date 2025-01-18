//
//  DSListMessageRatioCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import UIKit

class DSListMessageRatioCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var valueText: UILabel!
    @IBOutlet weak var widthRatio: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelText.font = DSFont.labelList
        labelText.textColor = DSColor.componentLightLabel
        valueText.font = DSFont.labelList
        valueText.textColor = DSColor.componentLightDefault
        self.backgroundColor = DSColor.componentSummaryBackground
        widthRatio = widthRatio.setMultiplier(multiplier: 1)
    }

    func setup(label: String, value: String, ratio: CGFloat = 1) {
        labelText.text = label
        valueText.text = value
        widthRatio = widthRatio.setMultiplier(multiplier: ratio)
    }
    
    func setAccessibilityIdentifier(labelTextId: String, valueTextId: String) {
        self.labelText.accessibilityIdentifier = labelTextId
        self.valueText.accessibilityIdentifier = valueTextId
    }
}
