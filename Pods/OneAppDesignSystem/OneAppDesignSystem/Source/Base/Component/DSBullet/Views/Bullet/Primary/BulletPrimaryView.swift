//
//  DSBulletPrimaryView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/1/2566 BE.
//

import UIKit

final class BulletPrimaryView: UIView {
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var bulletView: BulletView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondaryStackView: UIStackView!
    @IBOutlet weak var secondaryContainerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(viewModel: DSBulletViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.titleColor.textColor
        
        switch viewModel.titleColor {
        case .nevy:
            bulletView.style = .primaryNevy
        case .grey:
            bulletView.style = .primaryGrey
        case .white:
            bulletView.style = .primaryWhite
        }
        secondaryStackView.removeAllSubviews()
        secondaryStackView.spacing = viewModel.secondarySpacing
        containerStackView.spacing = viewModel.secondaryPadding
        secondaryContainerView.isHidden = viewModel.secondary.isEmpty
        let secondaryViews: [BulletSecondaryView] = viewModel.secondary.map {
            let view = BulletSecondaryView(frame: .zero)
            view.setup(viewModel: $0)
            return view
        }
        
        secondaryStackView.addArrangedSubviews(secondaryViews)
    }
}

// MARK: - Private
private extension BulletPrimaryView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        bulletView.style = .primaryNevy
        
        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.font = DSFont.paragraphSmall
    }
}
