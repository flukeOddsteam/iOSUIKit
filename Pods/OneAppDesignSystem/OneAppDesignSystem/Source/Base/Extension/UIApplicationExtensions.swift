//
//  UIApplicationExtensions.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/11/2565 BE.
//

import UIKit

public extension UIApplication {
    static func getWindow() -> UIWindow? {
        if #available(iOS 14.0, *) {
            return UIApplication.shared.connectedScenes
                .first { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }
                .map { $0 as? UIWindowScene }
                .flatMap { $0?.windows.first } ?? UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow
        }
        
        guard let window = UIApplication.shared.delegate?.window else {
            return nil
        }
        
        return window
    }
    
    static func getStatusBarFrame() -> CGRect {
        if #available(iOS 13.0, *) {
            let window = getWindow()
            return window?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        }
        
        return UIApplication.shared.statusBarFrame
    }

    static func getRootViewController() -> UIViewController? {
        guard let window = getWindow() else {
            return nil
        }

        return window.rootViewController
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
