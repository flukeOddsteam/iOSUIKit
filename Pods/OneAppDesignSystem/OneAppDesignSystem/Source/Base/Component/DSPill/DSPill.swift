//
//  DSPillStatus.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/9/2565 BE.
//

import Foundation
import UIKit

public struct DSCollectionPillStatus {
    var title: String
    var style: DSPillStatusStyle

    public init(title: String, style: DSPillStatusStyle) {
        self.title = title
        self.style = style
    }
}

public struct DSPillViewModel {
    public var style: DSPillStyle
    public var title: String

    public init(style: DSPillStyle, title: String) {
        self.style = style
        self.title = title
    }
}

public enum DSPillStyle {
    case status(_ style: DSPillStatusStyle)
    case tag
    case promotion
}

public enum DSPillStatusStyle {
    case `default`
    case waiting
    case information
    case success
    case warning
    case error
    case risk

    var backgroundColor: UIColor {
        switch self {
        case .`default`:
            return DSColor.componentStatusBackgroundDefault
        case .waiting:
            return DSColor.componentStatusBackgroundWaiting
        case .information:
            return DSColor.componentStatusBackgroundInformation
        case .success:
            return DSColor.componentStatusBackgroundSuccess
        case .warning:
            return DSColor.componentStatusBackgroundWarning
        case .error:
            return DSColor.componentStatusBackgroundError
        case .risk:
            return DSColor.componentStatusBackgroundSpecial1
        }
    }
}

/**
 Custom component DSPill

 ![image](/DocumentationImages/ds-pill.png)

 **Usage Example:**
 1. Import oneappdesignsystem
 2. Create UIView on .xib file and assign `DSPill` Class to the UIView
 3. Binding constraint and don't set height and width (It's will dynamic layout by DSPill, Can set placeholder height or width in story board to avoid error warning)
 4. Connect UIView to `@IBOutlet` in text editor
 5. Call `func setup()` in `viewDidLoad()`
 ```
 @IBOutlet weak var pill1: DSPill!
 @IBOutlet weak var pill2: DSPill!
 @IBOutlet weak var pill3: DSPill!
 @IBOutlet weak var pill4: DSPill!
 @IBOutlet weak var pill5: DSPill!
 @IBOutlet weak var pill6: DSPill!
 @IBOutlet weak var pill7: DSPill!
 @IBOutlet weak var pill8: DSPill!
 @IBOutlet weak var pill9: DSPill!
 

 override func viewDidLoad() {
 super.viewDidLoad()
 pill1.setup(style: .status(.default), title: "DEFAULT")
 pill2.setup(style: .status(.waiting), title: "WAITING")
 pill3.setup(style: .status(.information), title: "INFORMATION")
 pill4.setup(style: .status(.success), title: "SUCCESS")
 pill5.setup(style: .status(.warning), title: "WARNING")
 pill6.setup(style: .status(.risk), title: "RISK")
 pill7.setup(style: .status(.error), title: "ERROR")
 pill8.setup(style: .tag, title: "DEFAULT TAG")
 pill9.setup(style: .promotion, title: "PROMOTION TAG")

 }
 ```

 **DSPill has 3 style:**
 - status
 - tag
 - promotion

 **And DSPill Style status has 6 variants:**
 - default
 - waiting
 - information
 - success
 - warning
 - risk
 - error
 */
public final class DSPill: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!

    public var textValue: String = "" {
        didSet {
            label.text = textValue
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
    }

    public func setup(style: DSPillStyle, title: String) {
        updatePill(style: style, title: title)
    }

    public func setup(viewModel: DSPillViewModel) {
        updatePill(style: viewModel.style, title: viewModel.title)
    }

    public func setAccessibilityIdentifier(
        id: String? = nil,
        labelId: String? = nil
    ) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = labelId
    }
}

private extension DSPill {
    func updatePill(style: DSPillStyle, title: String) {
        label.font = DSFont.allCap
        textValue = title

        switch style {
        case .status(let style):
            label.textColor = DSColor.componentStatusDefault
            contentView.backgroundColor = style.backgroundColor
        case .tag:
            label.textColor = DSColor.componentLightDesc
            contentView.backgroundColor = DSColor.componentLightBackgroundHighlight
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = DSColor.componentLightOutline.cgColor
        case .promotion:
            label.textColor = DSColor.componentDarkDefault
            contentView.backgroundColor = DSColor.componentSummaryDefault
            contentView.setBorder(width: 1, color: DSColor.componentLightDefault)
        }
        contentView.layer.cornerRadius = DSRadius.radius4px.rawValue
    }
}
