//
//  TextFieldViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/12/2566 BE.
//

import UIKit

struct TextFieldViewModel {
    let state: DSTextFieldState
    let textValue: String
    let helperTextValue: String

    private var hasTextValue: Bool {
        return textValue.isNotEmpty
    }
}

// MARK: - DSTextFieldAppearance
extension TextFieldViewModel: TextFieldAppearance {
    var titleTextColor: UIColor {
        switch state {
        case .focus:
            return DSColor.componentLightLabel
        default:
            return hasTextValue ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder
        }
    }
    
    var titleFont: UIFont? {
        switch state {
        case .focus:
            return DSFont.labelInput
        default:
            return hasTextValue ? DSFont.labelInput : DSFont.placeholder
        }
    }
    
    var helperText: String {
        switch state {
        case .error(let message):
            return message
        default:
            return helperTextValue
        }
    }
    
    var isHiddenHelperTextView: Bool {
        switch state {
        case .error(let message):
            return message.isEmpty
        default:
            return helperTextValue.isEmpty
        }
    }
    
    var isActiveTitleLabelTopMargin: Bool {
        switch state {
        case .focus:
            return true
        default:
            return hasTextValue
        }
    }
    
    var isActiveTitleLabelCenterYConstraint: Bool {
        return !isActiveTitleLabelTopMargin
    }
    
    var textColor: UIColor {
        switch state {
        case .default, .focus, .filled, .error:
            return DSColor.componentLightDefault
        case .disable:
            return DSColor.componentLightLabel
        }
    }

    var borderColor: UIColor {
        switch state {
        case .default, .filled:
            return DSColor.componentLightOutline
        case .focus:
            return DSColor.componentLightOutlineInputFocus
        case .error:
            return DSColor.componentLightError
        case .disable:
            return DSColor.componentDisableOutline
        }
    }

    var backgroundColor: UIColor {
        switch state {
        case .default, .focus, .filled, .error:
            return DSColor.componentLightBackground
        case .disable:
            return DSColor.componentDisableBackground
        }
    }

    var isUserInteractionEnabled: Bool {
        switch state {
        case .default, .focus, .filled, .error:
            return true
        case .disable:
            return false
        }
    }

    var helperTextIsError: Bool {
        switch state {
        case .default, .focus, .filled, .disable:
            return false
        case .error:
            return true
        }
    }

    var isClickableEnabled: Bool {
        switch state {
        case .default, .focus, .filled, .error:
            return true
        case .disable:
            return false
        }
    }
}
