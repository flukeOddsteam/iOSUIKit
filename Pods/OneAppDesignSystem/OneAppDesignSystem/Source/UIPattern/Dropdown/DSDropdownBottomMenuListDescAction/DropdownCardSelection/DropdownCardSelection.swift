//
//  DropdownCardSelection.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/5/2567 BE.
//

import UIKit

final class DropdownCardSelection: UIView {
    // MARK: - IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconImageHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    private var viewModel: DropdownCardSelectionViewModel?
    
    var tagId: Int = 0
    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var descriptionText: String = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    var state: DropdownCardSelectionState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    var image: UIImage? {
        didSet {
            iconImageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var size: DropdownCardSelectionIconSize = .medium {
        didSet {
            updateSize()
        }
    }
    
    var action: DropdownCardSelectionAction?
    
    // MARK: - Setup
    func setup(viewModel: DropdownCardSelectionViewModel, state: DropdownCardSelectionState, action: DropdownCardSelectionAction? = nil) {
        tagId = viewModel.tagId
        titleText = viewModel.titleText
        descriptionText = viewModel.descriptionText
        size = viewModel.iconSize
        image = viewModel.iconImage.image
        self.state = state
        self.action = action
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupUI()
        updateAppearance()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupUI()
        updateAppearance()
        setupGesture()
    }
    
    func setPressed() {
        self.state = (self.state == .selected) ? .selectedOnPress : .unselectOnPress
    }

    func setDefault() {
        self.state = (self.state == .selectedOnPress) ? .selected : .default
    }
}

// MARK: - Action
extension DropdownCardSelection {
    @objc func handleAction(_ sender: Any) {
        action?(state)
    }
}

// MARK: - Private
private extension DropdownCardSelection {
    func setupUI() {
        titleLabel.setUp(font: DSFont.h3, textColor: DSColor.componentLightDefault, numberOfLines: 1)
        descriptionLabel.setUp(font: DSFont.paragraphSmall, textColor: DSColor.componentLightDesc, numberOfLines: 0)
        containerView.layer.cornerRadius = 12
        iconImageView.tintColor = DSColor.componentLightDefault
        iconImageView.tintAdjustmentMode = .normal
    }
    
    func setupGesture() {
        addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleAction(_:))
            )
        )
    }
    
    func updateAppearance() {
        containerView.backgroundColor = state.backgroundColor
        containerView.layer.borderColor = state.borderColor.cgColor
        containerView.layer.borderWidth = state.borderWidth
        containerView.dsShadowDrop(isHidden: state.isShadowHidden, style: .bottom)
    }
    
    func updateSize() {
        iconImageWidthConstraint.constant = size.iconSize.width
        iconImageHeightConstraint.constant = size.iconSize.height
        layoutIfNeeded()
    }
}
