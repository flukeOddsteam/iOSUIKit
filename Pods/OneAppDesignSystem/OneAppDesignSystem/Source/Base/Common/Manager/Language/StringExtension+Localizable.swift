//
//  StringExtension+Localizable.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/3/2567 BE.
//

import Foundation

extension String {

    func localize(params: [String: String]? = nil) -> String {
        var result = self.localizable()
        if let params = params {
            for (key, value) in params {
                result = result.replace(target: "{{\(key)}}", withString: value)
            }
        }
        return result
    }

    func hasLocalize(params: [String: String]? = nil) -> Bool {
        let localize = self.localize(params: params)
        return localize != self
    }

    private func localizable() -> String {
        let currentLanguage = DSLanguageManager.shared.currentLanguage
        guard let path = Bundle.dsBundle.path(forResource: currentLanguage.jsonFileName, ofType: "json") else {
            return self
        }
        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else {
            return self
        }

        return dictionary[self] ?? self
    }

    private func replace(target: String, withString: String) -> String {
        return replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
