//
//  ButtonViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/11/2566 BE.
//

import UIKit

struct ButtonViewModel {
    let style: DSButtonStyle
    let onTouch: Bool
}

extension ButtonViewModel: ButtonAppearance {
    var highlightColor: UIColor {
        return style.value(primary: onTouch ? DSColor.componentPrimaryBackgroundOnPress : DSColor.componentPrimaryBackground,
                           secondary: onTouch ? DSColor.componentSecondaryBackgroundOnPress : DSColor.componentSecondaryBackground,
                           ghost: onTouch ? DSColor.componentGhostBackgroundOnPress : DSColor.componentGhostBackground,
                           ghostDark: onTouch ? DSColor.pageDarkComponentGhostOnPress : DSColor.pageDarkComponentGhostBackground)
    }
}
