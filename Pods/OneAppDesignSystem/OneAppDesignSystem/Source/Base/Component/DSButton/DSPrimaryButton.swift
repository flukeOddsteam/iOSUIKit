import UIKit

/**
    It rendering UIView to primary style (7 Varients) as same as figma that ux designed
 
    ![image](/DocumentationImages/ds-primary.png)

 
    **Usage Example:**
    1. Create UIView on .xib file and assign `DSPrimaryButton` Class to the UIView
    2. Binding constraint and don't set `width` and `height`
    3. Connect UIView to `@IBOutlet` in text editor
    4. Call func that class provided by varients in `viewDidLoad()`
    5. Can connect IBAction from storyboard to text editor like UIButton
     ```
     @IBOutlet weak var button: DSPrimaryButton!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         button.largePrimaryText(text: "Primary")
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
public final class DSPrimaryButton: DSButton {
    
    /// For varient **Button/Large/PrimaryText** (in figma)
    /// - Parameter text: The title of button
    public func largePrimaryText(text: String) {
        setup(style: .primary, size: .large, content: .textOnly(text: text))
    }
    
    /// For varient **Button/Large/PrimaryIcon** (in figma)
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func largePrimaryIcon(icon: UIImage) {
        setup(style: .primary, size: .large, content: .iconOnly(image: icon))
    }
    
    /// For varient **Button/Medium/PrimaryText** (in figma)
    /// - Parameter text: The title of button
    public func mediumPrimaryText(text: String) {
        setup(style: .primary, size: .medium, content: .textOnly(text: text))
    }
    
    /// For varient **Button/Medium/PrimaryText+IconLeft** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func mediumPrimaryTextIconLeft(text: String, icon: UIImage) {
        setup(style: .primary, size: .medium, content: .iconLeftAndText(image: icon, text: text))
    }
    
    /// For varient **Button/Medium/PrimaryText+IconRight** (in figma)
    /// - Parameter text: The title of button
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func mediumPrimaryTextIconRight(text: String, icon: UIImage) {
        setup(style: .primary, size: .medium, content: .iconRightAndText(image: icon, text: text))
    }
    
    /// For varient **Button/Small/PrimaryText** (in figma)
    /// - Parameter text: The title of button
    public func smallPrimaryText(text: String) {
        setup(style: .primary, size: .small, content: .textOnly(text: text))
    }
    
    /// For varient **Button/Small/PrimaryIcon** (in figma)
    /// - Parameter icon: The icon of button (must be entered correctly by **Small, Medium, Large** Size)
    public func smallPrimaryIcon(icon: UIImage) {
        setup(style: .primary, size: .small, content: .iconOnly(image: icon))
    }
}
