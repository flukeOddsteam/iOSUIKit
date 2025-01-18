//
//  DropdownFilterViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/11/2566 BE.
//

import UIKit

struct DropdownFilterViewModel {
    let state: DSDropdownState
    let hasSelected: Bool
    let helperTextValue: String
    let helperTextIsErrorValue: Bool
}

extension DropdownFilterViewModel: DropdownAppearance {
    var titleFont: Font? {
        return value(
            idle: DSFont.placeholder,
            focus: hasSelected ? DSFont.labelInput : DSFont.placeholder,
            selected: DSFont.labelInput,
            error: hasSelected ? DSFont.labelInput : DSFont.placeholder,
            disable: hasSelected ? DSFont.labelInput : DSFont.placeholder
        )
    }

    var isActiveTitleLabelTopMargin: Bool {
        return value(
            idle: false,
            focus: hasSelected,
            selected: true,
            error: hasSelected,
            disable: hasSelected
        )
    }

    var titleTextColor: UIColor {
        return value(
            idle: DSColor.componentLightPlaceholder,
            focus: hasSelected ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder,
            selected: DSColor.componentLightLabel,
            error: hasSelected ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder,
            disable: hasSelected ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder
        )
    }

    var borderColor: UIColor {
        return value(
            idle: DSColor.componentLightOutline,
            focus: DSColor.componentLightOutlineInputFocus,
            selected: DSColor.componentLightOutline,
            error: DSColor.componentLightError,
            disable: DSColor.componentDisableOutline
        )
    }

    var backgroundColor: UIColor {
        return value(
            idle: DSColor.componentLightBackground,
            focus: DSColor.componentLightBackground,
            selected: DSColor.componentLightBackground,
            error: DSColor.componentLightBackground,
            disable: DSColor.componentDisableBackground
        )
    }

    var textFieldIsUserInteractionEnabled: Bool {
        return false
    }

    var contentViewIsUserInteractionEnabled: Bool {
        return value(
            idle: true,
            focus: true,
            selected: true,
            error: true,
            disable: false
        )
    }

    var helperTextIsError: Bool {
        return value(
            idle: false,
            focus: helperTextIsErrorValue,
            selected: false,
            error: true,
            disable: false
        )
    }

    var helperText: String {
        switch state {
        case .error(let message):
            return message
        default:
            return helperTextValue
        }
    }

    var iconImageTintColor: UIColor {
        return value(
            idle: DSColor.componentLightDefault,
            focus: DSColor.componentLightDefault,
            selected: DSColor.componentLightDefault,
            error: DSColor.componentLightDefault,
            disable: DSColor.componentDisableDefault
        )
    }

    var buttonIsUserInteractionEnabled: Bool {
        return value(
            idle: true,
            focus: true,
            selected: true,
            error: true,
            disable: false
        )
    }

    var textFieldTextColor: UIColor {
        return value(
            idle: DSColor.componentLightDefault,
            focus: DSColor.componentLightDefault,
            selected: DSColor.componentLightDefault,
            error: DSColor.componentLightDefault,
            disable: hasSelected ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder
        )
    }

    var isHiddenHelperText: Bool {
        helperText.isEmpty
    }

    var isActiveTitleLabelYConstraint: Bool {
        !isActiveTitleLabelTopMargin
    }

}

private extension DropdownFilterViewModel {
    func value<T>(idle: T, focus: T, selected: T, error: T, disable: T) -> T {
        switch state {
        case .idle:
            return idle
        case .focus:
            return focus
        case .selected:
            return selected
        case .error:
            return error
        case .disable:
            return disable
        }
    }
}
