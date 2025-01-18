//
//  DSMessageBoxOfferingBackgroundImageType.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/1/2567 BE.
//

import UIKit

public enum DSMessageBoxOfferingBackgroundImageType {
    case image(UIImage)
    case url(URL?, placeholder: UIImage?, cacheable: Bool)
}
