//
//  POCWaitingScreenDelegate.swift
//  OneAppDesignSystem
//
//  Created by TTB on 18/4/2567 BE.
//

import Foundation

public protocol POCWaitingScreenDelegate: AnyObject {
    func pocWaitingScreenDidClosed()
    func pocWaitingScreenBottomSheetPrimaryButtonDidTapped()
    func pocWaitingScreenBottomSheetGhostButtonDidTapped()
}

public extension POCWaitingScreenDelegate {
    func pocWaitingScreenDidClosed() { }
    func pocWaitingScreenBottomSheetPrimaryButtonDidTapped() { }
    func pocWaitingScreenBottomSheetGhostButtonDidTapped() { }
}
