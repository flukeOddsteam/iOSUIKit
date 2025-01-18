//
//  ToastQueue.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/11/2565 BE.
//

import Foundation

protocol ToastQueueInterface {
    func addQueue(_ toast: ToastView)
    func removeQueue(_ toast: ToastView)
    func getToastToDisplay() -> ToastView?
    func getDisplayingToast() -> ToastView?
    func removeAllQueue()
    
    func hasQueue() -> Bool
    func hasDisplayingToast() -> Bool
    func hasQueueIsNotDisplay() -> Bool
}

final class ToastQueue {
    
    // MARK: - Private
    private var toasts: [ToastView] = []
}

extension ToastQueue: ToastQueueInterface {
    func addQueue(_ toast: ToastView) {
        toasts.append(toast)
    }
    
    func removeQueue(_ toast: ToastView) {
        if let index = toasts.firstIndex(where: { $0.view == toast.view }) {
            toasts.remove(at: index)
        }
    }
    
    func getToastToDisplay() -> ToastView? {
        toasts.filter { !$0.isDisplaying }.first
    }
    
    func getDisplayingToast() -> ToastView? {
        toasts.filter { $0.isDisplaying }.first
    }
    
    func hasQueue() -> Bool {
        toasts.isNotEmpty
    }
    
    func removeAllQueue() {
        toasts.removeAll()
    }
    
    func hasDisplayingToast() -> Bool {
        getDisplayingToast() != nil
    }
    
    func hasQueueIsNotDisplay() -> Bool {
        toasts.filter { !$0.isDisplaying }.isNotEmpty
    }
}
