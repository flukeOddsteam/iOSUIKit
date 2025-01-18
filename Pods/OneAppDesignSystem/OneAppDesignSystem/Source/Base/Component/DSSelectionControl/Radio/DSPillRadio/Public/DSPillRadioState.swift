//
//  DSPillRadioState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/10/22.
//

import Foundation

/// Declare DSPillRadioAction to be type of action for DSPillRadioView
public typealias DSPillRadioAction = (() -> Void)

/// Enum DSPillRadioView and DSPillRadio state
public enum DSPillRadioState {
    case `default`
    case selected
    case disable
}
