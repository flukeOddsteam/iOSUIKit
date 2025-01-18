//
//  DSListExpandContentState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/3/2566 BE.
//

import UIKit

public enum DSListExpandContentState {
    case expand
    case collapse
    
    var iconImage: UIImage {
        switch self {
        case .expand:
            return DSIcons.icon24OutlineChevronUp.image
        case .collapse:
            return DSIcons.icon24OutlineChevronDown.image
        }
    }

    var inverse: DSListExpandContentState {
        self == .collapse ? .expand : .collapse
    }
}
