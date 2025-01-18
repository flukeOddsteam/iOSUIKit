//
//  DSBadgeDot.swift
//  OneAppDesignSystem
//
//  Created by TTB  on 5/2/2567 BE.
//

import UIKit

/**
 Custom component Badge Dot

 This Badge Dot size: 8x8
 ![image](/DocumentationImages/ds-badge-dot.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSBadgeDot` class to the UIView
 2. Binding constraint and don't set `height` (use height placeholder or set height remove at build time in storyboard, or etc.)
 */
public class DSBadgeDot: UIView {
    
    private lazy var dot: UIView = {
        let view = UIView()
        view.backgroundColor = DSColor.componentBadgeBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - Private
private extension DSBadgeDot {
    func commonInit() {
        self.addSubview(dot)
        NSLayoutConstraint.activate([
            self.dot.topAnchor.constraint(equalTo: topAnchor),
            self.dot.bottomAnchor.constraint(equalTo: bottomAnchor),
            self.dot.leftAnchor.constraint(equalTo: leftAnchor),
            self.dot.rightAnchor.constraint(equalTo: rightAnchor),
            self.dot.widthAnchor.constraint(equalToConstant: 8),
            self.dot.heightAnchor.constraint(equalToConstant: 8)
        ])

        layoutIfNeeded()
        dot.setCircle()
    }
}
