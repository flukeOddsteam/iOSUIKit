//
//  TextFieldAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/12/22.
//

import UIKit

protocol TextFieldAppearance {
    var textColor: UIColor { get }
    var titleTextColor: UIColor { get }
    var titleFont: UIFont? { get }
    var borderColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var isUserInteractionEnabled: Bool { get }
    var helperTextIsError: Bool { get }
    var helperText: String { get }
    var isHiddenHelperTextView: Bool { get }
    var isActiveTitleLabelTopMargin: Bool { get }
    var isActiveTitleLabelCenterYConstraint: Bool { get }
    var isClickableEnabled: Bool { get }
}
