//
//  DSClickableIconBadge.swift
//  OneApp
//
//  Created by TTB on 17/8/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import Foundation
import UIKit

/**
 Custom component ClickableIcon
 
 ![image](/DocumentationImages/ds-clickable-icon.png)

 **Usage Example:**
 1. Create UIButton on .xib file and assign `DSClickableIconBadge` Class to the UIButton
 2. Binding constraint and set `height` to 40
 3. Connect UIButton to `@IBOutlet` in text editor
 4. Connect UIButton to `@IBAction` in text editor
 4. Call `func setup()` in `viewDidLoad()`
  ```
  @IBOutlet weak var clickableIconNormal: DSClickableIconBadge!
  
  override func viewDidLoad() {
     super.viewDidLoad()
     clickableIconNormal.setup(style: .normal, image: SvgIcons.generalLoadingIconMedium.image)
  }
  ```
 To setup clickable icon with badge can pass parameter in setup function or call function displayBadge():
 ```
 clickableIcon.setup(style: .normal, image: SvgIcons.generalLoadingIconMedium.image, withBadge: true)
 OR
 clickableIcon.displayBadge(isShow: true)
 ```
 
 To set clickable icon in disable state can set value isEnable after setup the button:
 ```
 clickableIcon.setup(style: .normal, image: SvgIcons.generalLoadingIconMedium.image)
 clickableIcon.isEnabled = false
 ```
 */
@available(*, deprecated, message: "Deprecated, Please use component DSClickableIconGeneralIcon instead.")
public class DSClickableIconBadge: UIButton {

    /// Enum for current style of clickable icon
    ///
    /// normal use in light background
    /// ghost use in page dark background
    public enum ClickableIconStyle {
        case normal
        case ghost
    }
    
    let parentView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    let badge = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    let orangeCircle = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
    
    var currentStyle: ClickableIconStyle = .normal {
        didSet {
            setupStyle()
        }
    }
    
    /// Variable for disable state of clickable icon
    public override var isEnabled: Bool {
        didSet {
            if !isEnabled {
                self.iconImageView.tintColor = DSColor.componentDisableDefault
                return
            }
        }
    }
    
    /// Func for initial the button
    ///
    /// Parameter for setup button
    /// Variables | Description
    /// `style` | `.normal` or `.ghost` for setup style of the clickable icon
    /// `image` | `UIImage` for icon that want to display
    /// `withBadge` | `true` for icon that want to display with badge on the top right corner (the default value is false)
    public func setup(style: ClickableIconStyle, image: UIImage, withBadge: Bool = false) {
        setupIconSubview(image: image)
        setupBadge()
        currentStyle = style
        displayBadge(isShow: withBadge)
        self.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        self.addTarget(self, action: #selector(holdRelease), for: .touchUpOutside)
        self.addTarget(self, action: #selector(heldDown), for: .touchDown)
        self.addTarget(self, action: #selector(buttonHeldAndReleased), for: .touchDragExit)
    }
    
    /// Function for setup image
    public func setIconImage(_ image: UIImage) {
        self.iconImageView.image = image.withRenderingMode(.alwaysTemplate)
    }
    
    public func setStyle(_ style: ClickableIconStyle) {
        self.currentStyle = style
    }
    
    /// Func for toggle the badge
    public func displayBadge(isShow: Bool) {
        badge.isHidden = !isShow
    }
    
    /// override function to draw a button
    ///
    public override func draw(_ rect: CGRect) {
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.backgroundColor = .clear
    }
    
    /// override function to set layout sub view
    ///
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.removeFromSuperview()
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.titleLabel?.removeFromSuperview()
    }
    
    public func setAccessibilityIdentifier(id: String? = nil) {
        self.accessibilityIdentifier = id
    }
}

// MARK: - Action
extension DSClickableIconBadge {
    @objc func holdRelease() {
        switch currentStyle {
        case .normal:
                parentView.backgroundColor = .clear
        case .ghost:
                parentView.backgroundColor = .clear
        }
    }
    
    @objc func heldDown() {
        switch currentStyle {
        case .normal:
                parentView.backgroundColor = DSColor.componentLightBackgroundOnPress
        case .ghost:
                parentView.backgroundColor = DSColor.pageDarkComponentGhostOnPress
        }
    }
    
    @objc func buttonHeldAndReleased() {
        switch currentStyle {
        case .normal:
                parentView.backgroundColor = DSColor.componentLightBackgroundOnPress
        case .ghost:
                parentView.backgroundColor = DSColor.pageDarkComponentGhostOnPress
        }
    }
}

// MARK: - Private
private extension DSClickableIconBadge {
    func setupIconSubview(image: UIImage) {
        parentView.backgroundColor = .clear
        parentView.layer.cornerRadius = parentView.layer.bounds.width / 2
        parentView.addSubview(iconImageView)
        parentView.isUserInteractionEnabled = false
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.image = image.withRenderingMode(.alwaysTemplate)
        iconImageView.isUserInteractionEnabled = false
        iconImageView.center = parentView.center
        iconImageView.isUserInteractionEnabled = false
        
        self.addSubview(parentView)
    }
    
    func setupBadge() {
        self.addSubview(badge)
        badge.addSubview(orangeCircle)
        
        orangeCircle.backgroundColor = DSColor.componentPrimaryBackground
        orangeCircle.layer.cornerRadius = orangeCircle.layer.bounds.width / 2
        orangeCircle.clipsToBounds = true
        orangeCircle.translatesAutoresizingMaskIntoConstraints = false
        
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        badge.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28).isActive = true
        badge.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        badge.isUserInteractionEnabled = false
    }
    
    func setupStyle() {
        switch currentStyle {
        case .normal:
            iconImageView.tintColor = DSColor.componentLightDefault
        case .ghost:
            iconImageView.tintColor = DSColor.pageDarkComponentGhostDefault
        }
    }
}
