//
//  DSMenuListMultiSectionTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/10/24.
//

import UIKit

final class DSMenuListMultiSectionTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftIconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    @objc func contentDidTapped(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            highlight()
        case .ended, .cancelled, .failed:
            unhighlight()
        default:
            break
        }
    }
    
    public func configure(viewModel: DSBottomSheetMenuListMultiSectionItem) {
        titleLabel.text = viewModel.title.isEmpty ? " " : viewModel.title
        descriptionLabel.text = viewModel.description
        leftIconView.image = viewModel.image.image.withRenderingMode(.alwaysTemplate)
        leftIconView.tintColor = DSColor.componentLightDefault
    }
    
    public func setAccessibilityIdentifier(
        id: String,
        titleLabelId: String,
        descriptionLabelId: String
    ) {
        self.accessibilityIdentifier = id
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.descriptionLabel.accessibilityIdentifier = descriptionLabelId
    }
    
    func highlight() {
        DispatchQueue.main.async {
            self.set(
                backgroundColor: DSColor.componentLightBackgroundOnPress,
                isHidden: true
            )
        }
    }
    
    func unhighlight() {
        DispatchQueue.main.async {
            self.set(
                backgroundColor: DSColor.componentLightBackground,
                isHidden: false
            )
        }
    }
}

// MARK: - Private
private extension DSMenuListMultiSectionTableViewCell {
    func setUpUI() {
        containerView.setRadius(radius: .radius12px)
        containerView.setBorder(
            width: 1,
            color: DSColor.componentLightOutlineClickable
        )
        
        set(backgroundColor: DSColor.componentLightBackground)
        
        titleLabel.textColor = DSColor.componentLightDefault
        titleLabel.font = DSFont.labelSelectionMedium
        
        descriptionLabel.textColor = DSColor.componentLightDesc
        descriptionLabel.font = DSFont.paragraphSmall
        
        self.selectionStyle = .none
        
        let gesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(contentDidTapped(_:))
        )
        
        gesture.minimumPressDuration = 0.1
        gesture.cancelsTouchesInView = false
        containerView.addGestureRecognizer(gesture)
        containerView.isMultipleTouchEnabled = true
        leftIconView.tintAdjustmentMode = .normal
        
    }
    
    func set(backgroundColor: UIColor, isHidden: Bool = false) {
        self.containerView.backgroundColor = backgroundColor
        self.containerView.dsShadowDrop(isHidden: isHidden)
    }
}
