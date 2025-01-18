//
//  DSMultipleTextFieldType.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 1/2/2567 BE.
//

import Foundation

public enum DSMultipleTextFieldType: Int {
    case single
    case double
    case triple
}

extension DSMultipleTextFieldType {
    var isPrimaryTextFieldHidden: Bool {
        return false
    }

    var isSecondaryTextFieldHidden: Bool {
        return self == .single
    }

    var isTertiaryTextFieldHidden: Bool {
        return self != .triple
    }
}
