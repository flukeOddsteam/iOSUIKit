//
//  ImageCarouselViewLayout.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/8/2567 BE.
//

import UIKit

class ImageCarouselViewLayout: UICollectionViewFlowLayout {
    var previousOffset: CGFloat = 0.0
    var currentPage = 0
    let maxScale: CGFloat = 1.0
    let minScale: CGFloat = 0.8
    
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
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() as! UICollectionViewLayoutAttributes }),
              let collectionView = collectionView else {
            return nil
        }

        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let centerX = visibleRect.midX
        let currentPageIndex = Int(round(centerX / itemWidth))

        for attribute in attributes where attribute.representedElementCategory == .cell {
            guard let cell = collectionView.cellForItem(at: attribute.indexPath) as? CarouselSelectionImageCollectionViewCell else { continue }
            
            let distanceFromCenter = abs(attribute.center.x - centerX)
            let isNearCurrentPage = abs(attribute.indexPath.item - currentPageIndex) <= 1
            
            if isNearCurrentPage {
                let scale = calculateScale(distanceFromCenter: distanceFromCenter)
                cell.imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
                
                let alpha = (scale - minScale) / (maxScale - minScale)
                cell.titleLabel.alpha = alpha
                cell.descriptionLabel.alpha = alpha
                cell.pillView.alpha = alpha
            } else {
                cell.imageView.transform = CGAffineTransform(scaleX: minScale, y: minScale)
                cell.titleLabel.alpha = 0
                cell.descriptionLabel.alpha = 0
                cell.pillView.alpha = 0
            }
        }
        
        return attributes
    }
    
    func calculateScale(distanceFromCenter: CGFloat) -> CGFloat {
        let scale = maxScale - (distanceFromCenter / itemWidth) * (maxScale - minScale)
        return min(max(scale, minScale), maxScale)
    }
    
    func calculateCurrentPage() -> CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return (collectionView.contentOffset.x + centerOffset) / itemWidth
    }
    
    func getCurrentPage() -> Int {
        return currentPage
    }
}
