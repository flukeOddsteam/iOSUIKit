//
//  DSListActionMenuImageType.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/7/23.
//

import UIKit

public enum DSListActionMenuImageType {
    case icon(DSIcons)
    case image(UIImage)
    case url(URL?, placeholder: UIImage? = nil)
}
