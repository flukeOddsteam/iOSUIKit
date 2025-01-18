//
//  DSBottonSheetMenuListDescriptionImageStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/3/2566 BE.
//

import UIKit

public enum DSBottonSheetMenuListDescriptionImageStyle {
    case image(type: DSBottonSheetMenuListDescriptionImageType)
    case icon(DSIcons, iconSize: DSBottonSheetMenuListDescriptionIconSize)
}

public enum DSBottonSheetMenuListDescriptionImageType {
    case image(UIImage)
    case url(url: URL?, cacheable: Bool)
}

public enum DSBottonSheetMenuListDescriptionIconSize: CGFloat {
    case size24px = 24
    case size32px = 32
}
