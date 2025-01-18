//
//  DSCheckboxListMessageExpandableViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/4/2566 BE.
//

import Foundation

public struct DSCheckboxListMessageExpandableViewModel {
    let labelTitle: String
    let valueTitle: String
    let description: DSCheckboxListMessageExpandableDescStyle?
    let isEnableExpandable: Bool
    let pillViewModel: DSCollectionPillViewModel?
    
    public init(labelTitle: String, valueTitle: String, description: DSCheckboxListMessageExpandableDescStyle?, isEnableExpandable: Bool, pillViewModel: DSCollectionPillViewModel?) {
        self.labelTitle = labelTitle
        self.valueTitle = valueTitle
        self.description = description
        self.isEnableExpandable = isEnableExpandable
        self.pillViewModel = pillViewModel
    }
}
