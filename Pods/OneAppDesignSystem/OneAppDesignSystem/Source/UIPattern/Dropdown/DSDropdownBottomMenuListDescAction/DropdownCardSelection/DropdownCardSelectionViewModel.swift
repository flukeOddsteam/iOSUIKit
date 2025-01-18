//
//  CardSelectionViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/5/2567 BE.
//

import UIKit

enum DropdownCardSelectionIconSize {
    case medium
    case large
}

extension DropdownCardSelectionIconSize {
    var iconSize: CGSize {
        switch self {
        case .medium:
            return CGSize(width: 24, height: 24)
        case .large:
            return CGSize(width: 36, height: 36)
        }
    }
    
    var containerSize: CGSize {
        switch self {
        case .medium:
            return CGSize(width: 40, height: 40)
        case .large:
            return CGSize(width: 52, height: 52)
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .medium:
            return 20
        case .large:
            return 26
        }
    }
}

struct DropdownCardSelectionViewModel {
    var tagId: Int
    var titleText: String
    var descriptionText: String
    var iconImage: DSIcons
    var iconSize: DropdownCardSelectionIconSize
}

typealias DropdownCardSelectionAction = ((_ currentState: DropdownCardSelectionState) -> Void)
