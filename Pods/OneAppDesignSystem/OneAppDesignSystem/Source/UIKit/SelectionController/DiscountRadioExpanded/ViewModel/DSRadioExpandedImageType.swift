//
//  DSRadioExpandedImageType.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/9/2567 BE.
//

import UIKit

public enum DSRadioExpandedImageType {
    case image(UIImage)
    case url(
        URL?,
        placeholder: UIImage? = nil,
        cacheable: Bool = true
    )
}
