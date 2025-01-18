//
//  ContentListHorizontalCollectionViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import UIKit

class ContentListHorizontalCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    // MARK: - IBOutlet
    @IBOutlet weak var contentBasicView: ContentListHorizontalBasicView!
    
    weak var delegate: ContentListCollectionViewDelegate?

    func configure(viewModel: DSContentListViewModel) {
        contentBasicView.setup(viewModel: viewModel)
        contentBasicView.delegate = self
    }
    
    func setAccessibilityIdentifier(id: String,
                                    leftHeaderTitleLabelId: String,
                                    rightHeaderTitleLabelId: String,
                                    titleLabelId: String,
                                    statusPillViewId: String,
                                    statusPillViewLabelId: String,
                                    tagPillViewId: String,
                                    descriptionLabelId: String,
                                    actionButtonId: String,
                                    actionButtonLabelId: String) {
        self.contentBasicView.setAccessibilityIdentifier(id: id,
                                                         leftHeaderTitleLabelId: leftHeaderTitleLabelId,
                                                         rightHeaderTitleLabelId: rightHeaderTitleLabelId,
                                                         titleLabelId: titleLabelId,
                                                         statusPillViewId: statusPillViewId,
                                                         statusPillViewLabelId: statusPillViewLabelId,
                                                         tagPillViewId: tagPillViewId,
                                                         descriptionLabelId: descriptionLabelId,
                                                         actionButtonId: actionButtonId,
                                                         actionButtonLabelId: actionButtonLabelId)
    }
}

// MARK: - ContentListBasicViewDelegate
extension ContentListHorizontalCollectionViewCell: ContentListBasicViewDelegate {
    func contentListBasicViewGhostActionDidTapped(_ view: UIView) {
        delegate?.contentListCollectionCellGhostDidTapped(self)
    }
}
