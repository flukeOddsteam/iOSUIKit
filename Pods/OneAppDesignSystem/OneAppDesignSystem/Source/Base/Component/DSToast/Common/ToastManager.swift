//
//  ToastManager.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/11/2565 BE.
//

import UIKit

final class ToastManager: NSObject {
    // MARK: - Singleton
    static let shared = ToastManager()
    
    // MARK: - Private
    private var queue: ToastQueueInterface
    private var configuration: ToastConfigurationInterface
    
    private var startTime: TimeInterval?
    private var stopTime: TimeInterval?
    
    private var window: UIWindow? {
        UIApplication.getWindow()
    }
    
    private override init() {
        self.queue = ToastQueue()
        self.configuration = ToastConfiguration()
    }
    
    func showToast(_ toast: ToastView) {
        let isNotHasQueue = !queue.hasQueue()
        
        addSwipeGesture(toast: toast)
        addLongPressGesture(toast: toast)
        
        queue.addQueue(toast)
        
        if isNotHasQueue {
            displayToast()
        }
    }
    
    func stopShowToast() {
        if queue.hasDisplayingToast() {
            dismiss()
            queue.removeAllQueue()
        }
    }
    
    @objc func dismiss() {
        guard var toast = queue.getDisplayingToast() else {
            return
        }
        
        clearTimeStamp()
        
        toast.isDisplaying = false
        
        let transitionPosition = ToastTransitionPosition(toast: toast)

        UIView.animate(withDuration: configuration.animationDuration, delay: .zero, options: [.curveEaseOut, .allowUserInteraction]) {
            toast.view.frame = transitionPosition.start
        } completion: { _ in
            self.queue.removeQueue(toast)
            toast.view.removeFromSuperview()
            
            if self.queue.hasQueueIsNotDisplay() {
                self.displayToast()
            } else {
                self.setWindowLevelToDefault()
            }
        }
    }
}

// MARK: - Events
extension ToastManager {
    @objc func toastDidSwipeUp(_ sender: UISwipeGestureRecognizer) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        dismiss()
    }
    
    @objc func toastDidLongPressed(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            stopTime = Date().timeIntervalSince1970
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        case .ended, .cancelled:
            
            var delay = self.configuration.visibleDuration
            if let startTime = self.startTime, let stopTime = self.stopTime {
                let diffTime = stopTime - startTime
                delay = self.configuration.visibleDuration - diffTime
            }
            
            self.perform(#selector(self.dismiss),
                         with: self,
                         afterDelay: delay)
        default:
            break
        }
    }
}

// MARK: - Private
private extension ToastManager {
    func makeToastConstraint(toast: UIView) {
        guard let window = UIApplication.getWindow() else { return }
        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.topAnchor.constraint(equalTo: window.topAnchor, constant: -toast.frame.height).isActive = true
        toast.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
        toast.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
        window.layoutIfNeeded()
    }
    
    func addSwipeGesture(toast: ToastView) {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(toastDidSwipeUp(_:)))
        swipeUpGesture.direction = .up
        toast.view.addGestureRecognizer(swipeUpGesture)
    }
    
    func addLongPressGesture(toast: ToastView) {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(toastDidLongPressed(_:)))
        longPressGesture.minimumPressDuration = 0.1
        toast.view.addGestureRecognizer(longPressGesture)
    }
    
    func addToastToWindow(toast: ToastView) {
        guard let window = UIApplication.getWindow() else { return }
        window.windowLevel = .statusBar + 1
        window.addSubview(toast.view)
        
        makeToastConstraint(toast: toast.view)
    }
    
    func setWindowLevelToDefault() {
        guard let window = UIApplication.getWindow() else { return }
        window.windowLevel = .normal
    }
    
    func clearTimeStamp() {
        self.startTime = nil
        self.stopTime = nil
    }
    
    func displayToast() {
        guard var toast = queue.getToastToDisplay() else {
            return
        }
        
        let transitionPosition = ToastTransitionPosition(toast: toast)
        toast.view.frame = transitionPosition.start
        
        toast.isDisplaying = true
        
        addToastToWindow(toast: toast)
        
        UIView.animate(withDuration: configuration.animationDuration, delay: .zero, options: [.curveEaseOut, .allowUserInteraction]) {
            toast.view.frame = transitionPosition.end
        } completion: { _ in
            self.startTime = Date().timeIntervalSince1970
            self.perform(#selector(self.dismiss),
                         with: self,
                         afterDelay: self.configuration.visibleDuration)
        }
    }
}
