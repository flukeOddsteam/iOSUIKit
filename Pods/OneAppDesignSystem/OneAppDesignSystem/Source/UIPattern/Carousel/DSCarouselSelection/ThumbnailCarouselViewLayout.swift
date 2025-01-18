//
//  ThumbnailCarouselViewLayout.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/8/2567 BE.
//

import UIKit

class ThumbnailCarouselViewLayout: UICollectionViewFlowLayout {
    var previousOffset: CGFloat = 0.0
    var currentPage = 0
    
    var itemWidth: CGFloat {
        return itemSize.width + minimumLineSpacing
    }
    
    var centerOffset: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return (collectionView.bounds.width - itemSize.width) / 2
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        if velocity.x > 0 {
            currentPage = min(currentPage + 1, collectionView.numberOfItems(inSection: 0) - 1)
        } else if velocity.x < 0 {
            currentPage = max(currentPage - 1, 0)
        }
        
        let offset = (CGFloat(currentPage) * itemWidth) - centerOffset
        previousOffset = offset
        return CGPoint(x: offset, y: proposedContentOffset.y)
    }
    
    func updateOffset(_ collectionView: UICollectionView) -> CGFloat {
        return (itemWidth * CGFloat(currentPage)) - (((collectionView.frame.width - itemSize.width - (minimumLineSpacing * 2)) / 2) + minimumLineSpacing)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func calculateCurrentPage() -> CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return (collectionView.contentOffset.x + centerOffset) / itemWidth
    }
    
    func getCurrentPage() -> Int {
        return currentPage
    }
}
