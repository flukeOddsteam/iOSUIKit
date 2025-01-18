//
//  DSFullPageUploadPhrase.swift
//  OneAppDesignSystem
//
//  Created by TTB on 19/7/2567 BE.
//

import Foundation
// swiftlint:disable all
enum DSFullPageUploadPhrase {
    case loadingLabel
    case successLabel
    case cancelButton
    
    func localize(params: [String]? = nil) -> String {
        switch self {
        case .loadingLabel:
            return DSFullPageUploadPhrase.value(th: "กำลังอัปโหลด", en: "Loading")
        case .successLabel:
            return DSFullPageUploadPhrase.value(th: "อัปโหลดสำเร็จ", en: "Upload Successful")
        case .cancelButton:
            return DSFullPageUploadPhrase.value(th: "ยกเลิก", en: "Cancel")
        }
    }
    
    static func value<T>(th: T, en: T) -> T {
        switch DSLanguageManager.shared.currentLanguage {
        case .thai:
            return th
        case .english:
            return en
        }
    }
}
// swiftlint:enable all
