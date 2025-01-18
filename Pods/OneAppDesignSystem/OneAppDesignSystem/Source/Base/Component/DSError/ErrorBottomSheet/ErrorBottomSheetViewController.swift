//
//  ErrorBottomSheetViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/5/2567 BE.
//

import UIKit

protocol ErrorBottomSheetDelegate: AnyObject {
    func errorBottomSheetDidDismiss(_ viewController: ErrorBottomSheetViewController)
}

final class ErrorBottomSheetViewController: UIViewController {
    
    @IBOutlet weak var closeButton: DSClickableIconGeneralIcon!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var ghostButton: DSGhostButton!
    @IBOutlet weak var primaryButton: DSPrimaryButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var type: ErrorBottomSheetType = .block
    
    var viewModel: ErrorBottomSheetViewModel!
    
    var primaryButtonAction: (() -> Void)?
    var ghostButtonAction: (() -> Void)?
    
    weak var delegate: ErrorBottomSheetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyHighlightItems()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        panModalSetNeedsLayoutUpdate()
    }
}

// MARK: - Action
extension ErrorBottomSheetViewController {
    
    @IBAction func primaryButtonDidTapped(_ sender: Any) {
        primaryButtonAction?()
    }
    
    @IBAction func ghostButtonDidTapped(_ sender: Any) {
        ghostButtonAction?()
    }
}

// MARK: - PanModalPresentable
extension ErrorBottomSheetViewController: PanModalPresentable {
    
    func panModalDidDismiss() {
        delegate?.errorBottomSheetDidDismiss(self)
    }
    
    var allowsTapToDismiss: Bool {
        return type.hasCloseButton
    }
    
    var allowsDragToDismiss: Bool {
        return type.hasCloseButton
    }
    
    func shouldRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return type.hasCloseButton
    }
    
    var cornerRadius: CGFloat {
        return DSRadius.radius24px.rawValue
    }
    
    var panModalBackgroundColor: UIColor {
        return DSColor.otherBackgroundOverlayScreen
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var shortFormHeight: PanModalHeight {
        return .intrinsicHeight
    }
    
    var longFormHeight: PanModalHeight {
        return .intrinsicHeight
    }
    
    var topOffset: CGFloat {
        return UIApplication.getStatusBarFrame().height + 16
    }
}

// MARK: - Private
private extension ErrorBottomSheetViewController {
    func setupUI() {
        titleLabel.font = DSFont.h2
        titleLabel.textColor = DSColor.componentLightDefault
        
        descriptionLabel.font = DSFont.paragraphSmall
        descriptionLabel.textColor = DSColor.componentLightDesc
        
        iconImageView.image = viewModel.iconImage
        iconImageView.tintAdjustmentMode = .normal

        iconImageView.setColor(color: DSColor.componentLightDefault)
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        
        primaryButton.largePrimaryText(
            text: viewModel.primaryButtonTitle
        )
        
        ghostButton.largeGhostText(
            text: viewModel.ghostButtonTitle ?? ""
        )
        
        closeButton.setup(
            viewModel: DSClickableIconGeneralIconViewModel(
                tagId: .zero,
                state: .active,
                theme: .light,
                size: .medium,
                imageType: .image(
                    DSIcons.icon24Close.image
                ),
                isBadged: false
            ), action: { [weak self] _ in
                self?.dismiss(animated: true)
            })
        
        closeButton.tintColor = DSColor.componentLightDefault
        
        ghostButton.isHidden = !type.hasGhostButton ? !type.hasGhostButton : viewModel.ghostButtonTitle.isNilOrEmpty
        closeButton.isHidden = !type.hasCloseButton
        
        descriptionLabel.isHidden = !type.hasDescription
        
        view.backgroundColor = DSColor.componentLightBackground
        view.setBorder(
            width: 1,
            color: DSColor.componentLightBackgroundOnPress
        )
        
        view.dsShadowDrop()
        
        primaryButton.setAccessibilityIdentifier(
            id: "primary_button_id",
            titleLabelId: nil
        )
    }
    
    func setupKeyHighlightItems() {
        stackView.arrangedSubviews.filter { $0 is DSKeyHighlightCondition }.forEach { $0.removeFromSuperview() }
        
        guard type.hasMultipleCondition, let multipleConditionData = viewModel.multipleConditionData else {
            return
        }
        
        for item in multipleConditionData {
            let keyHighlightCondition = DSKeyHighlightCondition()
            keyHighlightCondition.setup(title: item.title, state: item.state)
            stackView.addArrangedSubview(keyHighlightCondition)
        }
    }
}
