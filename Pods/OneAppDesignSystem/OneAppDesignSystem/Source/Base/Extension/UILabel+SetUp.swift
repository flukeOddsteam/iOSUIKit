//
//  UILabel+SetUp.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/5/24.
//

import UIKit

public extension UILabel {
    func setUp(
        font: UIFont?,
        textColor: UIColor = DSColor.pageLightTextDefault,
        numberOfLines: Int = 0
    ) {
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
}
