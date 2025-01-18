//
//  DropdownViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 15/11/2566 BE.
//

import UIKit
protocol DropdownAppearance {
    var titleFont: Font? { get }
    var isActiveTitleLabelTopMargin: Bool { get }
    var titleTextColor: UIColor { get }
    var borderColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var textFieldIsUserInteractionEnabled: Bool { get }
    var contentViewIsUserInteractionEnabled: Bool { get }
    var helperTextIsError: Bool { get }
    var helperText: String { get }
    var iconImageTintColor: UIColor { get }
    var buttonIsUserInteractionEnabled: Bool { get }
    var textFieldTextColor: UIColor { get }
    var isHiddenHelperText: Bool { get }
    var isActiveTitleLabelYConstraint: Bool { get }
}

struct DropdownViewModel {
    let state: DSDropdownState
    let previousState: DSDropdownState
    let hasSelected: Bool
    let helperTextValue: String
    let helperTextIsErrorValue: Bool
}

extension DropdownViewModel: DropdownAppearance {
    var titleFont: Font? {
        return value(
            state: state,
            idle: hasSelected ? DSFont.labelInput : DSFont.placeholder,
            focus: hasSelected ? DSFont.labelInput : DSFont.placeholder,
            selected: DSFont.labelInput,
            error: hasSelected ? DSFont.labelInput : DSFont.placeholder,
            disable: hasSelected ? DSFont.labelInput : DSFont.placeholder
        )
    }

    var isActiveTitleLabelTopMargin: Bool {
        return hasSelected
    }

    var titleTextColor: UIColor {
        return value(
            state: state,
            idle: hasSelected ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder,
            focus: hasSelected ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder,
            selected: DSColor.componentLightLabel,
            error: hasSelected ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder,
            disable: hasSelected ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder
        )
    }

    var borderColor: UIColor {
        return value(
            state: state,
            idle: DSColor.componentLightOutline,
            focus: DSColor.componentLightOutlineInputFocus,
            selected: DSColor.componentLightOutline,
            error: DSColor.componentLightError,
            disable: DSColor.componentDisableOutline
        )
    }

    var backgroundColor: UIColor {
        return value(
            state: state,
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
            state: state,
            idle: true,
            focus: true,
            selected: true,
            error: true,
            disable: false
        )
    }

    var helperTextIsError: Bool {
        return value(
            state: state,
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
        case .focus:
            switch previousState {
            case .error(let message):
                return message
            default:
                return helperTextValue
            }
        default:
            return helperTextValue
        }
    }

    var iconImageTintColor: UIColor {
        return value(
            state: state,
            idle: DSColor.componentLightDefault,
            focus: DSColor.componentLightDefault,
            selected: DSColor.componentLightDefault,
            error: DSColor.componentLightDefault,
            disable: DSColor.componentDisableDefault
        )
    }

    var buttonIsUserInteractionEnabled: Bool {
        return value(
            state: state,
            idle: true,
            focus: true,
            selected: true,
            error: true,
            disable: false
        )
    }

    var textFieldTextColor: UIColor {
        return value(
            state: state,
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

private extension DropdownViewModel {
    func value<T>(state: DSDropdownState, idle: T, focus: T, selected: T, error: T, disable: T) -> T {
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
