//
//  DSSelectionRadioCardBenefitListAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 25/4/2566 BE.
//

import Foundation
import UIKit

extension DSSelectionRadioCardBenefitListStyle {
    
    var placeHolderImage: UIImage {
        switch self {
        case .card:
            return SvgIcons.placeholderSmall16x9.image
        case .icon:
            return SvgIcons.placeholderCircle16x9.image
        }
    }
}
