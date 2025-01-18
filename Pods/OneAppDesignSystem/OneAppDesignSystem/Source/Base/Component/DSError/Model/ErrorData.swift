//
//  ErrorData.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/5/2567 BE.
//

import Foundation

struct ErrorData: Decodable {
    var type: String?
    var subType: String?
    var multipleCondition: [MultipleCondition]?
    var illustration: String?
    var icon: String?
    var primaryButton: String?
    var ghostButton: String?
    var title: String?
    var desc: String?
}

struct MultipleCondition: Decodable {
    var phrase: String?
    var param: String?
}

// MARK: - Enums
extension ErrorData {
    enum ErrorType: String, Decodable {
        case bottomSheet
        case fullPage

        func value<T>(bottomSheet: T, fullPage: T) -> T {
            switch self {
            case .bottomSheet:
                return bottomSheet
            case .fullPage:
                return fullPage
            }
        }
    }

    enum ErrorBottomSheetSubType: String, Decodable {
        case block
        case confirm
        case limitation
        case multipleCondition

        func value<T>(block: T, confirm: T, limitation: T, multipleCondition: T) -> T {
            switch self {
            case .block:
                return block
            case .confirm:
                return confirm
            case .limitation:
                return limitation
            case .multipleCondition:
                return multipleCondition
            }
        }
    }
}
