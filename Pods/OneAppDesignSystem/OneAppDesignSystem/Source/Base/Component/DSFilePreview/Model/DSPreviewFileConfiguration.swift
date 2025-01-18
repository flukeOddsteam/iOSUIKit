//
//  DSPreviewFileConfiguration.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/3/2567 BE.
//

import Foundation

public struct DSPreviewFileConfiguration {
    public var presentationStyle: DSPreviewFilePresentationStyle
    public var stickyPresentationStyle: DSStickyPresentationStyle
    public var isDisplayEditFileName: Bool
    public var isDisplayDeleteFile: Bool

    public init(
        presentationStyle: DSPreviewFilePresentationStyle,
        stickyPresentationStyle: DSStickyPresentationStyle,
        isDisplayEditFileName: Bool,
        isDisplayDeleteFile: Bool
    ) {
        self.presentationStyle = presentationStyle
        self.stickyPresentationStyle = stickyPresentationStyle
        self.isDisplayEditFileName = isDisplayEditFileName
        self.isDisplayDeleteFile = isDisplayDeleteFile
    }

    public static let `default`: DSPreviewFileConfiguration = {
        return DSPreviewFileConfiguration(
            presentationStyle: .modal,
            stickyPresentationStyle: .saveAndShare,
            isDisplayEditFileName: true,
            isDisplayDeleteFile: true
        )
    }()
}

public extension DSPreviewFileConfiguration {
    enum DSStickyPresentationStyle {
        case saveAndShare
        case save
        case none
    }

    enum DSPreviewFilePresentationStyle {
        case push
        case modal
    }
}
