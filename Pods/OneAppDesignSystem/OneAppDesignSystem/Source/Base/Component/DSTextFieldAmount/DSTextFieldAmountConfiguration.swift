//
//  DSTextFieldAmountConfiguration.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 2/2/2567 BE.
//

import Foundation

public struct DSTextFieldAmountConfiguration {
    public let autoDisplayEmptyError: Bool

    public init(autoDisplayEmptyError: Bool) {
        self.autoDisplayEmptyError = autoDisplayEmptyError
    }
}
extension DSTextFieldAmountConfiguration {
    public static var `default` = DSTextFieldAmountConfiguration(
        autoDisplayEmptyError: true
    )
}
