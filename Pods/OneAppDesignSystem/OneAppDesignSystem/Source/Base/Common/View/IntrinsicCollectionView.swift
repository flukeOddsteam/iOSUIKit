//
//  IntrinsicCollectionView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/9/2565 BE.
//

import UIKit

public final class IntrinsicCollectionView: UICollectionView {
    public override var contentSize: CGSize {
        didSet {
            if oldValue.height != self.contentSize.height {
                invalidateIntrinsicContentSize()
            }
        }
    }

    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric,
                      height: contentSize.height)
    }
}
