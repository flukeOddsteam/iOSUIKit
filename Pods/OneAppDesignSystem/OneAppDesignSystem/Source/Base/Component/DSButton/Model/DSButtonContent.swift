//
//  DSButtonContent.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/11/2566 BE.
//

import UIKit

enum DSButtonContent {
    case iconOnly(image: UIImage)
    case iconLeftAndText(image: UIImage, text: String)
    case iconRightAndText(image: UIImage, text: String)
    case textOnly(text: String)
    case iconLeftNoPaddingAndText(image: UIImage, text: String)
    case iconRightNoPaddingAndText(image: UIImage, text: String)
    case iconRightNoPaddingLeftAndRight(image: UIImage, text: String)
    case iconLeftNoPaddingLeftAndRight(image: UIImage, text: String)
    case textOnlyNoPadding(text: String)
}
