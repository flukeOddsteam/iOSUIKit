//
//  PreviewFileSceneState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/3/2567 BE.
//

import Foundation

struct PreviewFileSceneState {
    var temporaryOffset: CGPoint = .zero
    var lastScrollingOffset: CGPoint = .zero
    var configuration: DSPreviewFileConfiguration

    init(configuration: DSPreviewFileConfiguration) {
        self.configuration = configuration
    }

    mutating func set(temporaryOffset: CGPoint) {
        self.temporaryOffset = temporaryOffset
    }

    mutating func set(lastScrollingOffset: CGPoint) {
        self.lastScrollingOffset = lastScrollingOffset
    }

    mutating func resetTemporaryOffset() {
        self.temporaryOffset = .zero
    }
}
