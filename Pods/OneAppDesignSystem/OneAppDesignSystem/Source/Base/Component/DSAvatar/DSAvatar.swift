//
//  DSAvatar.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/2/2566 BE.
//

import UIKit

/**
    Custom component DSAvatar for Design System
 
    ** Avatar Entity And Avatar Profile  **
 
    ![image](/DocumentationImages/ds-avatar-entity-profile.png)
    ![image](/DocumentationImages/ds-avatar-profile-image-mock.svg)
     
        
    **Usage Example:**
    1. setup to source code
     ```
    @IBOutlet weak var imageEntityAvatar: DSAvatar!
    @IBOutlet weak var imageProfileAvatar: DSAvatar!
     
     override func viewDidLoad() {
        super.viewDidLoad()
 
        // Example: Setup avatar view but don't set image yet (if you don't set style view, Component will set default view stype is entity).
        noImageEntityAvatar.setup(avatarImage: nil)
                
        // Example: Setup avatar view, image and profile style.
        imageProfileAvatar.setup(style: .profile, avatarImage: UIImage(named: "ds-avatar-profile-image-mock.svg"))
     }
     ```
    Component has 2 view style:
     - entity
     - profile
    ```
 */
public final class DSAvatar: UIView {
    // MARK: - Public
    @IBOutlet public weak var avatarImageView: UIImageView!
        
    // MARK: - Private
    private var avatarImage: UIImage? {
        didSet {
            updateAppearance()
        }
    }
    
    private var style: DSAvatarStyle = .entity {
        didSet {
            updateAppearance()
        }
    }
    
    private var state: DSAvatarState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Parameter for setup DSAvatar
    /// - Parameter style: border style on avatar view. There are 2 styles such as entity and profile.
    /// - Parameter avatarImage: image to display as avatar view.
    /// - Parameter state: status view disable or endable
    public func setup(style: DSAvatarStyle = .entity, avatarImage: UIImage?, state: DSAvatarState = .default) {
        self.style = style
        self.state = state
        self.avatarImage = avatarImage
        self.commonUIDispatchUpdate()
    }
}

// MARK: - Private
private extension DSAvatar {
    func commonInit() {
        setupXib()
        commonUI()
    }
    
    func commonUI() {
        self.avatarImageView.setCircle()
        avatarImageView.tintAdjustmentMode = .normal

    }
    
    func commonUIDispatchUpdate() {
        DispatchQueue.main.async {
            self.commonUI()
        }
        layoutIfNeeded()
    }
    
    func updateAppearance() {
        switch state {
        case .disable:
            self.avatarImageView.setBorder(width: style.borderWidth, color: style.borderColor.withAlphaComponent(0.3))
            self.avatarImageView.image = avatarImage?.alpha(0.3) ?? style.placeHolderImage.alpha(0.3)
        default:
            self.avatarImageView.setBorder(width: style.borderWidth, color: style.borderColor)
            self.avatarImageView.image = avatarImage ?? style.placeHolderImage
        }
    }
}
