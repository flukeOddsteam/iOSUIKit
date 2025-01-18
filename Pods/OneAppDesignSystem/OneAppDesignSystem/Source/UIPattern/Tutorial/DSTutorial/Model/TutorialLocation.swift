//
//  TutorialLocation.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/7/2567 BE.
//

import UIKit

private enum Constants {
    static let padding: CGFloat = 16
    static let tooltipWidth: CGFloat = 240
    static let animationDistance: CGFloat = 8
}

protocol TutorialLocationInterface {
    var startPosition: CGRect { get set }
    var endPosition: CGRect { get set }
}

struct TutorialLocation: TutorialLocationInterface {
    var startPosition: CGRect = .zero
    var endPosition: CGRect = .zero
    
    private var position: DSTutorialPosition
    private var screenBounds: CGRect
    private var highlightedRect: CGRect
    private var tooltipRect: CGRect
    
    init(
        position: DSTutorialPosition,
        screenBounds: CGRect = UIScreen.main.bounds,
        highlightedRect: CGRect,
        tooltipRect: CGRect
    ) {
        self.position = position
        self.screenBounds = screenBounds
        self.highlightedRect = highlightedRect
        self.tooltipRect = tooltipRect
        
        self.endPosition = CGRect(
            x: getXPosition(),
            y: getYPosition(),
            width: tooltipRect.width,
            height: tooltipRect.height
        )
        
        var startRect = self.endPosition
        let padding = position.direction.value(
            top: -Constants.animationDistance,
            bottom: Constants.animationDistance
        )
        
        startRect.origin.y += padding
        self.startPosition = startRect
    }
}

// MARK: - Private
private extension TutorialLocation {
    
    func getXPosition() -> CGFloat {
        switch position {
        case .topLeft, .bottomLeft:
            return Constants.padding
        case .topCenter, .bottomCenter:
            return (screenBounds.width / 2) - (Constants.tooltipWidth / 2)
        case .topRight, .bottomRight:
            let width = screenBounds.width
            return width - Constants.padding - Constants.tooltipWidth
        }
    }
    
    func getYPosition() -> CGFloat {
        switch position.direction {
        case .top:
            return highlightedRect.minY - Constants.padding - tooltipRect.size.height
        case .bottom:
            return highlightedRect.maxY + Constants.padding
        }
    }
}
