//
//  DSSkeletonLoadingInterface.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/1/2566 BE.
//

import UIKit

public protocol DSSkeletonLoadingInterface {
    var skeletonViews: [DSSkeletonViewAnimationInterface] { get set }
    
    func startSkeleton()
    func stopSkeleton()
}

public extension DSSkeletonLoadingInterface {
    func startSkeleton() {
        DispatchQueue.main.async {
            skeletonViews.forEach {
                $0.startAnimation()
            }
        }
    }
    
    func stopSkeleton() {
        DispatchQueue.main.async {
            skeletonViews.forEach {
                $0.stopAnimation()
            }
        }
    }
}
