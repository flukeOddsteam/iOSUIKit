//
//  DSErrorFullPageViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/5/2567 BE.
//

import UIKit

public struct DSErrorFullPageViewModel {
    public var title: String
    public var description: String
    public var primaryButtonTitle: String?
    public var ghostButtonTitle: String?
    public var mediaDisplayType: MediaDisplayType
    public var imageType: ImageType

    public init(
        title: String,
        description: String,
        primaryButtonTitle: String? = nil,
        ghostButtonTitle: String? = nil,
        mediaDisplayType: MediaDisplayType,
        imageType: ImageType
    ) {
        self.title = title
        self.description = description
        self.primaryButtonTitle = primaryButtonTitle
        self.ghostButtonTitle = ghostButtonTitle
        self.mediaDisplayType = mediaDisplayType
        self.imageType = imageType
    }
}

extension DSErrorFullPageViewModel {
    public enum MediaDisplayType {
        case icon
        case image

        var imageSize: CGSize {
            switch self {
            case .icon:
                return CGSize(width: 48, height: 48)
            case .image:
                return CGSize(width: 240, height: 240)
            }
        }

        var topPadding: CGFloat {
            switch self {
            case .icon:
                return 48
            case .image:
                return 24
            }
        }
    }

    public enum ImageType {
        case image(UIImage)
        case url(URL?, placeholder: UIImage?, cacheable: Bool)
    }
}
