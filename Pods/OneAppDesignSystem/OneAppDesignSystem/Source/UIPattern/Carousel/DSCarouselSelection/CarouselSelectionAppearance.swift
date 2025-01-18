//
//  CarouselSelectionAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/8/2567 BE.
//

protocol CarouselSelectionAppearanceType {
    var aspectRatio: CGFloat { get }
    var maxHeight: CGFloat { get }
}

extension DSCarouselSelectionType: CarouselSelectionAppearanceType {
    var aspectRatio: CGFloat {
        switch self {
        case .slip:
            return 10 / 16
        case .credit:
            return 16 / 10
        case .debit:
            return 10 / 16
        }
    }
    
    var maxHeight: CGFloat {
        switch self {
        case .slip:
            return 338
        case .credit:
            return 177.3
        case .debit:
            return 268.2
        }
    }
}
