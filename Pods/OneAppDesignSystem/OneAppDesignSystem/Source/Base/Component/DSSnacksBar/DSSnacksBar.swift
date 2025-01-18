//
//  DSSnacksBar.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/2/23.
//

import UIKit

private enum Constant {
    static let numberOfLines: Int = 0
}

public enum DSSnacksBarButtonStyle {
    case secondary
    case ghost
}

/// Configuration for setting up DSSnacksBar
///
/// Parameter for setup DSSnacksBar
/// - Parameter text: text to display on Snacks Bar.
/// - Parameter buttonStyle: button style on Snacks Bar. There are 2 styles such as secondary and ghost.
/// - Parameter buttonLabel: text to display as a label of the button.
public struct DSSnacksBarConfiguration {
    let text: String
    let buttonStyle: DSSnacksBarButtonStyle
    let buttonLabel: String

    public init(text: String, buttonStyle: DSSnacksBarButtonStyle, buttonLabel: String) {
        self.text = text
        self.buttonStyle = buttonStyle
        self.buttonLabel = buttonLabel
    }
}

public protocol DSSnacksBarDelegate: AnyObject {
    func pressedOnSnacksBarButton()
}

/**
    Custom component DSSnacksBar for Design System
 
    ** Snacks Bar With Small Ghost Button **
        
    ![image](/DocumentationImages/ds-snackbar-ghost-button.png)
 
    ** Snacks Bar With Small Secondary Button **

    ![image](/DocumentationImages/ds-snackbar-secondary-button.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign ` DSSnacksBar` Class to the UIView.
    2. Binding constraint to bottom perfectly and don't set `height`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
 @IBOutlet weak var snacksBar: DSSnacksBar!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         snacksBar.delegate = self
 
         //Example: Snacks Bar With Small Secondary Button
         snacksBar.setup(text: "Message here, keep this short, maximum 3 lines.",
                         buttonStyle: .secondary,
                         buttonLabel: "Text")
 
         //Example: Snacks Bar With Small Ghost Button
         snacksBar.setup(text: "Message here, keep this short, maximum 3 lines.",
                         buttonStyle: .ghost,
                         buttonLabel: "Text")
     }
     ```
     **DSSnacksBar has 2 styles of button:**
     - secondary
     - ghost
 */
public final class DSSnacksBar: UIView {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var secondaryButton: DSSecondaryButton!
    
    public weak var delegate: DSSnacksBarDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSSnacksBar
    ///
    /// Parameter for setup DSSnacksBar
    /// - Parameter configuration: `DSSnacksBarConfiguration` configuration for displaying DSSnacksBar.
    public func setup(configuration: DSSnacksBarConfiguration) {
        label.text = configuration.text
        secondaryButton.setup(
            style: .init(configuration),
            size: .small,
            content: .textOnly(text: configuration.buttonLabel)
        )
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           labelId: String? = nil,
                                           buttonId: String? = nil,
                                           buttonLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = labelId
        self.secondaryButton.setAccessibilityIdentifier(id: buttonId, titleLabelId: buttonLabelId)
    }
}

// MARK: - Action
extension DSSnacksBar {
    @IBAction func pressedOnSecondary(_ sender: Any) {
        delegate?.pressedOnSnacksBarButton()
    }
}

// MARK: - Private
private extension DSSnacksBar {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        label.font = DSFont.labelInput
        label.textColor = DSColor.componentLightDesc
        label.numberOfLines = Constant.numberOfLines
        contentView.dsShadowDrop(style: .top)
    }
}

fileprivate extension DSButtonStyle {
    init(_ configuration: DSSnacksBarConfiguration) {
        switch configuration.buttonStyle {
        case .ghost: self = .ghost
        case .secondary: self = .secondary
        }
    }
}
