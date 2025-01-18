//
//  UITextViewExtensions.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/2/2567 BE.
//

import UIKit

extension UITextView {
    func setCursorPosition(position: Int, isMainThread: Bool = false) {
        if isMainThread {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                setSelectedTextRange(at: position)
            }
        } else {
            setSelectedTextRange(at: position)
        }
    }

    func setSelectedTextRange(at position: Int) {
        if let position = self.position(from: self.beginningOfDocument, offset: position) {
            self.selectedTextRange = self.textRange(from: position, to: position)
        } else {
            self.selectedTextRange = self.textRange(from: self.endOfDocument, to: self.endOfDocument)
        }
    }
}
