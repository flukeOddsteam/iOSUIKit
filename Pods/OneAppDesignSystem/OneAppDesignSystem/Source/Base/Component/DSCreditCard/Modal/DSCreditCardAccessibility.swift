//
//  DSCreditCardAccessibility.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/1/2567 BE.
//

import Foundation

public struct DSCreditCardAccessibility {
    public var creditCardImageId: String?
    public var virtualImageId: String?

    public init(creditCardImageId: String? = nil,
                virtualImageId: String? = nil) {
        self.creditCardImageId = creditCardImageId
        self.virtualImageId = virtualImageId
    }
}
