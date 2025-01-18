//
//  DSWaitingScreenViewModel.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 13/2/2567 BE.
//

import UIKit

public struct DSWaitingScreenViewModel {
    public var screenPhrase: ScreenPhrase
    public var bottomSheetPhrase: BottomSheetPhrase
    public var mediaType: ScreenMediaType

    public init(
        screenPhrase: ScreenPhrase,
        bottomSheetPhrase: BottomSheetPhrase,
        mediaType: ScreenMediaType
    ) {
        self.bottomSheetPhrase = bottomSheetPhrase
        self.mediaType = mediaType
        self.screenPhrase = screenPhrase
    }
}

extension DSWaitingScreenViewModel {

    public struct ScreenPhrase {
        public var title: String
        public var subtitle: String
        public var ghostButtonTitle: String

        public init(
            title: String,
            subtitle: String,
            ghostButtonTitle: String
        ) {
            self.title = title
            self.subtitle = subtitle
            self.ghostButtonTitle = ghostButtonTitle
        }
    }

    public struct BottomSheetPhrase {
        public let title: String
        public let description: String
        public let primaryButtonTitle: String
        public let ghostButtonTitle: String

        public init(
            title: String,
            description: String,
            primaryButtonTitle: String,
            ghostButtonTitle: String
        ) {
            self.title = title
            self.description = description
            self.primaryButtonTitle = primaryButtonTitle
            self.ghostButtonTitle = ghostButtonTitle
        }
    }

    public enum ScreenMediaType {
        case lottie(filename: String, bundle: Bundle)
        case image(UIImage)
        case url(URL?, placeholder: UIImage?, cacheable: Bool)
    }
}
