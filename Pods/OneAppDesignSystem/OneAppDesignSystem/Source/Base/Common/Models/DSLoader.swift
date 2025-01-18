//
//  DSLoader.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/3/2567 BE.
//

import UIKit

private enum Constants {
    static let loadingRestorationId = "com.designsystem.loading.restorationid"
    static let defaultTransitionDuration: TimeInterval = 0.25
}

public struct DSLoader {
    public static func showLoading(_ backgroundAppearance: FullPageLoadingBackgroundAppearance = .none) {
        DispatchQueue.main.async {
            guard let windows = UIApplication.getWindow() else {
                return
            }

            let currentLoadingView = windows.subviews.filter { $0.restorationIdentifier == Constants.loadingRestorationId }.first
            guard currentLoadingView.isNull else {
                return
            }

            let containerView = UIView()
            containerView.backgroundColor = .clear
            containerView.restorationIdentifier = Constants.loadingRestorationId
            
            let loadingView = DSFullPageLoading(frame: .zero)
            loadingView.setup(targetView: containerView)
            loadingView.showLoading(backgroundAppearance: backgroundAppearance)

            windows.isUserInteractionEnabled = false

            UIView.transition(
                with: windows,
                duration: Constants.defaultTransitionDuration,
                options: [.transitionCrossDissolve],
                animations: {
                    windows.addSubview(containerView)
                    let leadingConstraint = NSLayoutConstraint(
                        item: windows,
                        attribute: .leading,
                        relatedBy: .equal,
                        toItem: containerView,
                        attribute: .leading,
                        multiplier: 1,
                        constant: .zero
                    )

                    let trailingConstraint = NSLayoutConstraint(
                        item: windows,
                        attribute: .trailing,
                        relatedBy: .equal,
                        toItem: containerView,
                        attribute: .trailing,
                        multiplier: 1,
                        constant: .zero
                    )

                    let topConstraint = NSLayoutConstraint(
                        item: windows,
                        attribute: .top,
                        relatedBy: .equal,
                        toItem: containerView,
                        attribute: .top,
                        multiplier: 1,
                        constant: .zero
                    )

                    let bottomConstraint = NSLayoutConstraint(
                        item: windows,
                        attribute: .bottom,
                        relatedBy: .equal,
                        toItem: containerView,
                        attribute: .bottom,
                        multiplier: 1,
                        constant: .zero
                    )

                    windows.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
                })
        }
    }

    public static func hideLoading() {
        DispatchQueue.main.async {

            guard let windows = UIApplication.getWindow() else {
                return
            }

            windows.isUserInteractionEnabled = true

            let loadingViews = windows.subviews.filter { $0.restorationIdentifier == Constants.loadingRestorationId }

            loadingViews.forEach { view in
                UIView.transition(
                    with: windows,
                    duration: Constants.defaultTransitionDuration,
                    options: [.transitionCrossDissolve],
                    animations: {
                        view.removeFromSuperview()
                    },
                    completion: nil
                )
            }
        }
    }
}
