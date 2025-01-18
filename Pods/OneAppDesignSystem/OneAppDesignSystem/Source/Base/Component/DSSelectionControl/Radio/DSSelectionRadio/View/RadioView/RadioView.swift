//
//  RadioView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/9/2565 BE.
//

import UIKit

class RadioView: UIView {
	var state: DSSelectionRadioState = .default {
		didSet {
			updateAppearance()
		}
	}
	
	// MARK: - Life Cycle
	override func awakeFromNib() {
		super.awakeFromNib()
		setupUI()
		updateAppearance()
	}
}

// MARK: - Private
private extension RadioView {
	func setupUI() {
		self.setCircle()
	}
	
	func updateAppearance() {
		self.layer.borderColor = state.iconBorderColor.cgColor
		self.layer.borderWidth = state.iconBorderWidth
		self.backgroundColor = state.iconBackgroundColor
	}
}
