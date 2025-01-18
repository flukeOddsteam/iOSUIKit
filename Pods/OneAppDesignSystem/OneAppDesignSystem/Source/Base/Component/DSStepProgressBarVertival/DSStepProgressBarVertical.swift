//
//  DSStepProgressBarVertical.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/11/2566 BE.
//

import UIKit

/**
    It rendering UIView to Progress bar component used in DSStepProgressBarVertical as same as figma that ux designed
    ![image](/DocumentationImages/ds-stepprogress-bar-vertical.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSStepProgressBarVertical` Class to the UIView
    2. Set intrinsic size to Placeholder
    3. Please assign height or set top and bottom constraint.
    4. Connect UIView to `@IBOutlet` in text editor
    5. Using setup function for set default state
     ```
     @IBOutlet weak var progressBar: DSStepProgressBarVertical!

     override func viewDidLoad() {
         super.viewDidLoad()
         progressBar.setup(state: .success, visibleLine: true)
     }
     ```
 */
public final class DSStepProgressBarVertical: UIView {

    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    public var state: DSStepProgressBarVerticalState = .success {
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

    /// Setup DSStepProgressBarVertical
    ///
    /// Parameter for setup DSStepProgressBarVertical
    /// - Parameter state: to display state on DSStepProgressBarVertical
    /// - Parameter visibleLine: to display line bottom of circle view.
    public func setup(state: DSStepProgressBarVerticalState, visibleLine: Bool) {
        self.state = state
        self.setLine(visible: visibleLine)
    }

    /// Setup display line
    ///
    /// Parameter set show/hide line for DSStepProgressBarVertical
    /// - Parameter visible: to display line.
    public func setLine(visible: Bool) {
        lineView.isHidden = !visible
    }
}

private extension DSStepProgressBarVertical {
    func commonInit() {
        setupXib()
        setUpUI()
        updateAppearance()
    }
    
    func setUpUI() {
        circleView.setCircle()

        textLabel.font = DSFont.labelInput
        iconImageView.tintColor = DSColor.componentLightBackground
        iconImageView.tintAdjustmentMode = .normal

        lineView.layer.cornerRadius = 2
    }

    func updateAppearance() {
        let appearance: StepProgressBarVerticalAppearance = state
        textLabel.isHidden = appearance.isHiddenLabel
        textLabel.textColor = appearance.textColor
        textLabel.text = appearance.progressText

        iconImageView.isHidden = appearance.isHiddenImage
        iconImageView.image = appearance.iconImage?.image.withRenderingMode(.alwaysTemplate)

        circleView.backgroundColor = appearance.circleBackgroundColor
        circleView.setBorder(width: appearance.borderWidth, color: appearance.borderColor)

        lineView.backgroundColor = appearance.lineColor
    }
}
