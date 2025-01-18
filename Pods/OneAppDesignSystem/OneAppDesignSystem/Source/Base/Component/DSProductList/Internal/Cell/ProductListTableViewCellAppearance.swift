//
//  DSProductListTableViewCellAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/3/2566 BE.
//

import UIKit

protocol ProductListTableViewCellAppearanceInterface {
    var placeHolderImage: UIImage { get }
    var imageAspectRatio: CGFloat { get }
    
    func showSeparatorLine(rowIndex: Int, contents: Int) -> Bool
}

extension ProductListTableViewCellStyle: ProductListTableViewCellAppearanceInterface {
    func showSeparatorLine(rowIndex: Int, contents: Int) -> Bool {
        switch rowIndex {
        case contents - 1:
            return true
        default:
           return false
        }
    }
    
    var placeHolderImage: UIImage {
        switch self {
        case .imageAspectRatio(let ratio):
            switch ratio {
            case .ratio3x2:
                return SvgIcons.placeholder3x2.image
            case .ratio16x9:
                return SvgIcons.placeholder16x9.image
            default:
                return SvgIcons.placeholder1x1.image
            }
        default:
            return SvgIcons.placeholder1x1.image
        }
    }
    
    var imageAspectRatio: CGFloat {
        switch self {
        case .imageAspectRatio(let ratio):
            switch ratio {
            case .ratio3x2:
                return DSRatio.ratio3x2.rawValue
            case .ratio16x9:
                return DSRatio.ratio16x9.rawValue
            default:
                return DSRatio.ratio1x1.rawValue
            }
        default:
            return DSRatio.ratio1x1.rawValue
        }
    }
}
