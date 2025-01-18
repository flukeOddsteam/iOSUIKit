//
//  DSMessageContentTagViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/9/2565 BE.
//

import UIKit

// MARK: Internal Class
class DSMessageContentPillViewCell: UICollectionViewCell {

    @IBOutlet weak var pillView: DSPill!
    
    func setAccessibilityIdentifier(id: String, labelId: String) {
        self.pillView.setAccessibilityIdentifier(id: id, labelId: labelId)
    }
}
