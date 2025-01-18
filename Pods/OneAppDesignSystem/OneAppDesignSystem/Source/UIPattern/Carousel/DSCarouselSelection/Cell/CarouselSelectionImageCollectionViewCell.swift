//
//  CarouselSelectionImageCollectionViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/8/2567 BE.
//

import UIKit

class CarouselSelectionImageCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pillView: DSPill!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setRadius(radius: .radius8px)
        imageView.tintAdjustmentMode = .normal

        titleLabel.setUp(font: DSFont.paragraphSmall, textColor: DSColor.componentLightDefault, numberOfLines: 2)
        descriptionLabel.setUp(font: DSFont.paragraphXSmall, textColor: DSColor.componentLightDesc, numberOfLines: 2)
    }
    
    func setup(
        isEnabled: Bool = true,
        title: String,
        description: String?,
        disableTag: String?
    ) {
        imageView.alpha = isEnabled.isFalse ? 0.3 : 1.0
        
        titleLabel.text = title
        
        descriptionLabel.isHidden = isEnabled.isFalse
        descriptionLabel.text = title.isEmpty ? "" : description
        
        pillView.isHidden = isEnabled.isTrue
        pillView.setup(style: .status(.default), title: disableTag.unwrapped)
    }
}
