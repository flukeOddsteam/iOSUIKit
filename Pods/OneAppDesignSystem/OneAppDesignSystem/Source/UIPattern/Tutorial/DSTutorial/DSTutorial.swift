//
//  DSTutorial.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/7/2567 BE.
//

import UIKit

/**
 Custom component DSTutorial for Design System
 
 ![image](/DocumentationImages/ds-tutorial.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSTutorial` Class to the UIView.
 2. Binding constraint to cover the entire screen.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidAppear(_ animated: Bool)` or where ever you want.
    ```
        @IBOutlet weak var tutorial: DSTutorial!
 
         override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(animated)
             let smallImageRect = self.view.convert(smallImage.bounds, from: smallImage)
             if smallImageRect.midY > self.view.frame.height/2 {
                 let offset = CGPoint(
                     x: .zero,
                     y: smallImageRect.midY - self.view.frame.height/2
                 )
                 
                 scrollToOffset(offset: offset) {
                     let rect = self.view.convert(
                         self.smallImage.bounds,
                         from: self.smallImage
                     )
                     self.prepareTutorial(
                         rect: rect,
                         arrowPosition: self.tutorial.tooltipRect.minX + 108 + 12,
                         radius: 12,
                         position: .bottomCenter
                     )
                     self.tutorial.show()
                 }
             }else {
                 let rect = self.view.convert(
                     self.smallImage.bounds,
                     from: self.smallImage
                 )
                 self.prepareTutorial(
                     rect: rect,
                     arrowPosition: self.tutorial.tooltipRect.minX + 108 + 12,
                     radius: 12,
                     position: .bottomCenter
                 )
                 self.tutorial.show()
             }
    ```
    Scroll to view need highlight.
    ```
       func scrollToOffset(offset: CGPoint, completion: @escaping () -> Void) {
           UIView.animate(withDuration: 0.3) {
               self.scrollView.setContentOffset(offset, animated: false)
           } completion: { _ in
               completion()
           }
       }
    ```
 
    Set rect for DSTutorial to draw highlightBox.
 
    Set arrowPosition for DSTutorial to mark position arrow.
 
    Set radius for DSTutorial to draw radius of highlightBox.
 
    Set position for DSTutorial to mark position of tooltip.
 
    For data to display on Tooltip of Tutorial,
    ```
     func prepareTutorial(
         rect: CGRect,
         arrowPosition: CGFloat,
         radius: CGFloat,
         position: DSTutorialPosition
     ) {
         let viewModel = DSTutorialViewModel(
             title: "Label",
             description: "Desc Message here, keep this short, 2 lines maximum.",
             step: "1/4",
             buttonTitle: "ถัดไป",
             position: position,
             arrowPosition: arrowPosition,
             tooltipState: ture,
             highlightedRect: rect,
             highlightedRadius: radius
         )
         tutorial.setup(viewModel: viewModel)
     }
    ```
    Display tooltip position topLeft of highlightBox:
    ```
        self.prepareTutorial(
        rect: rect,
        arrowPosition: self.view.frame.width / 2,
        radius: 12,
        position: .topLeft
    )
    ```
    Display tooltip position topRight of highlightBox:
    ```
        self.prepareTutorial(
        rect: rect,
        arrowPosition: self.view.frame.width / 2,
        radius: 12,
        position: .topRight
    )
    ```
    Display tooltip position topCenter of highlightBox:
    ```
        self.prepareTutorial(
        rect: rect,
        arrowPosition: self.view.frame.width / 2,
        radius: 12,
        position: .topCenter
    )
    ```
    Display tooltip position bottomLeft of highlightBox:
    ```
        self.prepareTutorial(
        rect: rect,
        arrowPosition: self.view.frame.width / 2,
        radius: 12,
        position: .bottomLeft
    )
    ```
    Display tooltip position bottomRight of highlightBox:
    ```
        self.prepareTutorial(
        rect: rect,
        arrowPosition: self.view.frame.width / 2,
        radius: 12,
        position: .bottomRight
    )
    ```
    Display tooltip position bottomCenter of highlightBox:
    ```
        self.prepareTutorial(
        rect: rect,
        arrowPosition: self.view.frame.width / 2,
        radius: 12,
        position: .bottomCenter
    )
    ```
    DSTutorialDelegate:
    ```
       extension KcsTutorialViewController: DSTutorialDelegate {
           func tutorialSecondaryButtonDidTapped(_ tutorial: DSTutorial) {
               state.next()
               tutorial.dismiss()
               performDisplay()
           }
           
           func tutorialCloseButtonDidTapped(_ tutorial: DSTutorial) {
               tutorial.dismiss()
               tutorial.isHidden = true
           }
           
           func tutorialPrimaryButtonDidTapped(_ tutorial: DSTutorial) {
               tutorial.dismiss()
               tutorial.isHidden = true
               scrollToTop()
           }
       }
    ```
 */

public protocol DSTutorialDelegate: AnyObject {
    func tutorialCloseButtonDidTapped(_ tutorial: DSTutorial)
    func tutorialPrimaryButtonDidTapped(_ tutorial: DSTutorial)
    func tutorialSecondaryButtonDidTapped(_ tutorial: DSTutorial)
}

public final class DSTutorial: UIView {
    
    public var highlightedRect: CGRect = .zero
    public var highlightedRadius: CGFloat = .zero
    public var position: DSTutorialPosition = .topLeft
    public var arrowPosition: CGFloat = .zero
    
    public weak var delegate: DSTutorialDelegate?
    
    private var tooltip: TooltipView!
    private var location: TutorialLocationInterface!
    private var maskingLayer: CAShapeLayer!
    
    private var leadingTooltipConstraint: NSLayoutConstraint!
    private var topTooltipConstraint: NSLayoutConstraint!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let firstLayer = layer.sublayers?.first, firstLayer.isEqual(maskingLayer) {
            layer.sublayers?.removeFirst()
        }

        let overlayPath = UIBezierPath(rect: self.bounds)
        
        let transparentPath = UIBezierPath(
            roundedRect: highlightedRect,
            cornerRadius: highlightedRadius
        )
        
        overlayPath.append(transparentPath)
        overlayPath.usesEvenOddFillRule = true
        
        self.backgroundColor = UIColor.clear
        
        maskingLayer = CAShapeLayer()
        maskingLayer.frame = self.bounds
        maskingLayer.path = overlayPath.cgPath
        maskingLayer.fillRule = .evenOdd
        maskingLayer.fillColor = DSColor.otherBackgroundOverlayScreen.cgColor
        self.layer.insertSublayer(maskingLayer, at: .zero)
    }
    
    public func setup(viewModel: DSTutorialViewModel) {
        tooltip.update(
            viewModel: viewModel
        )
        
        position = viewModel.position
        arrowPosition = viewModel.arrowPosition
        highlightedRect = viewModel.highlightedRect
        highlightedRadius = viewModel.highlightedRadius
        layoutIfNeeded()
        
        location = TutorialLocation(
            position: position,
            highlightedRect: highlightedRect,
            tooltipRect: tooltip.frame
        )
        tooltip.alpha = .zero
        leadingTooltipConstraint.constant = location.startPosition.origin.x
        topTooltipConstraint.constant = location.startPosition.origin.y
        layoutIfNeeded()
    }
    
    public func show() {
        tooltip.setArrowPosition(arrowPosition)
        leadingTooltipConstraint.constant = location.endPosition.origin.x
        topTooltipConstraint.constant = location.endPosition.origin.y
        
        performAnimation(
            animated: true,
            interval: 0.3) {
                self.tooltip.alpha = 1
                self.setNeedsDisplay()
                self.layoutIfNeeded()
            }
        tooltip.isHidden = false
    }

    public func dismiss() {
        isHidden = true
        tooltip.isHidden = true
        highlightedRect = .zero
        setNeedsDisplay()
    }

    public func hide() {
        performAnimation(
            animated: true,
            interval: 0.3
        ) {
            self.tooltip.alpha = 0
        }
        highlightedRect = .zero
        setNeedsDisplay()
    }
}

extension DSTutorial: TooltipViewDelegate {
    func tooltipCloseButtonDidTapped(_ view: TooltipView) {
        delegate?.tutorialCloseButtonDidTapped(self)
    }
    
    func tooltipPrimaryButtonDidTapped(_ view: TooltipView) {
        delegate?.tutorialPrimaryButtonDidTapped(self)
    }
    
    func tooltipSecondaryButtonDidTapped(_ view: TooltipView) {
        delegate?.tutorialSecondaryButtonDidTapped(self)
    }
}

extension DSTutorial: TooltipViewDataSource {
    var tooltipRect: CGRect {
        return convert(tooltip.bounds, from: self)
    }
}

// MARK: - Private
private extension DSTutorial {
    func commonInit() {
        let view = TooltipView()
        view.alpha = .zero
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.fillMode = .forwards
        addSubview(view)
        leadingTooltipConstraint = NSLayoutConstraint(
            item: view,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: .zero
        )
        
        topTooltipConstraint = NSLayoutConstraint(
            item: view,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: .zero
        )
        
        NSLayoutConstraint.activate([
            leadingTooltipConstraint,
            topTooltipConstraint
        ])
        
        self.tooltip = view
    }
}
