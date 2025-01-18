//
//  TextFieldPasswordAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/5/2566 BE.
//

import UIKit

protocol TextFieldPasswordAppearance {
    var textColor: UIColor { get }
    var labelTextColor: UIColor { get }
    var labelFont: UIFont? { get }
    var borderColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var isUserInteractionEnabled: Bool { get }
    var helperTextIsError: Bool { get }
    var helperText: String { get }
    var isActiveTitleLabelTopMargin: Bool { get }
    var isActiveTitleLabelCenterYConstraint: Bool { get }
    var isHiddenHelperTextView: Bool { get }
}

struct TextFieldPasswordViewModel {
    let state: DSTextFieldPasswordState
    let textValue: String
    let helperTextValue: String
    let isEditing: Bool

    private var hasTextValue: Bool {
        return textValue.isNotEmpty
    }
}

extension TextFieldPasswordViewModel: TextFieldPasswordAppearance {
    var labelTextColor: UIColor {
        switch state {
        case .focus:
            return DSColor.componentLightLabel
        default:
            return hasTextValue || isEditing ? DSColor.componentLightLabel : DSColor.componentLightPlaceholder
        }
    }
    
    var labelFont: UIFont? {
        switch state {
        case .focus:
            return DSFont.labelInput
        default:
            return hasTextValue || isEditing ? DSFont.labelInput : DSFont.placeholder
        }
    }
    
    var textColor: UIColor {
        switch state {
        case .default, .focus, .error:
            return DSColor.componentLightDefault
        case .disable:
            return DSColor.componentLightLabel
        }
    }
    
    var borderColor: UIColor {
        switch state {
        case .default:
            return DSColor.componentLightOutline
        case .focus:
            return DSColor.componentLightOutlineInputFocus
        case .disable:
            return DSColor.componentDisableOutline
        case .error:
            return DSColor.componentLightError
            
        }
    }
    
    var backgroundColor: UIColor {
        switch state {
        case .default, .error, .focus:
            return DSColor.componentLightBackground
        case .disable:
            return DSColor.componentDisableBackground
        }
    }
    
    var isUserInteractionEnabled: Bool {
        switch state {
        case .default, .error, .focus:
            return true
        case .disable:
            return false
        }
    }
    
    var helperTextIsError: Bool {
        switch state {
        case .error:
            return true
        default:
            return false
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
            return hasTextValue || isEditing
        }
    }
    
    var isActiveTitleLabelCenterYConstraint: Bool {
        return !isActiveTitleLabelTopMargin
    }
}
