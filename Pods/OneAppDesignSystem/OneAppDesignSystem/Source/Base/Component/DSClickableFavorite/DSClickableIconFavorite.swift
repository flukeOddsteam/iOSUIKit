//
//  DSClickableIconFavorite.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/4/2566 BE.
//

import UIKit

/**
 Custom component DSClickableIconFavorite
 
 ![image](/DocumentationImages/ds-clickable-icon-favorite.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSClickableIconFavorite` Class to the UIView
 2. Binding constraint and don't set `height` and `width`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
```swift
    @IBOutlet weak var clickableFavorite: DSClickableIconFavorite!

    override func viewDidLoad() {
        super.viewDidLoad()
        clickableFavorite.setup(style: .default) { tagId, style, view [weak self] in
            // Do something
        }
}
```
*/
public final class DSClickableIconFavorite: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    /// Variable for set style of DSClickableIconFavorite.
    public var style: DSClickableIconFavoriteStyle = .default {
        didSet {
            updateStyle()
        }
    }
    
    /// Callback when user tap DSClickableIconFavorite.
    public var clickableDidTapped: ((Int, DSClickableIconFavoriteStyle, DSClickableIconFavorite) -> Void)?

    /// Variable for set tag ID of DSClickableIconFavorite.
    public var tagId: Int = .zero
    
    private var isPressed: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSClickableIconFavorite
    ///
    /// Parameter for setup DSClickableSelection
    /// - Parameter tagId: id number of DSClickableIconFavorite.
    /// - Parameter style: style of DSClickableIconFavorite. (mandatory).
    /// - Parameter clickableDidTapped: callback closure of DSClickableIconFavorite. When user tap DSClickableIconFavorite this closure will trigger and pass parameter tagId, current style and view.
    public func setup(tagId: Int = .zero,
                      style: DSClickableIconFavoriteStyle,
                      clickableDidTapped: ((Int, DSClickableIconFavoriteStyle, DSClickableIconFavorite) -> Void)? = nil) {
        self.tagId = tagId
        self.style = style
        self.clickableDidTapped = clickableDidTapped
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isPressed = true
        dispatchMainThread {
            self.updateState()
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isPressed = false
        dispatchMainThread {
            self.updateState()
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isPressed = false
        dispatchMainThread {
            self.updateState()
        }
    }
}

// MARK: - Action
extension DSClickableIconFavorite {
    @objc func clickableDidTapped(_ gesture: UIGestureRecognizer) {
        clickableDidTapped?(tagId, style, self)
    }
}

// MARK: - Private
private extension DSClickableIconFavorite {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
        updateStyle()
        updateState()
    }
    
    func setupUI() {
        containerView.setCircle()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = DSColor.componentSecondaryDefault
        iconImageView.tintAdjustmentMode = .normal

    }
    
    func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickableDidTapped(_:)))
        addGestureRecognizer(gesture)
    }
    
    func updateStyle() {
        let image = style.iconImage.withRenderingMode(.alwaysTemplate)
        iconImageView.image = image
    }
    
    func updateState() {
        let backgroundColor = isPressed ? DSColor.componentSecondaryBackgroundOnPress : .clear
        containerView.backgroundColor = backgroundColor
    }
    
    func dispatchMainThread(action: @escaping () -> Void) {
        DispatchQueue.main.async {
            action()
        }
    }
}
