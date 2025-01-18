//
//  DSCardSelectionViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/11/2567 BE.
//

import Foundation

public struct DSCardSelectionViewModel {
    private var title: String = ""
    private var value: String?
    private var isEnabled: Bool = false
    private var isSelected: Bool = false
    private var tagId: Int = 0
    private var ratio: CGFloat = 1.0
    
    public init(title: String, value: String? = nil, tagId: Int? = nil, isEnabled: Bool, isSelected: Bool, ratio: CGFloat = 1.0) {
        self.title = title
        self.value = value
        self.tagId = tagId ?? 0
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.ratio = ratio
    }
    
    // MARk: - get value
    public func getTitle() -> String {
        return title
    }
    
    public func getValue() -> String? {
        return value
    }
    
    public func getTagId() -> Int {
        return tagId
    }
    
    public func getIsValueHidden() -> Bool {
        if let value = getValue(),
           value.isEmpty {
            return true
        }
        return false
    }
    
    public func getIsEnabled() -> Bool {
        return isEnabled
    }
    
    public func getIsSelected() -> Bool {
        return isSelected
    }
    
    public func getRatio() -> CGFloat {
        return ratio
    }
}
