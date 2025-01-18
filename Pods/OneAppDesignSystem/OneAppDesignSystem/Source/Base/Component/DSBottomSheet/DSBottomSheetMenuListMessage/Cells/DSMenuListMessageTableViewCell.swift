//
//  DSMenuListMessageTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 31/1/2566 BE.
//

import UIKit

final class DSMenuListMessageTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftIconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()

    }

    @objc func contentDidTapped(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began, .changed: highlight()
        case .ended, .cancelled, .failed:
            unhighlight()
        default:
            break
        }
    }

    public func configure(viewModel: DSBottomSheetMenuListMessageItem) {
        titleLabel.text = viewModel.title
        leftIconView.image = viewModel.icon?.image
    }

    public func setAccessibilityIdentifier(id: String, titleLabelId: String) {
        self.accessibilityIdentifier = id
        self.titleLabel.accessibilityIdentifier = titleLabelId
    }

    func highlight() {
        DispatchQueue.main.async {
            self.set(backgroundColor: DSColor.componentLightBackgroundOnPress)
        }
    }

    func unhighlight() {
        DispatchQueue.main.async {
            self.set(backgroundColor: DSColor.componentLightBackground)
        }
    }
}

// MARK: - Private
private extension DSMenuListMessageTableViewCell {
    func setUpUI() {
        containerView.setRadius(radius: .radius12px)
        containerView.setBorder(width: 1, color: DSColor.componentLightOutlineClickable)
        set(backgroundColor: DSColor.componentLightBackground)

        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.font = DSFont.labelSelection
        self.selectionStyle = .none

        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(contentDidTapped(_:)))
        gesture.minimumPressDuration = 0.1
        gesture.cancelsTouchesInView = false
        containerView.addGestureRecognizer(gesture)
        containerView.isMultipleTouchEnabled = true
        leftIconView.tintAdjustmentMode = .normal

    }

    func set(backgroundColor: UIColor) {
        self.containerView.backgroundColor = backgroundColor
        self.containerView.dsShadowDrop()
    }
}
