//
//  BottomSheetMenuListDescriptionCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/3/2566 BE.
//

import UIKit

final class BottomSheetMenuListDescriptionCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var listMenuDescriptionContentView: BottomSheetMenuListContentView!

    func configure(viewModel: DSBottomSheetMenuListDescriptionViewModel, imageRatio: DSRatio) {
        listMenuDescriptionContentView.setup(viewModel: viewModel, imageRatio: imageRatio)
    }

    func highlight() { listMenuDescriptionContentView.highlight() }
    func unhighlight() { listMenuDescriptionContentView.unhighlight() }
}
