//
//  DSWaitingScreenDelegate.swift
//  OneAppDesignSystem
//
//  Created by TTB on 18/4/2567 BE.
//

import Foundation

public protocol DSWaitingScreenDelegate: AnyObject {
    func waitingScreenDidClosed()
    func waitingScreenBottomSheetPrimaryButtonDidTapped()
    func waitingScreenBottomSheetGhostButtonDidTapped()
}

public extension DSWaitingScreenDelegate {
    func waitingScreenDidClosed() { }
    func waitingScreenBottomSheetPrimaryButtonDidTapped() { }
    func waitingScreenBottomSheetGhostButtonDidTapped() { }
}
