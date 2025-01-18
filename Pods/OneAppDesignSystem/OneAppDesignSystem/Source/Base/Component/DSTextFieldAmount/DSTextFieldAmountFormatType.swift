//
//  DSTextFieldAmountDigitType.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 1/2/2567 BE.
//

import UIKit

public enum DSTextFieldAmountFormatType {
    case integer
    case decimal
}

extension DSTextFieldAmountFormatType {
    var maximumFractionDigits: Int {
        switch self {
        case .integer:
            return .zero
        case .decimal:
            return 2
        }
    }

    var minimumFractionDigits: Int {
        switch self {
        case .integer:
            return .zero
        case .decimal:
            return 2
        }
    }

    var placeholder: String {
        switch self {
        case .integer:
            return "0"
        case .decimal:
            return "0.00"
        }
    }

    var keyboard: UIKeyboardType {
        switch self {
        case .integer:
            return .numberPad
        case .decimal:
            return .decimalPad
        }
    }
}
