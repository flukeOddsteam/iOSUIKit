//
//  DesignSystem.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2566 BE.
//

import Foundation

public final class DesignSystem {

    public static func setupLanguage(code: String) {
        DSLanguageManager.shared.setLanguage(code: code)
    }
}
