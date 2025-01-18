//
//  DSTutorialTooltipState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/7/2567 BE.
//

import Foundation

public enum DSTutorialTooltipState: Int, CaseIterable, Equatable {
    case inProgress
    case end
}

extension DSTutorialTooltipState {
    var isHiddenPrimaryButton: Bool {
        return self == .inProgress
    }
    
    var isHiddenSecondaryButton: Bool {
        return self == .end
    }
}
