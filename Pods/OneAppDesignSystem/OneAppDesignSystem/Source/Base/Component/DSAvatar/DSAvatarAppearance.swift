//
//  DSAvatarAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/2/2566 BE.
//

import UIKit

protocol DSAvatarAppearance {
    var borderWidth: CGFloat { get }
    var borderColor: UIColor { get }
    var placeHolderImage: UIImage { get }
}

extension DSAvatarStyle: DSAvatarAppearance {
    
    var placeHolderImage: UIImage {
        switch self {
        case .profile:
            return SvgIcons.dsAvatarProfilePlaceholder1x1.image
        case .entity:
            return SvgIcons.placeholder1x1.image
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .profile:
            return UIColor.clear
        case .entity:
            return DSColor.componentLightOutlineClickable
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .profile:
            return 0.0
        default:
            return 1.0
        }
    }
}
