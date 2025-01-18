//
//  DSKeyHighlightProduct.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/10/24.
//

import UIKit

/**
 Custom component DSKeyHighlightProduct for Design System
 
 ![image](/DocumentationImages/ds-key-highlight-product.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSKeyHighlightWarning` Class to the UIView.
 2. Binding constraint and don't set `height`.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
 
 ```
 @IBOutlet weak var keyHighlight: DSKeyHighlightProduct!
 
 override func viewDidLoad() {
     super.viewDidLoad()
     keyHighlight.setup(titleText: "title", iconImage: DSIcons.icon36OutlinePrivilege)
 }
}
 ```
 */
public final class DSKeyHighlightProduct: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Configures DSKeyHighlightProduct with title and iconImage
    ///
    /// - Parameters:
    ///   - titleText: The text to be displayed as the title
    ///   - iconImage: The icon to be displayed (optional, default is nil). when set nil default is .icon36OutlinePlaceholder
    public func setup(titleText: String, iconImage: DSIcons? = nil) {
        titleLabel.text = titleText
        
        if let iconImage = iconImage {
            iconImageView.image = iconImage.image
        } else {
            iconImageView.image = DSIcons.icon36OutlinePlaceholder.image
            iconImageView.setColor(color: DSColor.componentLightDefault)
        }
    }
}

// MARK: - Private
private extension DSKeyHighlightProduct {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.setUp(font: DSFont.paragraphMedium, textColor: DSColor.componentLightLabel)
    }
}
