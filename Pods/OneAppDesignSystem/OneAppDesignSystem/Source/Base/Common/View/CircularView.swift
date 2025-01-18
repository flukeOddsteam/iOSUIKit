//
//  CircularView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/11/2565 BE.
//

import UIKit

public final class CircularView: UIView {
    public override func tintColorDidChange() {
		self.backgroundColor = tintColor
	}
	
    public override func layoutSubviews() {
		super.layoutSubviews()
		updateCornerRadius()
	}
	
    public override var frame: CGRect {
		didSet {
			updateCornerRadius()
		}
	}
	
	private func updateCornerRadius() {
		layer.cornerRadius = min(bounds.width, bounds.height) / 2
	}
}
