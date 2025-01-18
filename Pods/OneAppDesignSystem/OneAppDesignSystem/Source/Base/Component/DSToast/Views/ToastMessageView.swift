//
//  ToastView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/11/2565 BE.
//

import UIKit

private enum Constants {
    static let defaultNumberOfLine: Int = 2
}

class ToastMessageView: UIView {

    // MARK: - IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var isDisplaying: Bool = false
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(style: DSToastStyle, message: String) {
        iconImageView.image = style.iconImage.withRenderingMode(.alwaysTemplate)
        messageLabel.text = message
        autosizing()
    }
}

// MARK: - ToastMessageViewInterface
extension ToastMessageView: ToastView {
    var view: UIView {
        self
    }
}

// MARK: - Private
private extension ToastMessageView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        messageLabel.font = DSFont.paragraphSmall
        messageLabel.textColor = DSColor.componentCustomBackgroundDefault
        messageLabel.numberOfLines = Constants.defaultNumberOfLine
        
        iconImageView.tintColor = DSColor.componentCustomBackgroundDefault
        
        containerView.layer.cornerRadius = DSRadius.radius12px.rawValue
        containerView.backgroundColor = DSColor.componentCustomBackgroundBackgroundInformative
        containerView.dsShadowDrop(isHidden: false, style: .bottom)
    }
}
