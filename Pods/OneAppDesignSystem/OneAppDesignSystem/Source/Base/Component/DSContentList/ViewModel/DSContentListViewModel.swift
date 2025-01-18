//
//  DSContentListViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import UIKit

public protocol DSContentListViewModelInterface {
    var image: DSContentListImageType { get }
    var imageContentMode: UIView.ContentMode { get }
    var leftHeaderTitle: String? { get }
    var rightHeaderTitle: String? { get }
    var title: String { get }
    var statusPill: DSContentListStatusPillViewModel? { get }
    var titleTagPill: String? { get }
    var description: String { get }
    var ghostAction: DSContentListGhostActionModel? { get }
}

public struct DSContentListViewModel: DSContentListViewModelInterface {
    public var imageContentMode: UIView.ContentMode
    public var image: DSContentListImageType
    public var leftHeaderTitle: String?
    public var rightHeaderTitle: String?
    public var title: String
    public var statusPill: DSContentListStatusPillViewModel?
    public var titleTagPill: String?
    public var description: String
    public var ghostAction: DSContentListGhostActionModel?
    
    public init(image: DSContentListImageType,
                imageContentMode: UIView.ContentMode = .scaleAspectFit,
                leftHeaderTitle: String?,
                rightHeaderTitle: String?,
                title: String,
                statusPill: DSContentListStatusPillViewModel?,
                titleTagPill: String?,
                description: String,
                ghostAction: DSContentListGhostActionModel?
    ) {
        self.image = image
        self.imageContentMode = imageContentMode
        self.leftHeaderTitle = leftHeaderTitle
        self.rightHeaderTitle = rightHeaderTitle
        self.title = title
        self.statusPill = statusPill
        self.titleTagPill = titleTagPill
        self.description = description
        self.ghostAction = ghostAction
    }
}
