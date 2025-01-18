//
//  IconHeaderView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/11/24.
//

import UIKit

protocol IconHeaderViewDelegate: AnyObject {
    func didTapped(_ view: IconHeaderView)
}

final class IconHeaderView: UIView, HeaderViewModel {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var leftIconContainerView: UIView!
    @IBOutlet weak var rightIconContainerView: UIView!
    @IBOutlet weak var leftIconImageView: UIImageView!
    @IBOutlet weak var rightIconImageView: UIImageView!
    
    weak var delegate: IconHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(viewModel: DSListExpandViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.font = viewModel.textStyle.font
        leftIconContainerView.isHidden = viewModel.image.isNull
        
        if let image = viewModel.image {
            switch image {
            case .icon(let icon):
                leftIconImageView.image = icon?.image.withRenderingMode(.alwaysTemplate)
                leftIconImageView.tintColor = DSColor.componentLightDefault
            case .spot(let spot):
                leftIconImageView.image = spot?.image
            case let .url(url, placeholder, cacheable):
                leftIconImageView.setImage(with: url, placeHolder: placeholder, cacheable: cacheable)
                leftIconImageView.setColor(color: DSColor.componentLightDefault)
            }
        }
    }
    
    func setDelegate(_ delegate: AnyObject) {
        self.delegate = delegate as? any IconHeaderViewDelegate
    }
    
    func updateStateRightIconImage(_ image: UIImage) {
        rightIconImageView.image = image
    }
}

// MARK: - Action
extension IconHeaderView {
    @objc func didTapped(_ gesture: UIGestureRecognizer) {
        delegate?.didTapped(self)
    }
}

// MARK: - Private
private extension IconHeaderView {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        leftIconImageView.contentMode = .scaleAspectFit
        leftIconImageView.tintAdjustmentMode = .normal

        rightIconImageView.contentMode = .scaleAspectFit
        rightIconImageView.image = DSIcons.icon24OutlineChevronDown.image
        rightIconImageView.tintAdjustmentMode = .normal

        titleLabel.font = DSFont.h3
        titleLabel.textColor = DSColor.componentLightDefault
    }
    
    func setupGesture() {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapped(_:))
        )
        
        headerContainerView.addGestureRecognizer(gesture)
    }
}
