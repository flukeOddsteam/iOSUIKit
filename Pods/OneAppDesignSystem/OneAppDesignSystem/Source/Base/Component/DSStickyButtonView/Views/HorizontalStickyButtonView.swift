//
//  HorizontalStickyButtonView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/12/2565 BE.
//

import Foundation
import UIKit

enum HorizontalStickyButtonStyle {
    case ghost(ghostButtonText: String,
               ghostButtonAction: ActionHandler? = nil)
    case scondary(secondaryButtonText: String,
                  secondaryButtonAction: ActionHandler? = nil)
}

final class HorizontalStickyButtonView: UIView {
    @IBOutlet weak var primaryButton: DSPrimaryButton!
    @IBOutlet weak var secondaryButton: DSSecondaryButton!
    @IBOutlet weak var ghostButton: DSGhostButton!
    
    var primaryButtonAction: ActionHandler?
    var secondaryButtonAction: ActionHandler?
    var ghostButtonAction: ActionHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        setupXib()
    }
    
    func setup(style: HorizontalStickyButtonStyle,
               primaryButtonText: String,
               primaryButtonAction: ActionHandler? = nil) {
        primaryButton.largePrimaryText(text: primaryButtonText)
        self.primaryButtonAction = primaryButtonAction
        switch style {
        case .ghost(let ghostButtonText, let ghostButtonAction):
            ghostButton.largeGhostText(text: ghostButtonText)
            self.ghostButtonAction = ghostButtonAction
            secondaryButton.isHidden = true
        case .scondary(let secondaryButtonText, let secondaryButtonAction):
            secondaryButton.largeSecondaryText(text: secondaryButtonText)
            self.secondaryButtonAction = secondaryButtonAction
            ghostButton.isHidden = true
        }
    }
}

// MARK: - Action
extension HorizontalStickyButtonView {
    @IBAction func onPressedSecondaryButton(_ sender: Any) {
        secondaryButtonAction?()
    }
    
    @IBAction func onPressedPrimaryButton(_ sender: Any) {
        primaryButtonAction?()
    }
    
    @IBAction func onPressedGhostButton(_ sender: Any) {
        ghostButtonAction?()
    }
    
}
