//
//  DSDividerOrientation.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 8/11/2566 BE.
//

import Foundation

public enum DSDividerOrientation {
    case vertical
    case horizontal

    var isActiveWidth: Bool {
        self == .vertical
    }

    var isActiveHeight: Bool {
        self == .horizontal
    }
}
