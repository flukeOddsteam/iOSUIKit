//
//  DSLanguageManager.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/3/2567 BE.
//

import Foundation

public class DSLanguageManager {
    // MARK: - Singleton
    public static let shared = DSLanguageManager()

    public var currentLanguage: DSLanguage = .english

    private init() { }

    func setLanguage(code: String) {
        let language = DSLanguage(rawValue: code.lowercased()) ?? .english
        setLanguage(language: language)
    }

    func setLanguage(language: DSLanguage) {
        self.currentLanguage = language
        NotificationCenter.default.post(.dsLanguageDidChanged)
    }

    func value(thai: String, english: String) -> String {
        switch currentLanguage {
        case .thai:
            return thai
        case .english:
            return english
        }
    }
}

extension Notification {
    static let dsLanguageDidChanged = Notification(name: Notification.Name(rawValue: "com.designsystem.dsLanguageDidChanged"))
}
