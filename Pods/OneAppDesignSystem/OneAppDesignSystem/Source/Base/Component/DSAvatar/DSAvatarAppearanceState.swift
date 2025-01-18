//
//  DSAvatarAppearanceState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/3/2566 BE.
//

import UIKit

public typealias DSAvatarAppearanceAction = ((_ currentState: DSAvatarState) -> Void)

/// Enum selectionAvatar state
public enum DSAvatarState {
    /// Normal State before being tapped on.
    case `default`
    /// State disable SelectionRadio field.
    case disable
}
