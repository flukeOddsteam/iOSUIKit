//
//  DSProductListViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/3/2566 BE.
//

import UIKit

public protocol DSProductListViewModelInterface {
    var image: DSProductListImageType? { get }
    var imageRadio: DSRatio { get }
    var title: String? { get }
    var description: String? { get }
}

public struct DSProductListViewModel: DSProductListViewModelInterface {
    public var image: DSProductListImageType?
    public var imageRadio: DSRatio = .ratio1x1
    public var title: String?
    public var description: String?
    
    public init(image: DSProductListImageType?,
                imageRadio: DSRatio = .ratio1x1,
                title: String?,
                description: String?) {
        self.image = image
        self.imageRadio = imageRadio
        self.title = title
        self.description = description
    }
}
