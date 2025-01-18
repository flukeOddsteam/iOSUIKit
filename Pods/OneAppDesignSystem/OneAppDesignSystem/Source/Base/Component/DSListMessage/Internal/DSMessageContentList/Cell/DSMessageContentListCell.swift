//
//  DSMessageContentListCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/9/2565 BE.
//

import UIKit

// MARK: Internal Class
class DSMessageContentListCell: UITableViewCell, NibLoadable {
    
    @IBOutlet weak var listMessageView: DSListMessage!
    
    func setup(messageModel: DSMessageListModel) {
        let viewModel = DSListMessageViewModel(style: .horizontal,
                                               label: messageModel.label ?? "",
                                               value: messageModel.value ?? "")
        listMessageView.setup(type: .small(viewModel: viewModel))
    }
    
    func setup(messageModel: DSSelectionListModel) {
        let viewModel = DSListMessageViewModel(style: .horizontal,
                                               label: messageModel.label ?? "",
                                               value: messageModel.value ?? "")
        listMessageView.setup(type: .small(viewModel: viewModel))
    }
}
