//
//  FilterPillCollectionViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 19/4/2566 BE.
//

import UIKit

protocol FilterPillCollectionViewCellDelegate: AnyObject {
    func filterPillCell(_ cell: FilterPillCollectionViewCell, didTapIconAtIndexOfItem index: Int)
}

final class FilterPillCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var filterView: FilterPillView!
    
    weak var delegate: FilterPillCollectionViewCellDelegate?
    
    // MARK: - Private variable
    private var indexItem: Int = .zero
    
    func configure(indexItem: Int, viewModel: DSFilterPillViewModel) {
        self.indexItem = indexItem
        self.filterView.setup(viewModel: viewModel)
        self.filterView.delegate = self
    }
    
    func setAccessibilityIdentifier(titleId: String?, iconButtonId: String?) {
        filterView.titleLabel.accessibilityIdentifier = titleId
        filterView.iconImageView.accessibilityIdentifier = iconButtonId
    }
}

// MARK: - FilterPillViewDelegate
extension FilterPillCollectionViewCell: FilterPillViewDelegate {
    func filterPillViewDidTapIconImage(_ view: FilterPillView) {
        delegate?.filterPillCell(self, didTapIconAtIndexOfItem: indexItem)
    }
}
