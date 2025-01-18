//
//  DSCardDocumentViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/3/2566 BE.
//

import Foundation
import UIKit

public protocol DSCardDocumentViewModelInterface {
    var image: DSCardDocumentImageType? { get }
    var category: String? { get }
    var title: String? { get }
    var subTitle: String? { get }
}

public struct DSCardDocumentViewModel: DSCardDocumentViewModelInterface {
    public var image: DSCardDocumentImageType?
    public var category: String?
    public var title: String?
    public var subTitle: String?
    
    public init(image: DSCardDocumentImageType?, category: String?, title: String?, subTitle: String?) {
        self.image = image
        self.category = category
        self.title = title
        self.subTitle = subTitle
    }
}
