//
//  DSEmptyAndError.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/12/22.
//

import UIKit

private enum Constants {
    static let numberOfLine: Int = 0
    static let titleBottomConstraint: CGFloat = 0
}

/**
    Custom component DSEmptyAndErrorState for Design System
 
    **DSEmptyAndErrorState - Icon Small**
 
    ![image](/DocumentationImages/ds-empty-and-error-icon-small.png)
 
    **DSEmptyAndErrorState - Icon Medium**
 
    ![image](/DocumentationImages/ds-empty-and-error-icon-medium.png)
 
    **DSEmptyAndErrorState - Image Small**

    ![image](/DocumentationImages/ds-empty-and-error-image.png)
 
    **DSEmptyAndErrorState - Image Medium**
 
    ![image](/DocumentationImages/ds-empty-and-error-image-medium.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSEmptyAndErrorState` Class to the UIView.
    2. Binding constraint and don't set `width`  and  `height`
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
    @IBOutlet weak var emptyAndError: DSEmptyAndErrorState!
 
     override func viewDidLoad() {
         super.viewDidLoad()
         emptyAndError.setup(style: .iconSmall(icon: DSIcons.icon24OutlinePlaceholder),
                             title: "Title maximum 2 lines",
                             description: "Desc - Maximum 3 lines Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in a, ultrices at.")
     }
     ```
     Display iconSmall style:
     ```
         emptyAndError.setup(style: .iconSmall(icon: DSIcons.icon24OutlinePlaceholder),
                             title: "Title maximum 2 lines",
                             description: "Desc - Maximum 3 lines Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in a, ultrices at.")
     ```
     Display iconMedium style:
     ```
         emptyAndError.setup(style: .iconMedium(icon: DSIcons.icon36OutlinePlaceholder),
                             title: "Title maximum 2 lines",
                             description: "Desc - Maximum 3 lines Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in a, ultrices at.")
     ```
     Display image medium style:
     ```
         // Example: Using image medium type as url
         emptyAndError.setup(style: .imageMedium(imageType: .url(url,
                                                 placeholder: SvgIcons.placeholderEmptyAndErrorState.image)),
                             title: "Title maximum 2 lines",
                             description: "Desc - Maximum 3 lines Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in a, ultrices at.")
         
         // Example: Using image medium type as UIImage
         emptyAndError.setup(
             style: .imageMedium(imageType: .image(SvgIcons.placeholderEmptyAndErrorState.image)),
             title: "Title maximum 2 lines",
             description: "Desc - Maximum 3 lines Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in a, ultrices at.")
    ```
    Display image small style:
    ```
        // Example: Using image small type as UIImage
        emptyAndError.setup(
            style: .imageSmall(image: .image(SvgIcons.placeholderEmptyAndErrorState.image)),
            title: "Title maximum 2 lines",
            description: "Desc - Maximum 3 lines Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in a, ultrices at.")
     ```
 
     **DSDSEmptyAndErrorState has 4 style:**
     - iconSmall
     - iconMedium
     - imageSmall
     - imageMedium
 */
public final class DSEmptyAndErrorState: UIView {
    // MARK: IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var imageViewWidth: NSLayoutConstraint!
    @IBOutlet private weak var imageViewHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var imageBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private Variable
    private var hasTitle: Bool = false
    private var useOriginalImage: Bool = false
    
    private var image: UIImage? {
        didSet {
            imageView.image = useOriginalImage ? image : image?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    // MARK: - Public Variable
    /// Variable for update title text of DSEmptyAndErrorState.
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    /// Variable for update description text of DSEmptyAndErrorState.
    public var descriptionText: String = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    /// Variable for update style of DSEmptyAndErrorState.
    public var style: DSEmptyAndErrorStateStyle = .iconMedium(image: DSIcons.icon36OutlinePlaceholder.image) {
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
    
    /// Setup DSEmptyAndErrorState
    ///
    /// Parameter for setup DSEmptyAndErrorState
    /// - Parameter style: style of DSEmptyAndErrorState.
    /// - Parameter title: text to display as title of DSEmptyAndErrorState (optional).
    /// - Parameter description: text to display as description of DSEmptyAndErrorState (mandatory).
    public func setup(style: DSEmptyAndErrorStateStyle,
                      title: String = "",
                      description: String,
                      useOriginalImage: Bool = false) {
        self.hasTitle = title != ""
        self.style = style
        self.title = title
        self.descriptionText = description
        self.useOriginalImage = useOriginalImage
        
        switch style {
        case .iconSmall(let image):
            self.image = image
        case .iconMedium(let image):
            self.image = image
        case .imageSmall(let imageType):
            switch imageType {
            case .image(let image):
                imageView.image = image
            case .url(let url, let placeholder):
                imageView.setImage(with: url, placeHolder: placeholder)
            }
        case .imageMedium(let imageType):
            switch imageType {
            case .image(let image):
                imageView.image = image
            case .url(let url, let placeholder):
                imageView.setImage(with: url, placeHolder: placeholder)
            }
        }
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           imageViewId: String? = nil,
                                           titleLabelId: String? = nil,
                                           descriptionLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.imageView.accessibilityIdentifier = imageViewId
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.descriptionLabel.accessibilityIdentifier = descriptionLabelId
    }
}

// MARK: - Private
private extension DSEmptyAndErrorState {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        self.titleLabel.textColor = DSColor.componentLightDefault
        self.titleLabel.numberOfLines = Constants.numberOfLine
        self.descriptionLabel.textColor = DSColor.componentLightDesc
        self.descriptionLabel.numberOfLines = Constants.numberOfLine
    }
    
    func updateAppearance() {
        self.titleLabel.font = style.titleFont
        self.titleView.isHidden = !hasTitle
        self.descriptionLabel.font = style.descriptionFont
        self.imageViewWidth.constant = style.imageViewWidth
        self.imageViewHeight.constant = style.imageViewHeight
        self.imageView.tintColor = DSColor.componentSummaryDesc
        self.imageBottomConstraint.constant = style.imageBottomConstraint
        self.titleBottomConstraint.constant = hasTitle ? style.titleBottomConstraint : Constants.titleBottomConstraint
    }
}
