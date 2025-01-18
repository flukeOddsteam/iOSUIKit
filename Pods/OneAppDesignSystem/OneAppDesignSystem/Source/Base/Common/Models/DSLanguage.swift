//
//  DSLanguage.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/3/2567 BE.
//

import Foundation

public enum DSLanguage: String {
    case thai = "th"
    case english = "en"

    public var jsonFileName: String {
        return DSLanguage.value(
            self,
            th: "phrase_th",
            en: "phrase_en"
        )
    }

    public static func value<T>(_ language: DSLanguage, th: T, en: T) -> T {
        switch language {
        case .thai:
            return th
        case .english:
            return en
        }
    }

    public func value<T>(thai: T, english: T) -> T {
        switch self {
        case .thai:
            return thai
        case .english:
            return english
        }
    }
}
