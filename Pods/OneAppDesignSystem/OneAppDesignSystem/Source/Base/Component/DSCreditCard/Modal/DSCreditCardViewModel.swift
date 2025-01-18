//
//  DSCreditCardViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/1/2567 BE.
//

import Foundation

public struct DSCreditCardViewModel {
    public var size: DSCreditCardSize
    public var imageType: DSCreditCardImageType
    public var isVirtual: Bool

    public init(
        size: DSCreditCardSize,
        imageType: DSCreditCardImageType,
        isVirtual: Bool
    ) {
        self.size = size
        self.imageType = imageType
        self.isVirtual = isVirtual
    }
}
