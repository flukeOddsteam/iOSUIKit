//
//  DSImage.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2565 BE.
//
import UIKit

public enum DSImage {
    case placeholder1x1
    case placeholder16x9
    case placeholder3x2
    case placeholder2x3
    case placeholderCircle16x9
    case searchIconImage
    case bookbankTTBAllFreeAccountActivate
    case bookbankTTBAllFreeAccountDeactivate
    case eDoc1x1
    case redirectExternalWebsite1x1
    
    public var image: UIImage {
        switch self {
        case .placeholder1x1: return SvgIcons.placeholder1x1.image
        case .placeholder16x9: return SvgIcons.placeholder16x9.image
        case .placeholder3x2: return SvgIcons.placeholder3x2.image
        case .placeholder2x3: return SvgIcons.placeholder2x3.image
        case .searchIconImage: return SvgIcons.searchIconImage.image
        case .placeholderCircle16x9: return SvgIcons.placeholderCircle16x9.image
        case .bookbankTTBAllFreeAccountActivate: return SvgIcons.bookbankTTBAllFreeAccountActivate.image
        case .bookbankTTBAllFreeAccountDeactivate: return SvgIcons.bookbankTTBAllFreeAccountDeactivate.image
        case .eDoc1x1: return SvgIcons.eDoc1x1.image
        case .redirectExternalWebsite1x1: return SvgIcons.redirectExternalWebsite1x1.image
        }
    }
}
