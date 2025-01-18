//
//  DSButtonGestureEvent.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/11/2566 BE.
//

import Foundation

enum DSButtonGestureEvent {
    case began
    case end
    case cancelled

    var isTouchEvent: Bool {
        switch self {
        case .began:
            return true
        case .end, .cancelled:
            return false
        }
    }
}
