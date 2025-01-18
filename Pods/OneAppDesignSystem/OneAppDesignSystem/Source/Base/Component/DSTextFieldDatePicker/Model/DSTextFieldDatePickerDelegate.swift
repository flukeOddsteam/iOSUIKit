//
//  DSTextFieldDatePickerDelegate.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/11/2566 BE.
//

import UIKit

/// Delegate for DSTextFieldDatePicker
public protocol DSTextFieldDatePickerDelegate: AnyObject {
    /// Tell the delegate of DSTextFieldDatePicker when date picker is selected.
    func didSelectDate(tagId: Int, selectedDate: Date, textField: DSTextFieldDatePicker)
    /// Tell the delegate of DSTextFieldDatePicker when editing starts.
    func textFieldEditingDidBegin(_ textField: DSTextFieldDatePicker)
    /// Tell the delegate of DSTextFieldDatePicker when editing stops.
    func textFieldEditingDidEnd(_ textField: DSTextFieldDatePicker)
}

public extension DSTextFieldDatePickerDelegate {
    func textFieldEditingDidBegin(_ textField: DSTextFieldDatePicker) { }
    func textFieldEditingDidEnd(_ textField: DSTextFieldDatePicker) { }
}
