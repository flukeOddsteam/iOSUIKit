import Foundation
import UIKit

/**
    It rendering UIView to HelperText component used in DSTextField as same as figma that ux designed
    ![image](/DocumentationImages/ds-helper-text.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSHelperTextView` Class to the UIView
    2. Connect UIView to `@IBOutlet` in text editor
    3. The init function will setup style of this UIView
     ```
     @IBOutlet weak var helperText: HelperText!
 
     override func viewDidLoad() {
         super.viewDidLoad()
 
         // Set up by using setup() method
         helperText.setup(textLeft: "textLeft", textRight: "textRight", isError = true)
     }
     ```
     Or
 
     Set left text label:
     ```
     helperText.text = "textLeft"
     ```
 
     Set right text label:
     ```
     helperText.textRight = "textRight"
     ```
 
     Set error state of helper text:
     ```
     helperText.isError = true
     ```
*/
public final class DSHelperTextView: UIView {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textRightLabel: UILabel!
    @IBOutlet weak var iconAlertImageView: UIView!
	@IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var textRightContainerView: UIView!

    /// Variable to present text in the left of helper text
    ///
    /// Default value is empty string
    public var text: String = "" {
        didSet {
            textLabel.text = text
            handleErrorState()
        }
    }
    
    /// Variable to present text in the right of helper text
    ///
    /// Default value is empty string
    public var textRight: String = "" {
        didSet {
            textRightLabel.text = textRight
        }
    }
    
    /// Variable to present the error state of helper text
    ///
    /// Default value is false: Hide alert icon
    ///
    /// If set isError: true then alert icon will appear and hide the right text lebel
    public var isError: Bool = false {
        didSet {
            handleErrorState()
        }
    }
    
    /// For set textAlignment of helperText.
    public var textAlignment: NSTextAlignment = .left {
        didSet {
            textLabel.textAlignment = textAlignment
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupStyle()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupStyle()
    }
    
    /// Setup DSHelperTextView
    ///
    /// Parameter for setup DSHelperTextView
    /// - Parameter textLeft: text to  display as  the left  side of DSHelperTextView.
    /// - Parameter textRight: text to  display as  the right  side of DSHelperTextView (optional).
    /// - Parameter isError: present error state of DSHelperTextView (optional).
    public func setup(textLeft: String, textRight: String = "", isError: Bool = false) {
        self.text = textLeft
        self.textRight = textRight
        self.isError = isError
    }

    public func setAccessibilityIdentifier(id: String? = nil,
                                           textLabelId: String? = nil,
                                           textRightLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        textLabel.accessibilityIdentifier = textLabelId
        textRightLabel.accessibilityIdentifier = textLabelId
    }
}

// MARK: - Private
private extension DSHelperTextView {
    func setupStyle() {
        textLabel.textColor = DSColor.componentLightDesc
        textLabel.font = DSFont.subtitle
        textRightLabel.textColor = DSColor.componentLightDefault
        textRightLabel.font = DSFont.subtitle
        textLabel.text = ""
        textRightLabel.text = ""
        iconAlertImageView.isHidden = true
        infoImageView.image = SvgIcons.icon16Alert.image.withRenderingMode(.alwaysTemplate)
        infoImageView.tintColor = DSColor.componentLightError
        infoImageView.tintAdjustmentMode = .normal

    }
    
    func handleErrorState() {
        if isError {
            textLabel.textColor = DSColor.componentLightError
            iconAlertImageView.isHidden = false || text.isEmpty ? true : false
            textRightLabel.isHidden = true
            textRightContainerView.isHidden = true
        } else {
            textLabel.textColor = DSColor.componentLightDesc
            iconAlertImageView.isHidden = true
            textRightLabel.isHidden = false
            textRightContainerView.isHidden = textRightLabel.text.isNilOrEmpty
        }
    }
}
