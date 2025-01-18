//
//  DSTutorialViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/7/2567 BE.
//

import UIKit

public struct DSTutorialViewModel {
    public var title: String
    public var description: String
    public var step: String
    public var buttonTitle: String
    public var position: DSTutorialPosition
    public var arrowPosition: CGFloat
    public var tooltipState: DSTutorialTooltipState
    public var highlightedRect: CGRect
    public var highlightedRadius: CGFloat

    public init(
        title: String,
        description: String,
        step: String,
        buttonTitle: String,
        position: DSTutorialPosition,
        arrowPosition: CGFloat,
        tooltipState: DSTutorialTooltipState,
        highlightedRect: CGRect,
        highlightedRadius: CGFloat
    ) {
        self.title = title
        self.description = description
        self.step = step
        self.buttonTitle = buttonTitle
        self.position = position
        self.arrowPosition = arrowPosition
        self.tooltipState = tooltipState
        self.highlightedRect = highlightedRect
        self.highlightedRadius = highlightedRadius
    }
}
