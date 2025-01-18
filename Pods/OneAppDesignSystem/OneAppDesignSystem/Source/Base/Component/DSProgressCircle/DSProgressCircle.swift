//
//  DSProgressCircle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/3/2566 BE.
//

import UIKit

/**
    Custom component DSProgressCircle for Design System
 
    ![image](/DocumentationImages/ds-progress-circle.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSProgressCircle` Class to the UIView.
    2. Binding constraint and don't set `height` and `width`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
         @IBOutlet weak var progressCircle: DSProgressCircle!
         override func viewDidLoad() {
             super.viewDidLoad()
             progressCircle.setup(style: .large,
                                palette: .confidentBlue,
                              iconImage: DSIcons.icon36HeroOutlineHeroInvest.image,
                                  title: nil,
                               subTitle: nil,
                             percentage: 20)
        }
     ```
    5. When you need to update progress. you can pass value to `progressCircle.progress`
 */
public final class DSProgressCircle: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var iconContainerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var subTitleContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var progressView: ProgressCircleView!

    @IBOutlet weak var heightIconImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthIconImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthContainerConstraint: NSLayoutConstraint!
    @IBOutlet var stackViewAnchorConstraints: [NSLayoutConstraint]!
    
    /// The variable for update style
    public var style: DSProgressCircleStyle = .small {
        didSet {
            updateStyle()
        }
    }
    
    /// The variable for update palette
    public var palette: DSProgressCircleColorPalette = .confidentBlue {
        didSet {
            updatePalette()
        }
    }
    
    /// The variable for update title
    public var title: String? {
        didSet {
            titleLabel.text = title
            titleContainerView.isHidden = title.isNilOrEmpty
        }
    }
    
    /// The variable for update icon image
    public var iconImage: UIImage? {
        didSet {
            iconImageView.image = iconImage
            iconContainerView.isHidden = style.shouldHiddenIcon ? true : iconImage.isNull
        }
    }
    
    /// The variable for update sub title
    public var subTitle: String? {
        didSet {
            subTitleLabel.text = subTitle
            subTitleContainerView.isHidden = subTitle.isNilOrEmpty
        }
    }
    
    /// The variable for update progress and redraw
    public var percentage: Int = .zero {
        didSet {
            progressView.drawProgress(from: percentage)
            progressView.layoutSubviews()
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
    
    /// Setup DSProgressCircle
    ///
    /// Parameter for setup DSProgressCircle
    /// - Parameter style: style of DSProgressCircle e.g. small, medium, large (mandatory)
    /// - Parameter palette: the color of progress. (mandatory)
    /// - Parameter iconImage: image of icon. (nullable)
    /// - Parameter title: title of content. (nullable)
    /// - Parameter subTitle: sub title of content. (nullable)
    /// - Parameter percentage: percentage of progress. should in range 0 - 100 (mandatory)
    public func setup(style: DSProgressCircleStyle,
                      palette: DSProgressCircleColorPalette,
                      iconImage: UIImage? = nil,
                      title: String? = nil,
                      subTitle: String? = nil,
                      percentage: Int = .zero) {
        self.style = style
        self.palette = palette
        self.iconImage = iconImage
        self.title = title
        self.subTitle = subTitle
        self.percentage = percentage
    }
}

// MARK: - Private
private extension DSProgressCircle {
    func commonInit() {
        setupXib()
        setupUI()
        updateStyle()
        updatePalette()
    }
    
    func setupUI() {
        titleLabel.textColor = DSColor.componentLightDefault
        iconImageView.tintAdjustmentMode = .normal
        subTitleLabel.font = DSFont.labelInput
        subTitleLabel.textColor = DSColor.componentLightDesc
    }
    
    func updateStyle() {
        widthContainerConstraint.constant = style.containerSize.width
        heightContainerConstraint.constant = style.containerSize.height
        
        widthIconImageConstraint.constant = style.iconSize.width
        heightIconImageConstraint.constant = style.iconSize.height
        
        progressView.lineWidth = style.lineWidth
        titleLabel.font = style.titleFont
        
        stackViewAnchorConstraints.forEach {
            $0.constant = self.style.contentPadding
        }
        
        if style.shouldHiddenIcon {
            iconContainerView.isHidden = true
        }
        
        layoutIfNeeded()
    }
    
    func updatePalette() {
        progressView.progressColor = palette.color
    }
}
