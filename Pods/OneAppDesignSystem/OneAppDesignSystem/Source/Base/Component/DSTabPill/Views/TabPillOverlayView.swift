//
//  TabPillOverlayView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/10/2565 BE.
//

import UIKit

private enum Constants {
    static let maskInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    static let horizontalPadding: CGFloat = 16
    static let verticalPadding: CGFloat = 8
}

class TabPillOverlayView: PagingMenuViewCell {
    
    // MARK: - Views
    
    lazy var textMaskView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var highlightLabel: UILabel = {
        let label = UILabel()
        label.mask = textMaskView
        label.textColor = .white
        label.font = DSFont.h3
        label.textAlignment = .center
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = DSFont.h3
        label.textAlignment = .center
        return label
    }()

    // MARK: - Properties
    weak var referencedMenuView: PagingMenuView?
    weak var referencedFocusView: PagingMenuFocusView?
    
    var hightlightTextColor: UIColor? {
        get {
            return highlightLabel.textColor
        } set {
            highlightLabel.textColor = newValue
        }
    }
    
    var normalTextColor: UIColor? {
        get {
            return titleLabel.textColor
        } set {
            titleLabel.textColor = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
        highlightLabel.mask = textMaskView
        highlightLabel.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addConstraints()
        highlightLabel.mask = textMaskView
        highlightLabel.textColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textMaskView.bounds = bounds.inset(by: Constants.maskInsets)
    }
    
    override var accessibilityElements: [Any]? {
        get {
            return [ titleLabel, highlightLabel ].compactMap { $0 }
        }
        set { }
    }
    
    func configure(title: String) {
        setAccessibility()
        titleLabel.text = title
        highlightLabel.text = title
    }
    
    func updateMask(animated: Bool = true) {
        guard let menuView = referencedMenuView, let focusView = referencedFocusView else {
            return
        }
        
        setFrame(menuView, maskFrame: focusView.frame, animated: animated)
    }
    
    func setFrame(_ menuView: PagingMenuView, maskFrame: CGRect, animated: Bool) {
        textMaskView.frame = menuView.convert(maskFrame, to: highlightLabel).inset(by: Constants.maskInsets)
        
        if let expectedOriginX = menuView.getExpectedAlignmentPositionXIfNeeded() {
            textMaskView.frame.origin.x += expectedOriginX
        }
    }
}

private extension TabPillOverlayView {
    func addConstraints() {
        addSubview(titleLabel)
        addSubview(highlightLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        highlightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, highlightLabel].forEach {
            let trailingConstraint = NSLayoutConstraint(
                item: self,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: $0,
                attribute: .trailing,
                multiplier: 1,
                constant: Constants.horizontalPadding)
            let leadingConstraint = NSLayoutConstraint(
                item: $0,
                attribute: .leading,
                relatedBy: .equal,
                toItem: self,
                attribute: .leading,
                multiplier: 1,
                constant: Constants.horizontalPadding)
            let bottomConstraint = NSLayoutConstraint(
                item: self,
                attribute: .top,
                relatedBy: .equal,
                toItem: $0,
                attribute: .top,
                multiplier: 1,
                constant: Constants.verticalPadding)
            let topConstraint = NSLayoutConstraint(
                item: $0,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: self,
                attribute: .bottom,
                multiplier: 1,
                constant: Constants.verticalPadding)
            
            addConstraints([topConstraint, bottomConstraint, trailingConstraint, leadingConstraint])
        }
    }
    
    func setAccessibility() {
        titleLabel.accessibilityTraits = .none
        titleLabel.accessibilityLabel = titleLabel.text
    }
}
