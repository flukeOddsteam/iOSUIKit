import UIKit

/**
    It rendering UIView to primary style (7 Varients) as same as figma that ux designed
 
    ![image](/DocumentationImages/ds-ghost.png)

 
    **Usage Example:**
    1. Create UIView on .xib file and assign `DSGhostButton` Class to the UIView
    2. Binding constraint and don't set `width` and `height`
    3. Connect UIView to `@IBOutlet` in text editor
    4. Call func that class provided by varients in `viewDidLoad()`
    5. Can connect IBAction from storyboard to text editor like UIButton
     ```
     @IBOutlet weak var button: DSGhostButton!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         button.largePrimaryText(text: "Ghost")
     }
     ```
     Toggle to disable state :
     ```
     button.isUserInteractionEnabled = false
     ```
        
     **Note:**
     1. Parameter `func(icon: UIImage)` The image must be entered correctly by
        **Small, Medium, Large** Size
*/
public final class DSGhostButton: DSButton {
    
    /// For varient **Button/Large/GhostText** (in figma)
    /// - Parameter text: The title of button
    public func largeGhostText(text: String) {
        setup(style: .ghost, size: .large, content: .textOnly(text: text))
    }
    
    /// For varient **Button/Medium/GhosText** (in figma)
    /// - Parameter text: The title of button
    public func mediumGhostText(text: String) {
        setup(style: .ghost, size: .medium, content: .textOnly(text: text))
    }
    
    /// For varient **Button/Medium/GhosTextOnDark** (in figma)
    /// - Parameter text: The title of button
    public func mediumGhostTextOnDark(text: String) {
        setup(style: .ghostDark, size: .medium, content: .textOnly(text: text))
    }
    
    /// For varient **Button/Medium/GhostText+IconLeft** (in figma)
    /// - Parameter text: The title of button
    public func mediumGhostTextIconLeft(text: String, icon: UIImage) {
        setup(style: .ghost, size: .medium, content: .iconLeftAndText(image: icon, text: text))
    }
    
    /// For varient **Button/Medium/GhostText+IconRight** (in figma)
    /// - Parameter text: The title of button
    public func mediumGhostTextIconRight(text: String, icon: UIImage) {
        setup(style: .ghost, size: .medium, content: .iconRightAndText(image: icon, text: text))
    }
    
    /// For varient **Button/Medium/GhostIcon** (in figma)
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func mediemGhostIcon(icon: UIImage) {
        setup(style: .ghost, size: .medium, content: .iconOnly(image: icon))
    }
    
    /// For varient **Button/Small/GhostText** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostText(text: String) {
        setup(style: .ghost, size: .small, content: .textOnly(text: text))
    }
    
    /// For varient **Button/Small/GhostNoPaddingLeft+IconLeft** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostNoPaddingLeftIconLeft(text: String, icon: UIImage) {
        setup(style: .ghost, size: .small, content: .iconLeftNoPaddingAndText(image: icon, text: text))
    }
    
    /// For varient **ButtonSmall/GhostNoPaddingRight+IconRight** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostNoPaddingRightIconRight(text: String, icon: UIImage) {
        setup(style: .ghost, size: .small, content: .iconRightNoPaddingAndText(image: icon, text: text))
    }
    
    /// For varient **Button/Small/GhostOnDark** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostTextOnDark(text: String) {
        setup(style: .ghostDark, size: .small, content: .textOnly(text: text))
    }
    
    /// For varient **Button/Small/GhostIconLeftOnDark** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostIconLeftOnDark(text: String, icon: UIImage) {
        setup(style: .ghostDark, size: .small, content: .iconLeftAndText(image: icon, text: text))
    }
    
    /// For varient **Button/Small/GhostIconRightOnDark** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostIconRightOnDark(text: String, icon: UIImage) {
        setup(style: .ghostDark, size: .small, content: .iconRightAndText(image: icon, text: text))
    }
    
    /// For varient **ButtonSmall/GhostNoPaddingLeft&Right+IconRight** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostNoPaddingLeftAndRightIconRight(text: String, icon: UIImage) {
        setup(style: .ghost,
              size: .small,
              content: .iconRightNoPaddingLeftAndRight(image: icon, text: text))
    }
    
    /// For varient **ButtonSmall/GhostNoPaddingLeft&Right+IconLeft** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostNoPaddingLeftAndRightIconLeft(text: String, icon: UIImage) {
        setup(style: .ghost,
              size: .small,
              content: .iconLeftNoPaddingLeftAndRight(image: icon, text: text))
    }
    
    /// For varient **Button/Small/GhostText/NoPadding** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostTextOnlyNoPadding(text: String) {
        setup(style: .ghost, size: .small, content: .textOnlyNoPadding(text: text))
    }
    
    /// For varient **Button/Small/GhostText/NoPadding/Dark** (in figma)
    /// - Parameter text: The title of button
    public func smallGhostTextOnlyNoPaddingOnDark(text: String) {
        setup(style: .ghostDark, size: .small, content: .textOnlyNoPadding(text: text))
    }
    
    /// For varient **Button/Small/GhostText/GhostIconRightOnDark/NoPadding/Dark** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button
    public func smallGhostTextAndIconRightNoPaddingOnDark(text: String, icon: UIImage) {
        setup(style: .ghostDark, size: .small, content: .iconRightNoPaddingLeftAndRight(image: icon, text: text))
    }
    
    /// For varient **Button/Small/GhostText/GhostIconRightOnDark/NoPadding/Dark** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button
    public func smallGhostTextAndIconLeftNoPaddingOnDark(text: String, icon: UIImage) {
        setup(style: .ghostDark, size: .small, content: .iconLeftNoPaddingLeftAndRight(image: icon, text: text))
    }

}
