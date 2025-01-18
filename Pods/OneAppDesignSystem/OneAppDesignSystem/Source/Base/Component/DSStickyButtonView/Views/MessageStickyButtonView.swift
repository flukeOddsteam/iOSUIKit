//
//  MessageStickyButtonView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/10/2565 BE.
//
import UIKit

final class MessageStickyButtonView: UIView {
    
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var descriptionLabel: UILabel!
    @IBOutlet public weak var helperText: DSHelperTextView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        setupXib()
        titleLabel.font = DSFont.paragraphMedium
        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        descriptionLabel.font = DSFont.paragraphSmall
        descriptionLabel.textColor = DSColor.componentLightDesc
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        helperText.isError = true
    }
    
}
