//
//  DSClickableIconHeroView.swift
//  OneApp
//
//  Created by TTB on 23/8/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import Foundation
import UIKit

public protocol DSClickableLabelViewDelegate: AnyObject {
    func onTapClickableLabel()
}

/**
 Custom component ClickableLabel
 
 ![image](/DocumentationImages/ds-clickable-heroLabel.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSClickableIconHeroView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
  ```
 @IBOutlet weak var clickableLabelWithBase: DSClickableIconHeroView!
  
  override func viewDidLoad() {
     super.viewDidLoad()
     clickableLabelWithBase.setup(
         title: "Button Label",
         image: SvgIcons.icon36HeroOutlinePlaceholder.image,
         style: .withBase)
  }
  ```
 
 To set clickable label in disable state can set value isUserInteractionEnabled after setup the button:
 ```
 clickableLabelWithBaseDisable.setup(
     title: "Button Label",
     image: SvgIcons.icon36HeroOutlinePlaceholder.image,
     style: .withBase)
 clickableLabelWithBaseDisable.isUserInteractionEnabled = false
 ```
 */
public final class DSClickableIconHeroView: UIView {
    
    /// Enum for current style of clickable label
    ///
    /// withBase represent light background with border and shadow
    /// noBase represent light background with no border and shadow
    public enum ClickableLabelStyle {
        case withFrame
        case noFrame
    }
    
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var buttonLabel: UILabel!
    
    public weak var delegate: DSClickableLabelViewDelegate?
    var currentStyle: ClickableLabelStyle = .withFrame
    
    /// Variable for disable state of clickable label
    public override var isUserInteractionEnabled: Bool {
        didSet {
            if !isUserInteractionEnabled {
                self.alpha = 0.3
                return
            }
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        DispatchQueue.main.async {
            self.setOnTouchStyle(onTouch: true)
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        DispatchQueue.main.async {
            self.setOnTouchStyle(onTouch: false)
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        DispatchQueue.main.async {
            self.setOnTouchStyle(onTouch: false)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
    }
    
    /// Func for initial the clickable label
    ///
    /// Parameter need to pass for setup
    /// Variables | Description
    /// --- | ---
    /// `title` | `String` For setup the title display in buttonLabel.
    /// `image` | `UIImage` For setup icon that display in iconImageView
    /// `style` | `clickableLabelStyle` For setup the style of clickable label.
    ///
    public func setup(title: String, image: UIImage, style: ClickableLabelStyle) {
        setupGesture()
        iconImageView.image = image
        buttonLabel.text = title
        setupStyle(style: style)
    }
    
    public func setAccessibilityIdentifier(id: String? = nil, buttonLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        buttonLabel.accessibilityIdentifier = buttonLabelId
    }
    
}

// MARK: - Action
extension DSClickableIconHeroView {
    @objc func handleTap(sender: UITapGestureRecognizer) {
        delegate?.onTapClickableLabel()
    }
}

// MARK: - Private
private extension DSClickableIconHeroView {
    func setupStyle(style: ClickableLabelStyle) {
        currentStyle = style
        buttonLabel.font = DSFont.clickableLabel
        buttonLabel.textColor = DSColor.componentLightDefault
        imageContentView.backgroundColor = DSColor.componentLightBackground
        imageContentView.isUserInteractionEnabled = false
        switch currentStyle {
        case .withFrame:
            imageContentView.layer.cornerRadius = DSRadius.radius16px.rawValue
            imageContentView.layer.borderColor = DSColor.componentLightOutlineClickable.cgColor
            imageContentView.layer.borderWidth = 1
            imageContentView.dsShadowDrop()
        case .noFrame:
            imageContentView.layer.cornerRadius = imageContentView.frame.size.height / 2
        }
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    func setOnTouchStyle(onTouch: Bool) {
        switch currentStyle {
        case .withFrame:
                self.imageContentView.dsShadowDrop(isHidden: onTouch)
        case .noFrame:
                return
        }
    }
}
