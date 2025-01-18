//
//  DSKeyHighlightCondition.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/9/2567 BE.
//

import UIKit

/// Enum DSKeyHighlightConditionState state.
public enum DSKeyHighlightConditionState {
    /// Used for cases where the condition is correct.
    case correct
    /// Used for cases where the condition is incorrect.
    case incorrect
    /// Used for cases where the condition is waiting.
    case waiting
}

/**
 Custom component DSKeyHighlightCondition for Design System
 
 ![image](/DocumentationImages/ds-key-highlight-condition.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSKeyHighlightCondition` Class to the UIView.
 2. Binding constraint and don't set `height`.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
 
 ```
 @IBOutlet weak var keyHighlight: DSKeyHighlightCondition!
 
 override func viewDidLoad() {
     super.viewDidLoad()
     keyHighlight.setup(title: "Title  Lorem ipsum dolor sit amet, consectetur adipiscing elit.", state: .correct)
 }
}
 ```
 */
public final class DSKeyHighlightCondition: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var state: DSKeyHighlightConditionState = .correct {
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
    
    /// Configures DSKeyHighlightCondition
    ///
    /// - Parameters:
    ///   - title: The text to be displayed as the title
    ///   - state: Specifies the type of DSKeyHighlightCondition
    public func setup(title: String, state: DSKeyHighlightConditionState) {
        titleLabel.text = title
        self.state = state
    }
}

// MARK: - Private
private extension DSKeyHighlightCondition {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.setUp(font: DSFont.paragraphSmall)
    }
    
    func updateAppearance() {
        switch state {
        case .correct:
            iconImageView.image = DSIcons.icon16Check.image
        case .incorrect:
            iconImageView.image = DSIcons.icon16Close.image
        case .waiting:
            iconImageView.image = DSIcons.icon16Time.image
        }
        
        titleLabel.textColor = state.titleColor
        iconImageView.setColor(color: state.iconColor)
    }
}
