//
//  DSRadioCardExpandViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/12/2566 BE.
//

import Foundation

public struct DSRadioCardExpandViewModel {
    public var expandType: ExpandType?
    public var button: DSButtonViewModel?

    public init(expandType: ExpandType? = nil, button: DSButtonViewModel? = nil) {
        self.expandType = expandType
        self.button = button
    }
}
