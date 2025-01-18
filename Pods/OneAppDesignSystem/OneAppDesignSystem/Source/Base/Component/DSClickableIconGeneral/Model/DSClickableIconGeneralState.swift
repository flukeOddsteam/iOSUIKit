//
//  DSClickableIconGeneralState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2566 BE.
//

import UIKit

public enum DSClickableIconGeneralState {
    case active
    case disable
}

extension DSClickableIconGeneralState {
    var alpha: CGFloat {
        switch self {
        case .active:
            return 1
        case .disable:
            return 0.3
        }
    }

    var isUserInteractionEnabled: Bool {
        return self == .active
    }
}
