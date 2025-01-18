//
//  SelectionCheckBoxBuilder.swift
//  OneAppDesignSystem
//
//  Created by ttb on 21/5/2567 BE.
//

import UIKit

struct CheckboxAppearanceViewModel {
    let titleColor: UIColor
    let borderColor: UIColor
    let backgroundColor: UIColor
    let viewContentCheckboxColor: UIColor
    let alpha: CGFloat
}

class SelectionCheckBoxBuilder {
    
    func build(state: DSSelectionCheckboxState, type: DSSelectionCheckboxType, theme: DSSelectionCheckboxTheme) -> CheckboxAppearanceViewModel {
        switch theme {
        case .light:
            return buildLightTheme(state: state, type: type)
        case .dark:
            return buildDarkTheme(state: state, type: type)
        }
    }
    
}

private extension SelectionCheckBoxBuilder {
    func buildLightTheme(state: DSSelectionCheckboxState, type: DSSelectionCheckboxType) -> CheckboxAppearanceViewModel {
        switch type {
        case .default:
            return buildLightDefaultType(state: state)
        case .softLabel:
            return buildLightSoftLabelType(state: state)
        }
    }
    
    func buildLightDefaultType(state: DSSelectionCheckboxState) -> CheckboxAppearanceViewModel {
        switch state {
        case .checked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentLightDefault,
                borderColor: .clear,
                backgroundColor: DSColor.componentPrimaryBackground,
                viewContentCheckboxColor: .white,
                alpha: 1.0
            )
        case .disableChecked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentDisableDefault,
                borderColor: .clear,
                backgroundColor: DSColor.componentDisableBackgroundSecondary,
                viewContentCheckboxColor: .white,
                alpha: 1.0
            )
        case .disableUnchecked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentDisableDefault,
                borderColor: DSColor.componentDisableOutline,
                backgroundColor: DSColor.componentDisableBackground,
                viewContentCheckboxColor: .white,
                alpha: 1.0
            )
        case .default:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentLightDefault,
                borderColor: DSColor.componentLightDefault,
                backgroundColor: DSColor.componentLightBackground,
                viewContentCheckboxColor: .white,
                alpha: 1.0
            )
        }
    }
    
    func buildLightSoftLabelType(state: DSSelectionCheckboxState) -> CheckboxAppearanceViewModel {
        switch state {
        case .checked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentLightOutlineSoft,
                borderColor: .clear,
                backgroundColor: DSColor.componentPrimaryBackground,
                viewContentCheckboxColor: .white,
                alpha: 1.0
            )
        case .disableChecked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentDisableDefault,
                borderColor: .clear,
                backgroundColor: DSColor.componentDisableBackgroundSecondary,
                viewContentCheckboxColor: .white,
                alpha: 1.0
            )
        case .disableUnchecked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentDisableDefault,
                borderColor: DSColor.componentDisableOutline,
                backgroundColor: DSColor.componentDisableBackground,
                viewContentCheckboxColor: .white,
                alpha: 1.0
            )
        case .default:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentDisableDefault,
                borderColor: DSColor.componentLightOutlineSoft,
                backgroundColor: DSColor.componentLightBackground,
                viewContentCheckboxColor: .white,
                alpha: 1.0
            )
        }
    }
    
    func buildDarkTheme(state: DSSelectionCheckboxState, type: DSSelectionCheckboxType) -> CheckboxAppearanceViewModel {
        switch type {
        case .default:
            return buildDarkDefaultType(state: state)
        case .softLabel:
            return buildDarkSoftLabelType(state: state)
        }
    }
    
    func buildDarkDefaultType(state: DSSelectionCheckboxState) -> CheckboxAppearanceViewModel {
        switch state {
        case .checked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentLightBackground,
                borderColor: DSColor.componentLightBackground,
                backgroundColor: DSColor.componentPrimaryBackground,
                viewContentCheckboxColor: DSColor.pageDarkBackground,
                alpha: 1.0
            )
        case .disableChecked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentDisableDefaultOnDark,
                borderColor: .clear,
                backgroundColor: DSColor.componentDisableBackgroundSecondaryOnDark,
                viewContentCheckboxColor: DSColor.pageDarkBackground,
                alpha: 0.7
            )
        case .disableUnchecked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentDisableDefaultOnDark,
                borderColor: DSColor.componentDisableDefaultOnDark,
                backgroundColor: DSColor.componentDisableBackgroundPrimaryOnDark,
                viewContentCheckboxColor: DSColor.pageDarkBackground,
                alpha: 0.7
            )
        case .default:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentLightBackground,
                borderColor: DSColor.componentLightBackground,
                backgroundColor: DSColor.componentLightBackground,
                viewContentCheckboxColor: DSColor.pageDarkBackground,
                alpha: 1.0
            )
        }
    }
    
    func buildDarkSoftLabelType(state: DSSelectionCheckboxState) -> CheckboxAppearanceViewModel {
        switch state {
        case .checked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentLightBackground,
                borderColor: .clear,
                backgroundColor: DSColor.componentPrimaryBackground,
                viewContentCheckboxColor: DSColor.pageDarkBackground,
                alpha: 1.0
            )
        case .disableChecked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentDisableDefaultOnDark,
                borderColor: .clear,
                backgroundColor: DSColor.componentDisableBackgroundSecondaryOnDark,
                viewContentCheckboxColor: DSColor.pageDarkBackground,
                alpha: 0.7
            )
        case .disableUnchecked:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentDisableDefaultOnDark,
                borderColor: DSColor.componentDisableDefaultOnDark,
                backgroundColor: DSColor.componentDisableBackgroundPrimaryOnDark,
                viewContentCheckboxColor: DSColor.pageDarkBackground,
                alpha: 0.7
            )
        case .default:
            return CheckboxAppearanceViewModel(
                titleColor: DSColor.componentLightBackgroundXSoftOnDark,
                borderColor: .clear,
                backgroundColor: DSColor.componentLightBackgroundXSoftOnDark,
                viewContentCheckboxColor: DSColor.pageDarkBackground,
                alpha: 1.0
            )
        }
    }
}
