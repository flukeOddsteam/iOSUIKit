//
//  DSFullPageUploadStyle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/7/2567 BE.
//

import UIKit

public enum DSFullPageUploadStyle: Equatable {
    case overlay
    case none
}

protocol DSFullPageUploadAppearanceStyle {
    var backgroundColor: UIColor { get }
}

extension DSFullPageUploadStyle: DSFullPageUploadAppearanceStyle {
    var backgroundColor: UIColor {
        switch self {
        case .overlay:
            return DSColor.otherBackgroundOverlayScreen
        case .none:
            return DSColor.otherBackgroundOverlayWhiteLoading
        }
    }
}
