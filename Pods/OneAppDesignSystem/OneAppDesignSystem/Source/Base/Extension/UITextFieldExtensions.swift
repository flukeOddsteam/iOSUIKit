//
//  UITextFieldExtensions.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/1/23.
//

import UIKit

extension UITextField {
    func moveCursorPositionOneToTheLeft() {
        // only if there is a currently selected range
        if let selectedRange = selectedTextRange {
            // and only if the new position is valid
            if let newPosition = position(from: selectedRange.start, offset: -1) {
                // set the new position
                selectedTextRange = textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    func moveCursorPositionToTheBeginning() {
        let newPosition = beginningOfDocument
        selectedTextRange = textRange(from: newPosition, to: newPosition)
    }
    
    func moveCursorPositionToTheEnd() {
        let newPosition = endOfDocument
        selectedTextRange = textRange(from: newPosition, to: newPosition)
    }
}
