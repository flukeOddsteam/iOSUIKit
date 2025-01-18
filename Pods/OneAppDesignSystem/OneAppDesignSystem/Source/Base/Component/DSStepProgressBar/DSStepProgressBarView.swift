import UIKit

public struct IndicatorStepProgressBar {
    var percentProgress: Double
    var current: Int?
    var total: Int?
    var title: String
    
    public init(percentProgress: Double, current: Int? = nil, total: Int? = nil, title: String) {
        self.percentProgress = percentProgress
        self.current = current
        self.total = total
        self.title = title
    }
}

/**
Custom component StepProgressBar
 
 ![image](/DocumentationImages/ds-progress-bar.png)

 **Usage Example:**
 1. Create UIView on .xib file and assign `DSStepProgressBarView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func progress()` in `viewDidLoad()`
  ```
  @IBOutlet weak var stepProgressBar: DSStepProgressBarView!
  
  override func viewDidLoad() {
     super.viewDidLoad()
     stepProgressBarView.progress(
         progress: IndicatorStepProgressBar(
             percentProgress: 10.00,
             current: 1,
             total: 1,
             title: "Step Title goes here"
         )
     )
  }
  ```
 Hide step label (don't sending `current` or `total`):
 ```
 stepProgressBarView.progress(
     progress: IndicatorStepProgressBar(
         percentProgress: 10,
         title: "Step Title goes here"
     )
 )
 ```
 */
@IBDesignable
public final class DSStepProgressBarView: UIView {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var usageBarCircleView: DSUsageBarCircleView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    private var progress = IndicatorStepProgressBar(percentProgress: 0.00, current: 1, total: 1, title: "")

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public func setAccessibilityIdentifier(id: String? = nil,
                                           titleLabelId: String? = nil,
                                           progressLabelId: String? = nil,
                                           usageBarCircleViewId: String? = nil) {
        self.accessibilityIdentifier = id
        titleLabel.accessibilityIdentifier = titleLabelId
        progressLabel.accessibilityIdentifier = progressLabelId
        usageBarCircleView.accessibilityIdentifier = usageBarCircleViewId
    }

    /// Func create progress and binding data
    ///
    /// Struct IndicatorStepProgressBar
    /// Variables | Description
    /// --- | ---
    /// `percentProgress` | `Double` or `Int` properties is percent of usage bar circle view.
    /// `current` | `Int` Current step of step progress bar.
    /// `total` | `Int` Totle step of step progress bar.
    /// `title` | `String` Title of step progress bar.
    ///
    /// **Note:**
    ///  * If sending `current` or `total` with `nil` section step label for example `1/5` will hide from step progress bar.
    public func progress(progress: IndicatorStepProgressBar) {
        self.progress = progress
        titleLabel.text = progress.title
        setProgressLabel()
        usageBarCircleView.drawProgress(ratio: progress.percentProgress)
    }
}

// MARK: - Action
private extension DSStepProgressBarView {
    func commonInit() {
        setupXib()
        setStyle()
    }
    
    func setStyle() {
        self.backgroundColor = .clear
        backgroundView.backgroundColor = DSColor.componentSummaryBackground
        backgroundView.layer.cornerRadius = DSRadius.radius16px.rawValue
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = DSColor.componentSummaryOutline.cgColor
        
        backgroundView.dsShadowDrop()
        progressLabel.textColor = DSColor.componentSummaryDesc
        titleLabel.font = DSFont.h2
        titleLabel.textColor = DSColor.componentSummaryDefault

        usageBarCircleView.backgroundColor = .clear
        usageBarCircleView.layer.cornerRadius = usageBarCircleView.frame.size.height / 2
        usageBarCircleView.trackColor = DSColor.componentSummaryOutline
        usageBarCircleView.progressColor = DSColor.componentSummaryPrimaryActive
    }
    
    func setProgressLabel() {
        if progress.current == nil || progress.total == 0 || progress.total == nil {
            progressLabel.isHidden = true
        } else {
            progressLabel.isHidden = false
            progressLabel.text = "\(progress.current ?? 0)/\(progress.total ?? 0)"
        }
    }
}
