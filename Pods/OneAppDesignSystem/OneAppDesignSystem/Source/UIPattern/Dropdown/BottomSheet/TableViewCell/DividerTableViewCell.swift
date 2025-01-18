//
//  DividerTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/5/24.
//

import UIKit

class DividerTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var dividerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        dividerView.backgroundColor = DSColor.componentDividerBackgroundBig
        selectionStyle = .none
    }
}
