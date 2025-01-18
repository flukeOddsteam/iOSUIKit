//
//  ToastPosition.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/11/2565 BE.
//

import UIKit

protocol ToastTransitionPositionInterface {
    var start: CGRect { get }
    var end: CGRect { get }
}

struct ToastTransitionPosition: ToastTransitionPositionInterface {
        
    var start: CGRect = .zero
    var end: CGRect = .zero
    
    init(toast: ToastView) {
        let statusBarHeight = UIApplication.getStatusBarFrame().height
        self.start = CGRect(x: .zero,
                            y: -toast.view.frame.height,
                            width: toast.view.frame.width,
                            height: toast.view.frame.height)
        
        self.end = CGRect(x: .zero,
                          y: statusBarHeight,
                          width: toast.view.frame.width,
                          height: toast.view.frame.height)
    }
}
