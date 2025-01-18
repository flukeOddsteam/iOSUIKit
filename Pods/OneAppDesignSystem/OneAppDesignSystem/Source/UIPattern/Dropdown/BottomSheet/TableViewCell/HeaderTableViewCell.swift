//
//  HeaderTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/5/24.
//

import UIKit

class HeaderTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var titleLabel: UILabel!

    func configure(title: String) {
        titleLabel.text = title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.setUp(font: DSFont.h3, textColor: DSColor.componentLightDefault)
        selectionStyle = .none
    }
}
