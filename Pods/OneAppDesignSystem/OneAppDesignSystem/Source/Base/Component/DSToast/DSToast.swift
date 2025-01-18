//
//  DSToast.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/11/2565 BE.
//

import UIKit

/**
 Custom component DSPill
 
 ![image](/DocumentationImages/ds-toast-informative.png)
 ![image](/DocumentationImages/ds-toast-success.png)


 **Usage Example:**
 1. Import oneappdesignsystem
 2. Call DSToast.showToast wherever you want`
  ```
    DSToast.showToast(style: .success, message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem")
  ```
 
 **DSToast has 2 style:**
 - informative
 - success
 */

public class DSToast {
    
    public static func showToast(style: DSToastStyle, message: String) {
        let toast = ToastMessageView()
        toast.setup(style: style, message: message)
        
        ToastManager.shared.showToast(toast)
    }
}
