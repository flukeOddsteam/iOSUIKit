//
//  DSCommonPaymentValueRadioViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/11/2567 BE.
//

import UIKit

public struct DSCommonPaymentValueRadioViewModel {
    // mandatory
    public var label: String
    // optional
    public var value: String?
    public var description: String?
    public var valueStrikethrough: String?
    public var balanceLabel: String?
    public var balanceValue: String?
    // state
    public var balanceState: DSCommonPaymentValueRadioBalanceState?
    public var valueState: DSCommonPaymentValueRadioValueState?
    // toggle
    public var isSelected: Bool
    public var isEnabled: Bool
    // style
    public var valueStyle: DSCommonPaymentValueRadioStyle?
    // custom View
    public weak var contentView: UIView?
    // tag
    public var tagId: Int = 0
    
    public init(
        label: String,
        value: String? = nil,
        valueStyle: DSCommonPaymentValueRadioStyle? = nil,
        description: String? = nil,
        valueStrikethrough: String? = nil,
        isSelected: Bool? = false,
        isEnabled: Bool? = false,
        contentView: UIView?,
        tagId: Int? = 0,
        balanceLabel: String? = nil,
        balanceValue: String? = nil,
        balanceState: DSCommonPaymentValueRadioBalanceState? = nil,
        valueState: DSCommonPaymentValueRadioValueState? = nil
    ) {
        self.label = label
        self.value = value
        self.description = description
        self.valueStrikethrough = valueStrikethrough
        self.isSelected = isSelected ?? false
        self.isEnabled = isEnabled ?? false
        self.valueStyle = valueStyle
        self.contentView = contentView
        self.tagId = tagId ?? 0
        self.balanceLabel = balanceLabel
        self.balanceValue = balanceValue
        self.balanceState = balanceState
        self.valueState = valueState
    }
    
    public func getLabel() -> String {
        return label
    }
    
    public func getValue() -> String? {
        return value
    }
    
    public func getValueStyle() -> DSCommonPaymentValueRadioStyle? {
        return valueStyle
    }
    
    public func getDescription() -> String? {
        return description
    }
    
    public func getValueStrikethrough() -> String? {
        return valueStrikethrough
    }
    
    public func getContentView() -> UIView? {
        return contentView
    }
    
    public func getIsValueHidden() -> Bool {
        return value?.isEmpty ?? true
    }
    
    public func getIsDescriptionHidden() -> Bool {
        return description?.isEmpty ?? true
    }
    
    public func getIsValueStrikethroughHidden() -> Bool {
        return valueStrikethrough?.isEmpty ?? true
    }
    
    public func getIsSelected() -> Bool {
        return isSelected
    }
    
    public func getIsEnabled() -> Bool {
        return isEnabled
    }
    
    public func getBalanceLabel() -> String? {
        return balanceLabel
    }
    
    public func getBalanceValue() -> String? {
        return balanceValue
    }
    
    public func getBalanceState() -> DSCommonPaymentValueRadioBalanceState? {
        return balanceState
    }
    
    public func getValueState() -> DSCommonPaymentValueRadioValueState? {
        return valueState
    }
    
    public mutating func setValueStrikethrough(text: String) {
        valueStrikethrough = text
    }
}
