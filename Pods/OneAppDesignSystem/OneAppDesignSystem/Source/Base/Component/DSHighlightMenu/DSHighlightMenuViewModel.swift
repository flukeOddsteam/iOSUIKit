//
//  DSHighlightMenuViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/9/2567 BE.
//

import UIKit

public struct DSHighlightMenuViewModel {
    
    public var title: String
    public var description: String?
    public var image: ImageType
    
    init(
        title: String,
        description: String? = "",
        image: ImageType
    ) {
        self.title = title
        self.description = description
        self.image = image
    }
}

extension DSHighlightMenuViewModel {
    public enum ImageType {
        case image(DSHighlightMenuImageType)
        case icon(DSIcons)
    }
}

public enum DSHighlightMenuImageType {
    case image(UIImage)
    case url(
        URL?,
        placeholder: UIImage? = nil,
        cacheable: Bool = true
    )
}
