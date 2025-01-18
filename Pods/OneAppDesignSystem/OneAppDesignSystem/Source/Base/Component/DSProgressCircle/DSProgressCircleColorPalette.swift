//
//  DSProgressCircleColorPalette.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/3/2566 BE.
//

import UIKit

public enum DSProgressCircleColorPalette {
    case confidentBlue
    case trustedNavy
}

protocol ProgressCircleColorPaletteAppearance {
    var color: UIColor { get }
}

// MARK: - ProgressCircleColorPaletteAppearance
extension DSProgressCircleColorPalette: ProgressCircleColorPaletteAppearance {
    var color: UIColor {
        switch self {
        case .confidentBlue:
            return .primaryConfidentBlue
        case .trustedNavy:
            return .primaryTrustedNavy
        }
    }
}
