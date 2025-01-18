//
//  DSFullPageUploadState.swift
//  OneAppDesignSystem
//
//  Created by TTB on 17/7/2567 BE.
//

import UIKit
import Lottie

public enum DSFullPageUploadState: Equatable {
    case loading
    case success
}

enum MarginUploadView: CGFloat {
    case `default` = 0
    case top = 32
    case bottom = 16
}

protocol DSFullPageUploadAppearanceState {
    var isGhostButtonHidden: Bool { get }
    var lottieFileName: String { get }
    var loopMode: LottieLoopMode { get }
    var animationSpeed: CGFloat { get }
    var titleText: String { get }
    var topMargin: CGFloat { get }
    var bottomMargin: CGFloat { get }
}

extension DSFullPageUploadState: DSFullPageUploadAppearanceState {
    var animationSpeed: CGFloat {
        switch self {
        case .loading:
            return 1.0
        case .success:
            return 2.0
        }
    }
    
    var titleText: String {
        switch self {
        case .loading:
            return DSFullPageUploadPhrase.loadingLabel.localize()
        case .success:
            return DSFullPageUploadPhrase.successLabel.localize()
        }
    }
    
    var loopMode: Lottie.LottieLoopMode {
        switch self {
        case .loading:
            return .loop
        case .success:
            return .playOnce
        }
    }
    
    var lottieFileName: String {
        switch self {
        case .loading:
            return "lottie-spinner-loading"
        case .success:
            return "lottie-success"
        }
    }
    
    var isGhostButtonHidden: Bool {
        switch self {
        case .loading:
            return false
        case .success:
            return true
        }
    }
    
    var topMargin: CGFloat {
        switch self {
        case .loading:
            return MarginUploadView.top.rawValue
        case .success:
            return MarginUploadView.default.rawValue
        }
    }
    
    var bottomMargin: CGFloat {
        switch self {
        case .loading:
            return MarginUploadView.bottom.rawValue
        case .success:
            return MarginUploadView.default.rawValue
        }
    }
}
