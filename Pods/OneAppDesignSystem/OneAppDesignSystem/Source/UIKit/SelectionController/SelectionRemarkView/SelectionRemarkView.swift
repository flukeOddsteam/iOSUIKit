//
//  SelectionRemarkView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/8/2567
//

import UIKit

final class SelectionRemarkView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    private var viewModel: SelectionRemarkViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(with viewModel: SelectionRemarkViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        setupBulletItems()
    }
}

// MARK: - Private Methods
private extension SelectionRemarkView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.setUp(
            font: DSFont.h4,
            textColor: DSColor.componentLightLabelSoft
        )
    }
    
    func setupBulletItems() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let viewModel = viewModel else { return }
        
        viewModel.bulletItems.forEach { item in
            let itemViewModel = RemarkItemViewModel(
                title: item,
                isShowBullet: viewModel.isShowBullet
            )
            let itemView = RemarkItemView()
            itemView.setup(viewModel: itemViewModel)
            stackView.addArrangedSubview(itemView)
        }
    }
}
