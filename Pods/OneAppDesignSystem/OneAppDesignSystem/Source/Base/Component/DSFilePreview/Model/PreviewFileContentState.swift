//
//  PreviewFileContentState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/3/2567 BE.
//

import Foundation

enum PreviewFileContentState: Equatable {
    case loading
    case loaded
    case error
    case password(hasError: Bool)
}
