//
//  DSHighlightMenu.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/9/2567 BE.
//

import UIKit

/// Enum DSHighlightMenuType
public enum DSHighlightMenuType {
    /// Represents a highlight menu with an image.
    case image
    /// Represents a highlight menu with an icon.
    case icon
}

/// Enum DSHighlightMenuState
public enum DSHighlightMenuState: Equatable {
    /// The default state when the menu is not pressed.
    case `default`
    /// The state when the menu is being pressed.
    case onPress
}

/**
 Custom component DSHighlightMenu for Design System
 
 ![image](/DocumentationImages/ds-highlight-menu.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSHighlightMenu` Class to the UIView.
 2. Binding constraint and don't set `height`.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
 
 ```
 @IBOutlet weak var highlightMenu: DSHighlightMenu!
 
 override func viewDidLoad() {
     super.viewDidLoad()
     let viewModel = DSHighlightMenuViewModel(
         title: "Label",
         description: "Description message here, keep this short, 2 lines maximum",
         image: .image(.image(SvgIcons.placeholder1x1.image))
     )
     highlightMenu.setup(viewModel: viewModel, tagId: 0)
     highlightMenu.onClick = { _, tagId in
         DispatchQueue.main.async {
             DSToast.showToast(
                 style: .success,
                 message: "This toast will display when card is pressed"
             )
         }
         print("TagId: \(tagId)")
     }
 }
 ```
 */
public final class DSHighlightMenu: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconRight: UIImageView!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    /// Closure triggered when the user click menu
    public var onClick: ((DSHighlightMenu, Int) -> Void)?
    /// tagId for identifying component.
    public var tagId: Int = .zero
    
    private var appearance: DSHighlightMenuAppearance {
        return DSHighlightMenuAppearanceImplement(type: type, state: state)
    }
    
    var type: DSHighlightMenuType = .image {
        didSet {
            updateAppearance()
        }
    }
    
    var state: DSHighlightMenuState = .default {
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
    
    /// Configures DSHighlightMenu
    ///
    /// - Parameters:
    ///   - viewModel: The data model containing title, description and image.
    ///   - tagId: An identifier for the menu item.
    public func setup(viewModel: DSHighlightMenuViewModel, tagId: Int = .zero) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        
        switch viewModel.image {
        case .image(let imageType):
            switch imageType {
            case .image(let image):
                imageView.image = image
            case .url(let url, let placeholder, let cacheable):
                imageView.setImage(with: url, placeHolder: placeholder ?? SvgIcons.placeholder1x1.image, cacheable: cacheable)
            }
            type = .image
        case .icon(let image):
            imageView.image = image.image
            type = .icon
        }
        
        self.tagId = tagId
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        state = .onPress
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        state = .default
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        state = .default
    }
}

// MARK: - Private
private extension DSHighlightMenu {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        titleLabel.setUp(font: DSFont.h3, textColor: DSColor.componentLightDefault, numberOfLines: 0)
        descriptionLabel.setUp(font: DSFont.paragraphSmall, textColor: DSColor.componentLightDesc, numberOfLines: 0)
        iconRight.image = DSIcons.icon24OutlineChevronRight.image
        containerView.setBorder(width: 1.0, color: DSColor.componentLightOutlineSecondary)
        containerView.setRadius(radius: .radius16px)
    }
    
    func updateAppearance() {
        imageWidthConstraint.constant = appearance.imageSize
        imageHeightConstraint.constant = appearance.imageSize
        containerView.backgroundColor = appearance.backgroundColor
        containerView.dsShadowDrop(isHidden: !appearance.isShadowHidden)
        stackView.spacing = appearance.textSpacing
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        onClick?(self, tagId)
    }
}
