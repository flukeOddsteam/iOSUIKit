//
//  BottomSheetErrorViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/5/2567 BE.
//

import UIKit

enum ErrorBottomSheetType {
    case confirm
    case block
    case limitation
    case multipleCondition

    internal var hasCloseButton: Bool {
        switch self {
        case .confirm:
            return true
        case .block:
            return false
        case .limitation:
            return true
        case .multipleCondition:
            return false
        }
    }
    
    internal var hasGhostButton: Bool {
        switch self {
        case .confirm:
            return true
        case .block:
            return false
        case .limitation:
            return false
        case .multipleCondition:
            return false
        }
    }
    
    internal var hasDescription: Bool {
        switch self {
        case .confirm:
            return true
        case .block:
            return true
        case .limitation:
            return true
        case .multipleCondition:
            return false
        }
    }
    
    internal var hasMultipleCondition: Bool {
        switch self {
        case .confirm:
            return false
        case .block:
            return false
        case .limitation:
            return false
        case .multipleCondition:
            return true
        }
    }
}

struct ErrorBottomSheetViewModel {
    var title: String
    var description: String
    var primaryButtonTitle: String
    var ghostButtonTitle: String?
    var iconImage: UIImage
    var multipleConditionData: [MultipleConditionData]?
}

struct MultipleConditionData {
    var title: String
    var state: DSKeyHighlightConditionState
}
