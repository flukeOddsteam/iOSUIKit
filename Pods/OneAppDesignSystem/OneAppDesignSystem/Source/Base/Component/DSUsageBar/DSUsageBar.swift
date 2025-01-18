//
//  DSUsageBar.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/12/2565 BE.
//

import UIKit

public enum DSUsageBarSecondaryColor {
    case componentDatavisualizeSecondaryValue
    case componentDatavisualizeTertiaryValue
    case componentDatavisualizeCustomValueGrey
    case componentDatavisualizeCustomValueBrown
    case componentDatavisualizeCustomValuePeach
    case componentDatavisualizeCustomValuePink
    case componentDatavisualizeCustomValueYellow
    case componentDatavisualizeCustomValueSkyBlue
    case componentDatavisualizeCustomValueBlue
    case componentDatavisualizeCustomValueTurquoise
    case componentDatavisualizeCustomValueGreen
    
    public var color: UIColor {
        switch self {
        case .componentDatavisualizeSecondaryValue: return DSColor.componentDatavisualizeSecondaryValue
        case .componentDatavisualizeTertiaryValue: return DSColor.componentDatavisualizeTertiaryValue
        case .componentDatavisualizeCustomValueGrey: return DSColor.componentDatavisualizeCustomValueGrey
        case .componentDatavisualizeCustomValueBrown: return DSColor.componentDatavisualizeCustomValueBrown
        case .componentDatavisualizeCustomValuePeach: return DSColor.componentDatavisualizeCustomValuePeach
        case .componentDatavisualizeCustomValuePink: return DSColor.componentDatavisualizeCustomValuePink
        case .componentDatavisualizeCustomValueYellow: return DSColor.componentDatavisualizeCustomValueYellow
        case .componentDatavisualizeCustomValueSkyBlue: return DSColor.componentDatavisualizeCustomValueSkyBlue
        case .componentDatavisualizeCustomValueBlue: return DSColor.componentDatavisualizeCustomValueBlue
        case .componentDatavisualizeCustomValueTurquoise: return DSColor.componentDatavisualizeCustomValueTurquoise
        case .componentDatavisualizeCustomValueGreen: return DSColor.componentDatavisualizeCustomValueGreen
        }
    }
}

/**
    Custom component DSUsageBar for Design System
 
    ![image](/DocumentationImages/ds-usage-bar.png)
 
    **Usage Example:**
    1. Create UIView on .xib file and assign `DSUsageBar` Class to the UIView.
    2. Binding constraint and don't set `width`  and  `height`
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var usageBar: DSUsageBar!
 
     override func viewDidLoad() {
         super.viewDidLoad()
         usageBar.setup(title: "Title",
                         leftLabel: "Label",
                         rightLabel: "Label",
                         leftValue: "Value",
                         rightValue: "Value",
                         primaryPercentBar: 104 / 343 * 100,
                         secondaryPercentBar: 41 / 343 * 100,
                         secondaryBarColor: .componentDatavisualizeCustomValueBlue,
                         total: "Total 100,000.00")
     ```
 */
public final class DSUsageBar: UIView {
    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftValue: UILabel!
    @IBOutlet weak var rightValue: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var primaryBarView: UIView!
    @IBOutlet weak var primaryBarWidthRatio: NSLayoutConstraint!
    @IBOutlet weak var secondaryBarView: UIView!
    @IBOutlet weak var secondaryBarWidthRatio: NSLayoutConstraint!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    
    public var secondaryBarColor: DSUsageBarSecondaryColor? = .componentDatavisualizeSecondaryValue {
        didSet {
            secondaryBarView.backgroundColor = secondaryBarColor?.color
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
        commonInit()
    }

    /// Setup DSUsageBar
    ///
    /// Parameter for setup DSUsageBar
    /// - Parameter title: text to display as title of DSUsageBar (optional).
    /// - Parameter leftLabel: text to display as left label of DSUsageBar which is related to leftValue (mandatory).
    /// - Parameter rightLabel: text to display as right label of DSUsageBar which is related to rightValue (mandatory).
    /// - Parameter leftValue: text to display as a value of the Usage bar Primary Navy (mandatory).
    /// - Parameter rightValue: text to display as a whole value of the Usage bar (mandatory).
    /// - Parameter primaryPercentBar: an amount of the Usage bar Primary Navy will display on progress bar (mandatory).
    /// - Parameter secondaryPercentBar: an amount of the Usage bar Secondary will display on progress bar  (optional).
    /// - Parameter secondaryBarColor: color of the Secondary bar of DSUsageBar (optional).
    /// - Parameter total: text to display as a total amount of DSUsageBar's value (optional).
    public func setup(title: String = "",
                      leftLabel: String = "",
                      rightLabel: String = "",
                      leftValue: String,
                      rightValue: String,
                      primaryPercentBar: Double,
                      secondaryPercentBar: Double? = 0.00,
                      secondaryBarColor: DSUsageBarSecondaryColor? = .componentDatavisualizeSecondaryValue,
                      total: String = "") {
        self.leftLabel.text = leftLabel
        self.rightLabel.text = rightLabel
        self.leftValue.text = leftValue
        self.rightValue.text = rightValue
        self.primaryBarWidthRatio = self.primaryBarWidthRatio.setMultiplier(multiplier: primaryPercentBar / 100)
        self.secondaryBarWidthRatio = self.secondaryBarWidthRatio.setMultiplier(multiplier: (primaryPercentBar + (secondaryPercentBar ?? 0.00)) / 100)
        self.secondaryBarColor = secondaryBarColor
        if title != "" {
            titleView.isHidden = false
            self.titleLabel.text = title
        } else {
            titleView.isHidden = true
        }
        
        if total != "" {
            totalView.isHidden = false
            self.totalLabel.text = total
        } else {
            totalView.isHidden = true
        }
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           titleLabelId: String? = nil,
                                           leftLabelId: String? = nil,
                                           rightLabelId: String? = nil,
                                           leftValueId: String? = nil,
                                           rightValueId: String? = nil,
                                           barViewId: String? = nil,
                                           totalLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.leftLabel.accessibilityIdentifier = leftLabelId
        self.rightLabel.accessibilityIdentifier = rightLabelId
        self.leftValue.accessibilityIdentifier = leftValueId
        self.rightValue.accessibilityIdentifier = rightValueId
        self.barView.accessibilityIdentifier = barViewId
        self.totalLabel.accessibilityIdentifier = totalLabelId
    }
    
}

// MARK: - Private
private extension DSUsageBar {
    func commonInit() {
        setupUI()
    }
    
    func setupUI() {
        titleLabel.font = DSFont.subtitle
        titleLabel.textColor = DSColor.componentLightDefault
        leftLabel.font = DSFont.labelInput
        rightLabel.font = DSFont.labelInput
        leftLabel.textColor = DSColor.componentLightDesc
        rightLabel.textColor = DSColor.componentLightDesc
        leftValue.font = DSFont.h4
        rightValue.font = DSFont.h4
        leftValue.textColor = DSColor.componentLightDefault
        rightValue.textColor = DSColor.componentLightDefault
        totalLabel.font = DSFont.labelList
        totalLabel.textColor = DSColor.componentLightDesc
        barView.setRadius(radius: .radius4px)
        primaryBarView.setRadius(radius: .radius4px)
        primaryBarView.backgroundColor = DSColor.componentDatavisualizePrimaryValue
        secondaryBarView.setRadius(radius: .radius4px)
        barView.backgroundColor = DSColor.componentDatavisualizeTotal
    }
}
