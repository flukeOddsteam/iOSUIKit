//
//  DottedLineView.swift
//  StepperMap
//
//  Created by TTB on 1/11/2565 BE.
//

import Foundation
import UIKit

/**
    It rendering UIView to Dotted Line component used in DottedLineView as same as figma that ux designed
    ![image](/DocumentationImages/ds-dotted-line.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DottedLineView` Class to the UIView
    2. Connect UIView to `@IBOutlet` in text editor
    3. The init function will setup style of this UIView
     ```
     @IBOutlet weak var dotLineView1: DSDottedLineView!
     
     ```
     Set color:
     ```
     dotLineView1.setup(color: DSColor.componentDisableOutline)
 
     Dot width base on view.
     ```

*/

@IBDesignable
public final class DSDottedLineView: UIView {

	@IBInspectable
    public var lineColor: UIColor = DSColor.componentLightOutline

	@IBInspectable
	public var lineWidth: CGFloat = CGFloat(3)
	
	@IBInspectable
	public var round: Bool = true
	
	@IBInspectable
	public var horizontal: Bool = true
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		initBackgroundColor()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initBackgroundColor()
	}
	
    public override func draw(_ rect: CGRect) {
		let path = UIBezierPath()
		path.lineWidth = lineWidth

		if round {
			configureRoundPath(path: path, rect: rect)
		} else {
			configurePath(path: path, rect: rect)
		}

		lineColor.setStroke()
		
		path.stroke()
	}
    
    public func setup(color: UIColor) {
        self.lineWidth = self.frame.width
        self.lineColor = color
        self.round = true
        self.horizontal = false
    }
    
    public func setAccessibilityIdentifier(id: String? = nil) {
        self.accessibilityIdentifier = id
    }
}

private extension DSDottedLineView {
    func initBackgroundColor() {
        backgroundColor = UIColor.clear
    }
    
    func configurePath(path: UIBezierPath, rect: CGRect) {
        if horizontal {
            let center = rect.height * 0.5
            let drawWidth = rect.size.width - (rect.size.width .truncatingRemainder(dividingBy: (lineWidth * 2))) + lineWidth
            let startPositionX = (rect.size.width - drawWidth) * 0.5 + lineWidth
            
            path.move(to: CGPoint(x: startPositionX, y: center))
            path.addLine(to: CGPoint(x: drawWidth, y: center))
        } else {
            let center = rect.width * 0.5
            let drawHeight = rect.size.height - (rect.size.height .truncatingRemainder(dividingBy: (lineWidth * 2))) + lineWidth
            let startPositionY = (rect.size.height - drawHeight) * 0.5 + lineWidth
            
            path.move(to: CGPoint(x: center, y: startPositionY))
            path.addLine(to: CGPoint(x: center, y: drawHeight))
        }
        
        let dashes: [CGFloat] = [lineWidth, lineWidth]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        path.lineCapStyle = CGLineCap.butt
    }
    
    func configureRoundPath(path: UIBezierPath, rect: CGRect) {
        if horizontal {
            let center = rect.height * 0.5
            let drawWidth = rect.size.width - (rect.size.width .truncatingRemainder(dividingBy: (lineWidth * 2)) )
            let startPositionX = (rect.size.width - drawWidth) * 0.5 + lineWidth
            
            path.move(to: CGPoint(x: startPositionX, y: center))
            path.addLine(to: CGPoint(x: drawWidth, y: center))
            
        } else {
            let center = rect.width * 0.5
            let drawHeight = rect.size.height - (rect.size.height .truncatingRemainder(dividingBy: (lineWidth * 2)))
            let startPositionY = (rect.size.height - drawHeight) * 0.5 + lineWidth
            
            path.move(to: CGPoint(x: center, y: startPositionY))
            path.addLine(to: CGPoint(x: center, y: drawHeight))
        }

        let dashes: [CGFloat] = [0, lineWidth * 2]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        path.lineCapStyle = CGLineCap.round
    }
}
