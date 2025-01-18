//
//  DSTextFieldAmountType.swift
//  OneAppDesignSystem
//
//  Created by TTB on 18/1/2566 BE.
//

import UIKit

public enum DSTextFieldAmountType {
    case general
    case transaction
}

extension DSTextFieldAmountType {
    var font: UIFont? {
        switch self {
        case .general:
            return DSFont.paragraphMedium
        case .transaction:
            return DSFont.h1
        }
    }
    
    var textFieldHeight: CGFloat {
        switch self {
        case .general: return 60
        case .transaction: return 72
        }
    }
}
