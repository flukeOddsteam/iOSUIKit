//
//  DSOfferingCardType.swift
//  OneAppDesignSystem
//
//  Created by TTB on 25/4/2567 BE.
//

import Foundation

extension DSOfferingCard {

    public enum DSOfferingCardType {
        case backgroundImage(viewModel: DSOfferingCardViewModel.BackgroundImageViewModel)
        case imageLeft(viewModel: DSOfferingCardViewModel.ImageLeftViewModel)
    }
}

extension DSOfferingCard.DSOfferingCardType {
    var isHiddenBackgroundImageView: Bool {
        switch self {
        case .backgroundImage:
            return false
        case .imageLeft:
            return true
        }
    }

    var isHiddenImageLeftView: Bool {
        switch self {
        case .backgroundImage:
            return true
        case .imageLeft:
            return false
        }
    }
}
