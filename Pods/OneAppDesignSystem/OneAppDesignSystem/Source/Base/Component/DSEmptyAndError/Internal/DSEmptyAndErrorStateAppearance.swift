//
//  DSEmptyAndErrorStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/12/22.
//

import UIKit

protocol DSEmptyAndErrorStateAppearance {
    var imageViewWidth: CGFloat { get }
    var imageViewHeight: CGFloat { get }
    var titleFont: UIFont { get }
    var descriptionFont: UIFont { get }
    var imageBottomConstraint: CGFloat { get }
    var titleBottomConstraint: CGFloat { get }
}

extension DSEmptyAndErrorStateStyle: DSEmptyAndErrorStateAppearance {
    var imageViewWidth: CGFloat {
        switch self {
        case .iconSmall:
            return 32
        case .iconMedium:
            return 56
        case .imageSmall:
            return 240
        case .imageMedium:
            return 240
        }
    }
    
    var imageViewHeight: CGFloat {
        switch self {
        case .iconSmall:
            return 32
        case .iconMedium:
            return 56
        case .imageSmall:
            return 240
        case .imageMedium:
            return 240
        }
    }
    
    var titleFont: UIFont {
        switch self {
        case .iconSmall, .imageSmall:
            return DSFont.h3 ?? FontFamily.OneApp.bold.font(size: 16.0)
        case .iconMedium, .imageMedium:
            return DSFont.h2 ?? FontFamily.OneApp.bold.font(size: 20.0)
        }
    }
    
    var descriptionFont: UIFont {
        switch self {
        case .iconSmall:
            return DSFont.paragraphSmall ?? FontFamily.OneApp.regular.font(size: 14.0)
        case .iconMedium, .imageSmall, .imageMedium:
            return DSFont.paragraphMedium ?? FontFamily.OneApp.regular.font(size: 16.0)
        }
    }
    
    var imageBottomConstraint: CGFloat {
        switch self {
        case .iconSmall:
            return 8
        case .iconMedium:
            return 16
        case .imageSmall:
            return 16
        case .imageMedium:
            return 16
        }
    }
    
    var titleBottomConstraint: CGFloat {
        switch self {
        case .iconSmall:
            return 8
        case .iconMedium:
            return 16
        case .imageSmall:
            return 8
        case .imageMedium:
            return 16
        }
    }
}
