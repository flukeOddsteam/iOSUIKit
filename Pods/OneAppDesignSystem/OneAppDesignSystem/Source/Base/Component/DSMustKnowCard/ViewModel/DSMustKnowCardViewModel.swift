//
//  DSMustKnowCardViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 30/1/2567 BE.
//

import UIKit

public protocol DSMustKnowCardViewModelInterface {
    var icon: DSMustKnowCardIconType { get }
    var title: String { get }
    var subTitle: String { get }
    var tagPill: String? { get }
    var isClosable: Bool { get }
    var isInteractionEnabled: Bool { get }
    var ghostTextPrimary: String? { get }
    var ghostTextSecondary: String? { get }
}

public struct DSMustKnowCardViewModel: DSMustKnowCardViewModelInterface {
    
    public var icon: DSMustKnowCardIconType
    public var title: String
    public var subTitle: String
    public var tagPill: String?
    public var isClosable: Bool
    public var ghostTextPrimary: String?
    public var ghostTextSecondary: String?
    public var isInteractionEnabled: Bool
    
    public init(icon: DSMustKnowCardIconType,
                title: String,
                subTitle: String,
                tagPill: String? = nil,
                isClosable: Bool = true,
                ghostTextPrimary: String? = nil,
                ghostTextSecondary: String? = nil,
                isInteractionEnabled: Bool = true) {
        self.icon = icon
        self.title = title
        self.subTitle = subTitle
        self.tagPill = tagPill
        self.isClosable = isClosable
        
        self.ghostTextPrimary = ghostTextPrimary
        self.ghostTextSecondary = ghostTextSecondary
        
        self.isInteractionEnabled = isInteractionEnabled
    }
}
