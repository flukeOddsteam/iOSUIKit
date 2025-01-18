//
//  TutorialVerticalDirection.swift
//  OneAppDesignSystem
//
//  Created by TTB on 15/7/2567 BE.
//

import Foundation

enum TutorialVerticalDirection {
    case top
    case bottom

    func value<T>(top: T, bottom: T) -> T {
        switch self {
        case .top:
            return top
        case .bottom:
            return bottom
        }
    }
}
