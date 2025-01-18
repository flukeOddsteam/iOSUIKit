//
//  UITextFieldPadding.swift
//  OneAppDesignSystem
//
//  Created by TTB on 19/12/22.
//

import UIKit

public final class UITextFieldPadding: UITextField {
    let padding = UIEdgeInsets(top: 28, left: 12, bottom: 8, right: 12)
    
    public var isPasteEnabled: Bool = true
    public var isCopyEnabled: Bool = true
    public var isCutEnabled: Bool = true
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) && !isPasteEnabled {
            return false
        }
        
        if action == #selector(UIResponderStandardEditActions.cut(_:)) && !isCutEnabled {
            return false
        }
        
        if action == #selector(UIResponderStandardEditActions.copy(_:)) && !isCopyEnabled {
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}
