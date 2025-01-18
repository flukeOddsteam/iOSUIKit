//
//  DSStepProgressBarVerticalState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/12/2566 BE.
//

import UIKit

public enum DSStepProgressBarVerticalState: Equatable, Hashable {
    case defaultDynamic(String)
    case defaultStatic(String)
    case progress(String)
    case success
    case error
    case warning
    case informative
    case disable(String)
}
