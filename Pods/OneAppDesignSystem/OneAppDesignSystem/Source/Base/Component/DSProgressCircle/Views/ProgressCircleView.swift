//
//  ProgressCircleView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/3/2566 BE.
//

import UIKit

private enum Constants {
    static let startFrom90Degrees: CGFloat = 1.5
    static let endAt450Degrees: CGFloat = 1.5
    static let totalPercentage: Int = 100
}

final class ProgressCircleView: UIView {

    var lineWidth: CGFloat = 16 {
        didSet {
            updatePath()
        }
    }

    var strokeEnd: CGFloat = 1 {
        didSet {
            progressLayer.strokeEnd = strokeEnd
        }
    }

    var trackColor: UIColor = DSColor.componentDatavisualizeTotal {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }

    var progressColor: UIColor = .primaryConfidentBlue {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }

    var inset: CGFloat = 0 {
        didSet { updatePath() }
    }

    lazy var trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = trackColor.cgColor
        layer.lineWidth = lineWidth
        return layer
    }()

    lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = progressColor.cgColor
        layer.lineWidth = lineWidth
        layer.lineCap = .round
        return layer
    }()
    
    private var startAngleValue: CGFloat = .pi * Constants.startFrom90Degrees
    private var endAngleValue: CGFloat = .pi * Constants.endAt450Degrees

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }
    
    func drawProgress(from current: Int, to total: Int = Constants.totalPercentage) {
        let ratio = Double(current) / (Double(total) + 1.0)
        let value = Constants.startFrom90Degrees + CGFloat(ratio * 2)
        endAngleValue = .pi * value
    }
    
    func drawProgress(ratio: Double) {
        let drawRatio = ratio / 100.0
        let value = Constants.startFrom90Degrees + CGFloat(drawRatio * 2)
        endAngleValue = .pi * value
        updatePath()
    }
}

// MARK: - Private
private extension ProgressCircleView {
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
                                        startAngle: startAngleValue,
                                        endAngle: endAngleValue,
                                        clockwise: true)
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
