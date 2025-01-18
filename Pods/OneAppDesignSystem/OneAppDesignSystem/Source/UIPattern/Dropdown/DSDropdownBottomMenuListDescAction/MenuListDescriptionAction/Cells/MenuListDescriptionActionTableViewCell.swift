//
//  MenuListDescriptionActionTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/6/2566 BE.
//

import UIKit

class MenuListDescriptionActionTableViewCell: UITableViewCell, NibLoadable {
    
    @IBOutlet weak var cardSelectionView: DropdownCardSelection!
    
    func setup(with viewModel: DropdownCardSelectionViewModel, state: DropdownCardSelectionState) {
        cardSelectionView.setup(viewModel: viewModel, state: state)
    }
    
    func setPressed() {
        cardSelectionView.setPressed()
    }
    func setDefault() {
        cardSelectionView.setDefault()
    }
}
