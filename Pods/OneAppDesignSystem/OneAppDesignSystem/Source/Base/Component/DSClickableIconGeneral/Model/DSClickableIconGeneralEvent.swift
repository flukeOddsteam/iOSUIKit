//
//  DSClickableIconGeneralEvent.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2566 BE.
//

import Foundation

public enum DSClickableIconGeneralEvent {
    case begin
    case end
    case cancelled
}

extension DSClickableIconGeneralEvent {
    var isHiddenShadow: Bool {
        switch self {
        case .begin:
            return true
        case .end, .cancelled:
            return false
        }
    }
}
