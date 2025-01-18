//
//  ScrollingPageControl.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/11/2565 BE.
//

import UIKit

public protocol ScrollingPageControlDelegate: AnyObject {
    // If delegate is nil or the implementation returns nil for a given dot, the default
    // circle will be used. Returned views should react to having their tint color changed
    func viewForDot(at index: Int) -> UIView?
}

public final class ScrollingPageControl: UIView {
    weak var delegate: ScrollingPageControlDelegate? {
        didSet {
            createViews()
        }
    }
    // The number of dots
    var pages: Int = 0 {
        didSet {
            guard pages != oldValue else { return }
            pages = max(0, pages)
            invalidateIntrinsicContentSize()
            createViews()
        }
    }
    private func createViews() {
        dotViews = (0..<pages).map { index in
            delegate?.viewForDot(at: index) ?? CircularView(frame: CGRect(origin: .zero, size: CGSize(width: dotSize, height: dotSize)))
        }
    }
    // The index of the currently selected page
    var selectedPage: Int = 0 {
        didSet {
            guard selectedPage != oldValue else { return }
            selectedPage = max(0, min(selectedPage, pages - 1))
            updateColors()
            if (0..<centerDots).contains(selectedPage - pageOffset) {
                centerOffset = selectedPage - pageOffset
            } else {
                pageOffset = selectedPage - centerOffset
            }
        }
    }
    // The maximum number of dots that will show in the control
    var maxDots = 5 {
        didSet {
            maxDots = max(3, maxDots)
            if maxDots % 2 == 0 {
                maxDots += 1
                print("maxDots has to be an odd number")
            }
            invalidateIntrinsicContentSize()
        }
    }
    // The number of dots that will be centered and full-sized
    var centerDots = 1 {
        didSet {
            centerDots = max(1, centerDots)
            if centerDots > maxDots {
                centerDots = maxDots
                print("centerDots has to be equal or smaller than maxDots")
            }
            if centerDots % 2 == 0 {
                centerDots += 1
                print("centerDots has to be an odd number")
            }
            invalidateIntrinsicContentSize()
        }
    }
    // The duration, in seconds, of the dot slide animation
    var slideDuration: TimeInterval = 0.15
    private var centerOffset = 0
    var isAnimate: Bool = true
    private var pageOffset = 0 {
        didSet {
            guard isAnimate else {
                updatePositions()
                isAnimate = true
                return
            }

            UIView.animate(withDuration: slideDuration,
                           delay: 0.15,
                           options: [],
                           animations: self.updatePositions,
                           completion: nil
            )
        }
    }

    var dotViews: [UIView] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            dotViews.forEach(addSubview)
            updateColors()
            setNeedsLayout()
        }
    }

    // The color of all the unselected dots
    var dotColor = UIColor.lightGray { didSet { updateColors() } }
    // The color of the currently selected dot
    var selectedColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) { didSet { updateColors() } }

    // The size of the dots
    var dotSize: CGFloat = 6 {
        didSet {
            dotSize = max(1, dotSize)
            dotViews.forEach { $0.frame = CGRect(origin: .zero, size: CGSize(width: dotSize, height: dotSize)) }
            invalidateIntrinsicContentSize()
        }
    }
    // The space between dots
    var spacing: CGFloat = 4 {
        didSet {
            spacing = max(1, spacing)
            invalidateIntrinsicContentSize()
        }
    }

    public init() {
        super.init(frame: .zero)
        isOpaque = false
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }

    private var lastSize = CGSize.zero
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.size != lastSize else { return }
        lastSize = bounds.size
        updatePositions()
    }

    private func updateColors() {
        dotViews.enumerated().forEach { page, dot in
            dot.tintColor = page == selectedPage ? selectedColor : dotColor
        }
    }

    internal func updatePositions() {
        let centerDots = min(self.centerDots, pages)
        let maxDots = min(self.maxDots, pages)
        let sidePages = (maxDots - centerDots) / 2
        var horizontalOffset = CGFloat(-pageOffset + sidePages) * (dotSize + spacing) + (bounds.width - intrinsicContentSize.width) / 2
        if selectedPage < 3 {
            horizontalOffset = CGFloat(0)
        } else if selectedPage > pages - 3 {
            horizontalOffset = CGFloat(-(pages - 3) + sidePages) * (dotSize + spacing) + (bounds.width - intrinsicContentSize.width) / 2
        }
        let centerPage = centerDots / 2 + pageOffset
        dotViews.enumerated().forEach { page, dot in
            let center = CGPoint(x: horizontalOffset + bounds.minX + dotSize / 2 + (dotSize + spacing) * CGFloat(page), y: bounds.midY)
            let scale: CGFloat = {
                return getScale(
                    page: page,
                    centerPage: centerPage,
                    currentDot: page + 1
                )
            }()
            dot.frame = CGRect(origin: .zero, size: CGSize(width: dotSize * scale, height: dotSize * scale))
            dot.center = center
        }
    }

    func getScale(
        page: Int,
        centerPage: Int,
        currentDot: Int
    ) -> CGFloat {
        let isPagesGreaterThanSix = pages > 5
        guard isPagesGreaterThanSix else { return 1 }

        let sumCount: Int
        sumCount = pages > 6 ? pages - 6 : 0
        if selectedPage <= 2 {
            return returnScaleWithCurrent(currentDot: currentDot,
                                          page: page,
                                          centerPage: centerPage
            )
        } else if selectedPage >= (3 + sumCount) {
            return returnScaleWithSumCount(currentDot: currentDot,
                                           sumCount: sumCount,
                                           centerPage: centerPage,
                                           page: page
            )
        } else {
            let distance = abs(page - centerPage)
            if distance > (maxDots / 2) { return 0 }
            return [1, 1, 0.33, 0.16][max(0, min(3, distance - centerDots / 2))]
        }
    }

    private func returnScaleWithSumCount(
        currentDot: Int,
        sumCount: Int,
        centerPage: Int,
        page: Int
    ) -> CGFloat {
        if currentDot == (2 + sumCount) {
            return 0.33
        } else if currentDot >= (3 + sumCount) {
            return 1
        } else {
            return 0
        }
    }

    private func returnScaleWithCurrent(currentDot: Int, page: Int, centerPage: Int) -> CGFloat {
        if currentDot <= 4 {
            return 1
        } else if currentDot == 5 {
            return 0.33
        } else {
            return 0
        }
    }

    public override var intrinsicContentSize: CGSize {
        let pages = min(maxDots, self.pages)
        let width = CGFloat(pages) * dotSize + CGFloat(pages - 1) * spacing
        let height = dotSize
        return CGSize(width: width, height: height)
    }
}
