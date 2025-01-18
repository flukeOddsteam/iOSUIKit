//
//  DSEmptyAndErrorStateStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/12/22.
//

import UIKit

public enum DSEmptyAndErrorStateStyle {
    case iconSmall(image: UIImage)
    case iconMedium(image: UIImage)
    case imageSmall(image: DSEmptyAndErrorStateImageType)
    case imageMedium(imageType: DSEmptyAndErrorStateImageType)
}

public enum DSEmptyAndErrorStateImageType {
    case image(UIImage)
    case url(URL?, placeholder: UIImage?)
}
