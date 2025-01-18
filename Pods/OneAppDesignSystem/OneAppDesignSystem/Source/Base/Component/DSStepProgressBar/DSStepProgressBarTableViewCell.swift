import UIKit

public class DSStepProgressBarTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var indicator: DSStepProgressBarView!

    public func set(_ progress: IndicatorStepProgressBar) {
        indicator.progress(progress: progress)
    }
}
