//
//  DSTextFieldWithPlusMinusButtonViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/4/2566 BE.
//

import Foundation
import UIKit

public protocol DSTextFieldWithPlusMinusButtonViewModelInterface {
    var title: String? { get }
    var value: Int { get }
    var helping: String? { get }
    var amountAddedEachTime: Int { get }
    var minLength: Int { get }
    var maxLength: Int { get }
}

public struct DSTextFieldWithPlusMinusButtonViewModel: DSTextFieldWithPlusMinusButtonViewModelInterface {
    public var title: String?
    public var value: Int = 0
    public var helping: String?
    public var amountAddedEachTime: Int = 0
    public var minLength: Int = 0
    public var maxLength: Int = 0
    
    public init(title: String?, value: Int = 0, helping: String?, amountAddedEachTime: Int = 1, minLength: Int = 1, maxLength: Int = 0) {
        self.title = title
        self.value = value
        self.helping = helping
        self.amountAddedEachTime = amountAddedEachTime
        self.minLength = minLength
        self.maxLength = maxLength
    }
}
