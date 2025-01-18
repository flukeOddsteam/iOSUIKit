//
//  DSContentListStyleLayout.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import UIKit

protocol DSContentListStyleLayout {
    var numberOfColumn: Int { get }
    var horizontalCellSpacing: CGFloat { get }
    var verticalCellSpacing: CGFloat { get }
    var contentInset: UIEdgeInsets { get }
}

extension DSContentListStyle: DSContentListStyleLayout {
    var numberOfColumn: Int {
        switch self {
        case .vertical:
            return 2
        case .horizontal:
            return 1
        }
    }
    
    var horizontalCellSpacing: CGFloat {
        return 16
    }
    
    var verticalCellSpacing: CGFloat {
        switch self {
        case .vertical:
            return 16
        case .horizontal:
            return .zero
        }
    }
    
    var contentInset: UIEdgeInsets {
        switch self {
        case .vertical:
            return UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        case .horizontal:
            return .zero
        }
    }
}
