//
//  CarouselSelectionThumbnailCollectionViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/8/2567 BE.
//

import UIKit

class CarouselSelectionThumbnailCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.setRadius(radius: .radius8px)
        thumbnailImageView.setBorder(width: 1, color: DSColor.componentLightOutlineSecondary)
        thumbnailImageView.tintAdjustmentMode = .normal

    }
    
    func setup(isEnabled: Bool = true) {
        self.thumbnailImageView.alpha = isEnabled.isFalse ? 0.3 : 1.0
    }
}
