//
//  DSBulletNumberPrimaryView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/1/2566 BE.
//

import UIKit

final class BulletNumberPrimaryView: UIView {
    
    @IBOutlet weak var prefixLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var containerStackView: UIStackView!
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
    
    func setup(order: Int, viewModel: DSBulletNumberViewModel) {
        prefixLabel.text = [String(order), "."].joined()
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.titleColor.textColor
        prefixLabel.textColor = viewModel.titleColor.textColor
        secondaryContainerView.isHidden = viewModel.secondary.isEmpty
        secondaryStackView.spacing = viewModel.secondarySpacing
        containerStackView.spacing = viewModel.secondaryPadding
        var runningNumber: Int = .zero
        let secondaryViews: [BulletNumberSecondaryView] = viewModel.secondary.map {
            runningNumber = $0.style == .number ? runningNumber + 1 : runningNumber
            
            let view = BulletNumberSecondaryView(frame: .zero)
            let prefix = $0.style == .number ? [String(order), String(runningNumber)].joined(separator: ".") : nil
            view.setup(viewModel: $0, prefix: prefix)
            return view
        }
        
        secondaryStackView.addArrangedSubviews(secondaryViews)
    }
}

// MARK: - Private
private extension BulletNumberPrimaryView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        prefixLabel.textColor = DSColor.componentLightDefault
        prefixLabel.font = DSFont.paragraphSmall
        
        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.font = DSFont.paragraphSmall
    }
}
