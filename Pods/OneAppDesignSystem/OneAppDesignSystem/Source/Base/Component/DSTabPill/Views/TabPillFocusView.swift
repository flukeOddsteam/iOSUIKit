//
//  TabPillFocusView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/10/2565 BE.
//

import UIKit

private enum Constants {
    static let heightContentView: CGFloat = 40
}

class TabPillFocusView: UIView {
    
    // MARK: - Views
    let contentView = UIView()
    
    var contentBackgroundColor: UIColor? {
        get {
            return contentView.backgroundColor
        } set {
            contentView.backgroundColor = newValue
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateRounded()
    }
}

// MARK: - Private
private extension TabPillFocusView {
    func updateRounded() {
        contentView.layer.cornerRadius = contentView.bounds.height / 2
    }
    
    func addConstraints() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .trailing,
            multiplier: 1,
            constant: .zero)
        let leadingConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: .zero)
        let centerConstraint = NSLayoutConstraint(
            item: self,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerY,
            multiplier: 1,
            constant: .zero)
        let hightConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: Constants.heightContentView)
        
        addConstraints([centerConstraint, trailingConstraint, leadingConstraint])
        contentView.addConstraint(hightConstraint)
    }
}
