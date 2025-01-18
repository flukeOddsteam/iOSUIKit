//
//  DSClickableIconSelectionStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/3/2566 BE.
//

import UIKit

public enum DSClickableIconSelectionStyle {
    case image(DSClickableIconSelectionImageType)
    case icon(DSIcons)
    case placeholderIcon
    case placeholderImage
}

public enum DSClickableIconSelectionImageType {
    case image(UIImage)
    case url(url: URL?, cacheable: Bool)
}

public enum DSClickableIconSelectionShape {
    case circle
    case rectangle
}
