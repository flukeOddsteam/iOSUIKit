import UIKit

/**
    It rendering UIView to primary style (7 Varients) as same as figma that ux designed
 
    ![image](/DocumentationImages/ds-secondary.png)
 
    **Usage Example:**
    1. Create UIView on .xib file and assign `DSSecondaryButton` Class to the UIView
    2. Binding constraint and don't set `width` and `height`
    3. Connect UIView to `@IBOutlet` in text editor
    4. Call func that class provided by varients in `viewDidLoad()`
    5. Can connect IBAction from storyboard to text editor like UIButton
     ```
     @IBOutlet weak var button: DSSecondaryButton!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         button.largePrimaryText(text: "Secondary")
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
public final class DSSecondaryButton: DSButton {
    
    /// For varient **Button/Large/SecondaryText** (in figma)
    /// - Parameter text: The title of button
    public func largeSecondaryText(text: String) {
        setup(style: .secondary, size: .large, content: .textOnly(text: text))
    }

    /// For varient **Button/Medium/SecondaryText** (in figma)
    /// - Parameter text: The title of button
    public func mediumSecondaryText(text: String) {
        setup(style: .secondary, size: .medium, content: .textOnly(text: text))
    }

    /// For varient **Button/Medium/SecondaryText+IconLeft** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func mediumSecondaryTextIconLeft(text: String, icon: UIImage) {
        setup(style: .secondary, size: .medium, content: .iconLeftAndText(image: icon, text: text))
    }

    /// For varient **Button/Medium/SecondaryText+IconRight** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func mediumSecondaryTextIconRight(text: String, icon: UIImage) {
        setup(style: .secondary, size: .medium, content: .iconRightAndText(image: icon, text: text))
    }

    /// For varient **Button/Medium/SecondaryIcon** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func mediumSecondaryIcon(icon: UIImage) {
        setup(style: .secondary, size: .medium, content: .iconOnly(image: icon))
    }

    /// For varient **Button/Small/SecondaryText** (in figma)
    /// - Parameter text: The title of button
    public func smallSecondaryText(text: String) {
        setup(style: .secondary, size: .small, content: .textOnly(text: text))
    }

    /// For varient **Button/Small/SecondaryText+IconLeft** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func smallSecondaryTextIconLeft(text: String, icon: UIImage) {
        setup(style: .secondary, size: .small, content: .iconLeftAndText(image: icon, text: text))
    }

    /// For varient **Button/Small/SecondaryText+IconRight** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func smallSecondaryTextIconRight(text: String, icon: UIImage) {
        setup(style: .secondary, size: .small, content: .iconRightAndText(image: icon, text: text))
    }

    /// For varient **Button/Small/SecondaryIcon** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func smallSecondaryIcon(icon: UIImage) {
        setup(style: .secondary, size: .small, content: .iconOnly(image: icon))
    }
}
