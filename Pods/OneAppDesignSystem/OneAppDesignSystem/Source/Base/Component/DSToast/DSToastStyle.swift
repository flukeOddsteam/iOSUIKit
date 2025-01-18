//
//  DSToastStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/11/2565 BE.
//

import UIKit

public enum DSToastStyle {
    case success
    case information
}

extension DSToastStyle {
    var iconImage: UIImage {
        switch self {
        case .success:
            return DSIcons.icon16CheckCircle.image
        case .information:
            return DSIcons.icon16Info.image
        }
    }
}
