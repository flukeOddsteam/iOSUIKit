//
//  DSStickyButtonAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 11/11/24.
//

import UIKit

public enum DSStickyButtonValueSize {
    case small
    case large

    var size: UIFont? {
        switch self {
        case .small:
            return DSFont.h3
        case .large:
            return DSFont.h2
        }
    }
}
