//
//  DSMessageBox.swift
//  OneApp
//
//  Created by TTB on 6/9/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import Foundation
import UIKit

/// Style of message box
public enum DSMessageBoxStyle {
    /// Style error
    case error
    /// Style warning
    case warning
    /// Style informative
    case informative
}

/**
 Custom component MessageBox

 ![image](/DocumentationImages/ds-message-box.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSMessageBox` class to the UIView
 2. Binding constraint and don't set `height` (use height placeholder or set height remove at build time in storyboard, or etc.)
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
 
Must know: If not send data to params message box will hide the component by each params that not have data.
 
 For example: Not sending title parameter, Message box will hide title label.
  ```
 @IBOutlet weak var messageBox: DSMessageBox!
  
  override func viewDidLoad() {
     super.viewDidLoad()
     messageBox.setup(
        style: .informative,
        title: "title",
        description: "des",
        titleButtonLeft: "Dismiss",
        titleButtonRight: "Action 1",
        buttonLeftAction: actionFunc,
        buttonRightAction: actionFunc)
  }
  ```
    **NOTE:**
 - Set style as named in figma
 - `textButtonPrimary` is the first button from right side
 - `textButtonSecondary` is the second button from right side
 */
public class DSMessageBox: UIView {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textButtonPrimary: DSGhostButton!
    @IBOutlet weak var textButtonSecondary: DSGhostButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var bulletView: DSBulletList!
    
    private var textButtonSecondaryAction: () -> Void = {}
    private var textButtonPrimaryAction: () -> Void = {}
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        commonInit()
    }
    
    // MARK: textButtonPrimary is the first button from right side
    // MARK: textButtonSecondary is the second button from right side
    /// Parameter | Type + Information
    /// --- | ---
    /// `style` | `DSMessageBoxStyle` Style of message box.
    /// `title` | `String?`  Title of message box if nill will hide the title label.
    /// `icon` | `UIImage?`  Icon image if nil will show default icon.
    /// `description` | `String` Description of message box never be nil.
    /// `textButtonPrimary` | `String?` Title of button (button frist form the right side) if nill will hide the button.
    /// `textButtonPrimaryAction` | `Closure` For action of button primary
    /// `textButtonSecondary` | `String?` Title of button (button second form the right side) if nill will hide the button.
    /// `textButtonSecondaryAction` | `Closure` For action of button primary
    public func setup(
        style: DSMessageBoxStyle,
        title: String? = nil,
        icon: UIImage? = nil,
        description: String,
        textButtonPrimary: String? = nil,
        textButtonPrimaryAction: @escaping () -> Void = {},
        textButtonSecondary: String? = nil,
        textButtonSecondaryAction: @escaping () -> Void = {}
    ) {
        setBorder(style)
        setIcon(
            icon ?? style.iconImage,
            tintColor: style.iconColor
        )
        
        contentView.layer.cornerRadius = DSRadius.radius12px.rawValue
        contentView.backgroundColor = style.backgroundColor
        
        titleLabel.isHidden = title == nil ? true : false
        titleLabel.text = title
        
        descriptionLabel.text = description
        
        self.textButtonSecondary.isHidden = textButtonSecondary == nil ? true : false
        self.textButtonSecondary.smallGhostText(text: textButtonSecondary ?? "")
        
        self.textButtonPrimary.isHidden = textButtonPrimary == nil ? true : false
        self.textButtonPrimary.smallGhostText(text: textButtonPrimary ?? "")
        
        self.textButtonSecondaryAction = textButtonSecondaryAction
        self.textButtonPrimaryAction = textButtonPrimaryAction
        
        bulletView.isHidden = true
        buttonStackView.isHidden = self.textButtonPrimary.isHidden && self.textButtonSecondary.isHidden
    }
    
    /// Setup DSMessageBox with bullet style
    /// Parameter | Type + Information
    /// --- | ---
    /// `style` | `DSMessageBoxStyle` Style of message box. (mandatory)
    /// `title` | `String?`  Title of message box if nill will hide the title label. (default is null)
    /// `icon` | `UIImage?`  Icon image if nil will show default icon.
    /// `bulletStyle` | `DSBulletStyle` style of bullet (mandatory)
    /// `primarySpacing` | `CGFloat` Vertical padding between items of bullet (default is 4)
    public func setup(style: DSMessageBoxStyle,
                      title: String? = nil,
                      icon: UIImage? = nil,
                      bulletStyle: DSBulletStyle,
                      primarySpacing: CGFloat = 4) {
        setBorder(style)
        setIcon(
            icon ?? style.iconImage,
            tintColor: style.iconColor
        )
        
        contentView.layer.cornerRadius = DSRadius.radius12px.rawValue
        contentView.backgroundColor = style.backgroundColor
        
        descriptionLabel.isHidden = true
        buttonStackView.isHidden = true
        bulletView.isHidden = false
        titleLabel.isHidden = title.isNilOrEmpty
        
        titleLabel.text = title
        
        bulletView.setup(style: bulletStyle, primarySpacing: primarySpacing)
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           iconImageViewId: String? = nil,
                                           descriptionLabelId: String? = nil,
                                           textButtonPrimaryId: String? = nil,
                                           textButtonSecondaryId: String? = nil) {
        self.accessibilityIdentifier = id
        iconImageView.accessibilityIdentifier = iconImageViewId
        descriptionLabel.accessibilityIdentifier = descriptionLabelId
        textButtonPrimary.accessibilityIdentifier = textButtonPrimaryId
        textButtonSecondary.accessibilityIdentifier = textButtonSecondaryId
    }
}

// MARK: - Action
extension DSMessageBox {
    @objc func didTapTextButtonSecondary(_ sender: UITapGestureRecognizer) {
        textButtonSecondaryAction()
    }
    
    @objc func didTapTextButtonPrimary(_ sender: UITapGestureRecognizer) {
        textButtonPrimaryAction()
    }
}

// MARK: - Private
private extension DSMessageBox {
    func commonInit() {
        textButtonPrimary.isHidden = true
        textButtonPrimary.backgroundColor = .clear
        
        textButtonSecondary.isHidden = true
        textButtonSecondary.backgroundColor = .clear

        titleLabel.isHidden = true
        titleLabel.textColor = DSColor.componentErrorDefault
        titleLabel.font = DSFont.h3
        titleLabel.numberOfLines = 2
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = DSColor.componentErrorDesc
        descriptionLabel.font = DSFont.paragraphSmall
        
        iconImageView.tintAdjustmentMode = .normal
        
        let tapGestureFirst = UITapGestureRecognizer(target: self, action: #selector(didTapTextButtonPrimary(_:)))
        textButtonPrimary.addGestureRecognizer(tapGestureFirst)
        
        let tapGestureSecond = UITapGestureRecognizer(target: self, action: #selector(didTapTextButtonSecondary(_:)))
        textButtonSecondary.addGestureRecognizer(tapGestureSecond)
    }
    
    func setIcon(_ image: UIImage, tintColor: UIColor) {
        iconImageView.image = image.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = tintColor
    }
    
    func setBorder(_ style: DSMessageBoxStyle) {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = style.borderColor.cgColor
    }
}
