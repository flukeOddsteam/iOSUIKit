//
//  BundleExtensions.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/9/2565 BE.
//

import Foundation

public extension Bundle {
	
	static var dsBundle: Bundle {
        return Bundle(for: DesignSystem.self)
	}
}
