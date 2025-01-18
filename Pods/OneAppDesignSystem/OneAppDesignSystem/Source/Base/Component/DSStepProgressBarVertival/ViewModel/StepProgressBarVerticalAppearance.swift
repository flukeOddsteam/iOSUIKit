//
//  StepProgressBarVerticalAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/12/2566 BE.
//

import UIKit

protocol StepProgressBarVerticalAppearance {
    var progressText: String? { get }
    var iconImage: DSIcons? { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var circleBackgroundColor: UIColor { get }
    var lineColor: UIColor { get }
    var textColor: UIColor { get }
    var isHiddenLabel: Bool { get }
    var isHiddenImage: Bool { get }
}

extension DSStepProgressBarVerticalState: StepProgressBarVerticalAppearance {
    var progressText: String? {
        switch self {
        case .defaultDynamic(let string):
            return string
        case .defaultStatic(let string):
            return string
        case .progress(let string):
            return string
        case .success, .error, .warning, .informative:
            return nil
        case .disable(let string):
            return string
        }
    }

    var iconImage: DSIcons? {
        return value(defaultDynamic: nil,
                     defaultStatic: nil,
                     progress: nil,
                     success: DSIcons.icon16CheckStepProgressBar,
                     error: DSIcons.icon16Close,
                     warning: DSIcons.icon16WarningNoFill,
                     informative: DSIcons.icon16InfoNoFill,
                     disable: nil)
    }

    var borderColor: UIColor {
        return value(defaultDynamic: DSColor.componentLightOutline,
                     defaultStatic: .clear,
                     progress: .clear,
                     success: .clear,
                     error: .clear,
                     warning: .clear,
                     informative: .clear,
                     disable: .clear)
    }

    var borderWidth: CGFloat {
        return value(defaultDynamic: 1,
                     defaultStatic: .zero,
                     progress: .zero,
                     success: .zero,
                     error: .zero,
                     warning: .zero,
                     informative: .zero,
                     disable: .zero)
    }

    var circleBackgroundColor: UIColor {
        return value(defaultDynamic: .clear,
                     defaultStatic: DSColor.componentLightDefault,
                     progress: DSColor.componentLightDefault,
                     success: DSColor.componentLightIncome,
                     error: DSColor.componentErrorOutlineIcon,
                     warning: DSColor.componentCustomBackgroundBackgroundWarning,
                     informative: DSColor.componentinformativeOutlineIcon,
                     disable: DSColor.componentDisableDefault)
    }

    var lineColor: UIColor {
        return value(defaultDynamic: DSColor.componentLightOutline,
                     defaultStatic: DSColor.componentLightOutline,
                     progress: DSColor.componentLightDefault,
                     success: DSColor.componentLightIncome,
                     error: DSColor.componentErrorOutlineIcon,
                     warning: DSColor.componentWarningOutlineIcon,
                     informative: DSColor.componentinformativeOutlineIcon,
                     disable: DSColor.componentDisableOutline)
    }

    var textColor: UIColor {
        return value(defaultDynamic: DSColor.componentLightDesc,
                     defaultStatic: DSColor.componentLightBackground,
                     progress: DSColor.componentLightBackground,
                     success: .clear,
                     error: .clear,
                     warning: .clear,
                     informative: .clear,
                     disable: DSColor.componentDisableBackground)
    }

    var isHiddenLabel: Bool {
        return value(defaultDynamic: false,
                     defaultStatic: false,
                     progress: false,
                     success: true,
                     error: true,
                     warning: true,
                     informative: true,
                     disable: false)
    }

    var isHiddenImage: Bool {
        return value(defaultDynamic: true,
                     defaultStatic: true,
                     progress: true,
                     success: false,
                     error: false,
                     warning: false,
                     informative: false,
                     disable: true)
    }
}

// MARK: - Private
private extension DSStepProgressBarVerticalState {
    func value<T>(defaultDynamic: T,
                  defaultStatic: T,
                  progress: T,
                  success: T,
                  error: T,
                  warning: T,
                  informative: T,
                  disable: T) -> T {
        switch self {
        case .defaultDynamic:
            return defaultDynamic
        case .defaultStatic:
            return defaultStatic
        case .progress:
            return progress
        case .success:
            return success
        case .error:
            return error
        case .warning:
            return warning
        case .informative:
            return informative
        case .disable:
            return disable
        }
    }
}
