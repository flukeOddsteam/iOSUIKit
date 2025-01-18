//
//  DSScrollingPageControl.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/11/2565 BE.
//

import Foundation
import UIKit

/**
 Custom component DSScrollingPageControl for Design System
 
 ![image](/DocumentationImages/ds-scrolling-page-control.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSScrollingPageControl` Class to the UIView
 2. Binding constraint (DSScrollingPageControl have a height to by self, So you don't have to set height)
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call func setup()
     ```
    setup(pages: 10, style: .light)
     ```
 **Parameter:**
 - pages: number of item.
 - style: color of dot.
 
 **For scrolling item use func:**
 ```
 scrollToPage(index: 2, isAnimate: false)
 ```
 */
public final class DSScrollingPageControl: UIView {
    @IBOutlet weak var scrollingPageControl: ScrollingPageControl!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    public func setup(pages: Int, style: DSCarouselStyle) {
        scrollingPageControl.pages = pages
        scrollingPageControl.dotColor = style.dotColor
        scrollingPageControl.selectedColor = style.selectedColor
    }
    
    /// Scrolling dot to index you set.
    public func scrollToPage(index: Int, isAnimate: Bool = true) {
        scrollingPageControl.isAnimate = isAnimate
        scrollingPageControl.selectedPage = index
    }
}
