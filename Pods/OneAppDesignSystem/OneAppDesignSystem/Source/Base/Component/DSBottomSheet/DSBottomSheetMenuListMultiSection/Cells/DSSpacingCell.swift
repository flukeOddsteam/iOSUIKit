//
//  DSSpacingCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 25/10/24.
//

import UIKit

final class DSSpacingCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var spacingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setupSpacing(height: CGFloat) {
        spacingConstraint.constant = height
    }
}

// MARK: - Private
private extension DSSpacingCell {
    func setUpUI() {
        self.isUserInteractionEnabled = false
    }
}
