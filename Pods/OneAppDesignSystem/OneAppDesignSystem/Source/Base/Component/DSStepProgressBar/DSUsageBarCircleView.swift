import Foundation
import UIKit

@IBDesignable public class DSUsageBarCircleView: UIView {

    @IBInspectable public var lineWidth: CGFloat = 5 {
        didSet { updatePath() }
    }

    @IBInspectable public var strokeEnd: CGFloat = 1 {
        didSet { progressLayer.strokeEnd = strokeEnd }
    }

    @IBInspectable public var trackColor: UIColor = DSColor.componentSummaryOutline {
        didSet { trackLayer.strokeColor = trackColor.cgColor }
    }

    @IBInspectable public var progressColor: UIColor = DSColor.componentSummaryPrimaryActive {
        didSet { progressLayer.strokeColor = progressColor.cgColor }
    }

    @IBInspectable public var inset: CGFloat = 0 {
        didSet { updatePath() }
    }

    private lazy var trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = trackColor.cgColor
        layer.lineWidth = lineWidth
        return layer
    }()

    private lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = progressColor.cgColor
        layer.lineWidth = lineWidth
        return layer
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }

    private static let startFrom90Degrees: CGFloat = 1.5
    private static let endAt450Degrees: CGFloat = 1.5

    /// Start angle will start from 0 degree and continue clockwise (if clock wise is true).
    /// - The default value is 1.5(.pi) or start from 90 degree (0 o'clock).
    /// - note:
    /// - 1(.pi) = 0  degree, or 9:00 clockwise
    /// - 1.5(.pi) = 90  degree, or 12:00 clockwise
    /// - 2(.pi) = 180 degree, or 3:00 clockwise
    /// - 2.5(.pi) = 270 degree, or 6:00 clockwise
    /// - 3(.pi) = 360 degree, or 9:00 clockwise
    var startAngle: CGFloat {
        return _startAngle
    }
    private var _startAngle: CGFloat = .pi * startFrom90Degrees

    /// Define 'End angle' will draw circle ring (clockwise) base-on .pi value of start angle.
    /// - The default value is 3.5(.pi) or start end at 450 degree (12 o'clock).
    /// - note:
    /// - 1(.pi) = 0  degree, or 9:00 clockwise
    /// - 1.5(.pi) = 90  degree, or 12:00 clockwise
    /// - 2(.pi) = 180 degree, or 3:00 clockwise
    /// - 2.5(.pi) = 270 degree, or 6:00 clockwise
    /// - 3(.pi) = 360 degree, or 9:00 clockwise
    var endAngle: CGFloat {
        return _endAngle
    }
    private var _endAngle: CGFloat = .pi * endAt450Degrees

    /// direction of the circle progress.
    public var clockWise: Bool = true

    func drawProgress(from current: Int, to total: Int) {
        let ratio = Double(current) / (Double(total) + 1.0)
        let value = DSUsageBarCircleView.startFrom90Degrees + CGFloat(ratio * 2)
        _endAngle = .pi * value
    }
    
    func drawProgress(ratio: Double) {
        let drawRatio = ratio / 100.0
        let value = DSUsageBarCircleView.startFrom90Degrees + CGFloat(drawRatio * 2)
        _endAngle = .pi * value
        updatePath()
    }
}

// MARK: - Private
private extension DSUsageBarCircleView {
    func setupView() {
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }

    func updatePath() {
        let rect = bounds.insetBy(dx: lineWidth / 2 + inset, dy: lineWidth / 2 + inset)
        let centre = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        let progressPath = UIBezierPath(arcCenter: centre,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: clockWise)
        progressLayer.path = progressPath.cgPath
        progressLayer.lineWidth = lineWidth

        let trackPath = UIBezierPath(arcCenter: centre,
                                        radius: radius,
                                        startAngle: .pi,
                                        endAngle: 4 * .pi,
                                        clockwise: true)
        trackLayer.path = trackPath.cgPath
        trackLayer.lineWidth = lineWidth
    }
}
