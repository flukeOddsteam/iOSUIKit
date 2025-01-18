//
//  DSTutorialPosition.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/7/2567 BE.
//

import UIKit

public enum DSTutorialPosition: Int, Equatable, CaseIterable {
    case topLeft
    case topCenter
    case topRight
    case bottomLeft
    case bottomCenter
    case bottomRight
}

extension DSTutorialPosition {
    var direction: TutorialVerticalDirection {
        switch self {
        case .topLeft, .topCenter, .topRight:
            return .top
        case .bottomLeft, .bottomCenter, .bottomRight:
            return .bottom
        }
    }
}
