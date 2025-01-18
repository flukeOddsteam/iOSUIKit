//
//  DSRadioCardBenefitViewListViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/4/2566 BE.
//

import Foundation
import UIKit

public struct DSRadioCardBenefitViewModel {
    var image: DSRadioCardBenefitImageType
    var title: String
    var amount: String
    var amountUnit: String
    var isEnable: Bool
    
    public init(image: DSRadioCardBenefitImageType,
                title: String = "",
                amount: String = "",
                amountUnit: String = "",
                isEnable: Bool = true) {
        self.image = image
        self.title = title
        self.amount = amount
        self.amountUnit = amountUnit
        self.isEnable = isEnable
    }
}
