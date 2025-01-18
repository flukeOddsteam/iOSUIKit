//
//  DSListActionAvatarTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 15/5/2566 BE.
//

import UIKit

protocol DSListActionAvatarTableViewCellDelegate: AnyObject {
    func listActionAvatarTableViewCell(
        _ view: DSListActionAvatarTableViewCell,
        didSelectFavoriteAt index: Int,
        style: DSClickableIconFavoriteStyle
    )
    func listActionAvatarTableViewCell(
        _ view: DSListActionAvatarTableViewCell,
        didSelectPrimaryButtonAt index: Int
    )
    func listActionAvatarTableViewCell(
        _ view: DSListActionAvatarTableViewCell,
        didSelectSecondaryButtonAt index: Int
    )
}

class DSListActionAvatarTableViewCell: UITableViewCell, NibLoadable {
    
    @IBOutlet weak var avatarView: DSAvatar!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var bottomBorder: UIView!
    
    lazy var favoriteView: DSClickableIconFavorite = {
        return DSClickableIconFavorite()
    }()
    
    lazy var primaryButton: DSGhostButton = {
        let primaryButton = DSGhostButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapPrimaryButton(sender:)))
        primaryButton.addGestureRecognizer(tapGesture)
        return primaryButton
    }()
    
    lazy var secondaryButton: DSGhostButton = {
        let secondaryButton = DSGhostButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapSecondaryButton(sender:)))
        secondaryButton.addGestureRecognizer(tapGesture)
        return secondaryButton
    }()
    
    weak var delegate: DSListActionAvatarTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    public func configure(viewModel: DSListActionAvatarFavoriteViewModel, isShowBottomLine: Bool) {
        avatarView.setup(style: .profile, avatarImage: viewModel.avatarImage)
        label.text = viewModel.label
        buttonStackView.removeAllSubviews()
        let style: DSClickableIconFavoriteStyle = viewModel.isFavorite ? .selected : .default
        favoriteView.setup(style: style) { [weak self] (_, style, _) in
            guard let self = self else { return }
            let newStyle: DSClickableIconFavoriteStyle = style == .default ? .selected : .default
            self.favoriteView.style = newStyle
            self.delegate?.listActionAvatarTableViewCell(self,
                                                         didSelectFavoriteAt: self.tag,
                                                         style: newStyle)
        }
        favoriteView.isUserInteractionEnabled = true
        buttonStackView.addArrangedSubview(favoriteView)
    }
    
    public func configure(viewModel: DSListActionAvatarGhostViewModel, isShowBottomLine: Bool) {
        avatarView.setup(style: .profile, avatarImage: viewModel.avatarImage)
        label.text = viewModel.label
        buttonStackView.removeAllSubviews()
        primaryButton.mediemGhostIcon(icon: viewModel.primaryButtonImage)
        buttonStackView.addArrangedSubview(primaryButton)
        if let secondaryButtonImage = viewModel.secondaryButtonImage {
            secondaryButton.mediemGhostIcon(icon: secondaryButtonImage)
            buttonStackView.addArrangedSubview(secondaryButton)
        }
    }
    
    @objc func onTapPrimaryButton(sender: UITapGestureRecognizer) {
        delegate?.listActionAvatarTableViewCell(self, didSelectPrimaryButtonAt: tag)
    }
    
    @objc func onTapSecondaryButton(sender: UITapGestureRecognizer) {
        delegate?.listActionAvatarTableViewCell(self, didSelectSecondaryButtonAt: tag)
    }
    
    public func setAccessibilityIdentifier(id: String,
                                           titleLableId: String,
                                           favoriteButtonId: String) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = titleLableId
        self.favoriteView.accessibilityIdentifier = favoriteButtonId
    }
    
    public func setAccessibilityIdentifier(id: String,
                                           titleLableId: String,
                                           primaryButtonId: String,
                                           secondaryButtonId: String) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = titleLableId
        self.primaryButton.accessibilityIdentifier = primaryButtonId
        self.secondaryButton.accessibilityIdentifier = secondaryButtonId
    }
}
    
private extension DSListActionAvatarTableViewCell {
    func setupUI() {
        label.font = DSFont.h3
        label.textColor = DSColor.componentLightDefault
        avatarView.setup(style: .profile, avatarImage: nil)
        bottomBorder.backgroundColor = DSColor.componentDividerBackgroundSmall
        self.selectionStyle = .none
    }
}
