//
//  TimerResumeable.swift
//  OneAppDesignSystem
//
//  Created by TTB on 12/9/2566 BE.
//

import Foundation

typealias TimerResumeableCompletion = () -> Void

final class TimerResumeable {

    private var timer: Timer?

    private var startTime: TimeInterval?
    private var stopTime: TimeInterval?

    private var defaultInterval: TimeInterval = .zero
    private var completion: TimerResumeableCompletion?
    private var isPause: Bool = false
    private var isRepeats: Bool = false

    init(interval: TimeInterval,
         isRepeats: Bool,
         completion: TimerResumeableCompletion?) {
        self.defaultInterval = interval
        self.isRepeats = isRepeats
        self.completion = completion
    }

    func start() {
        isPause = false
        startTime = Date().timeIntervalSince1970
        timer = Timer.scheduledTimer(timeInterval: defaultInterval, target: self, selector: #selector(timerDidFired), userInfo: nil, repeats: isRepeats)
    }

    func stop() {
        timer?.invalidate()
        startTime = nil
        stopTime = nil
    }

    func pause() {
        timer?.invalidate()
        isPause = true
        stopTime = Date().timeIntervalSince1970
    }
    
    func reset() {
        stop()
        start()
    }

    func resume() {
        guard let startTime, let stopTime else {
            return
        }
        let diffTime = stopTime - startTime
        let delay = defaultInterval - diffTime

        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(timerDidFired), userInfo: nil, repeats: false)
    }
}

// MARK: - Private
private extension TimerResumeable {
    @objc func timerDidFired() {
        completion?()

        if isPause {
            stop()
            start()
        } else {
            if isRepeats {
                startTime = Date().timeIntervalSince1970
            } else {
                stop()
            }
        }
    }
}
