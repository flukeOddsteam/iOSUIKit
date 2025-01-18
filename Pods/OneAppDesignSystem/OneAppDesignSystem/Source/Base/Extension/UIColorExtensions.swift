//
//  UIColorExtensions.swift
//  OneAppWidget
//
//  Created by TTB on 16/2/2564 BE.
//

import UIKit

extension UIColor {
	convenience init(hex: String) {
		var hexCode: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		if hexCode.hasPrefix("#") {
			hexCode.remove(at: hexCode.startIndex)
		}
		
		var rgbValue: UInt64 = 0
		Scanner(string: hexCode).scanHexInt64(&rgbValue)
		
		self.init(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
}
