//
//  DSBottomSheetGeneralConfirmImage.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/10/2567 BE.
//

import UIKit

private enum Constants {
    static let numberOfLines: Int = 0
    static let borderWidth: CGFloat = 1
}

final class DSBottomSheetGeneralConfirmImage: UIViewController {
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var closeButton: DSClickableIconBadge!
    @IBOutlet private weak var ghostButton: DSGhostButton!
    @IBOutlet private weak var primaryButton: DSPrimaryButton!
    @IBOutlet private weak var containerButtonView: UIStackView!
    @IBOutlet private weak var pictureImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private var currentStyle: BottomSheetMessageStyle!
    private var buttonTextPrimaryAction: (() -> Void)?
    private var buttonTextGhostAction: (() -> Void)?
    private var hasCloseButton: Bool = true
    private var heightBottomSheet: CGFloat = 2000
    weak var delegate: DSBottomSheetGeneralEventDelegate?
    var tagId: Int = 0
    var params: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        setup(currentStyle)
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        panModalSetNeedsLayoutUpdate()
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(style: BottomSheetMessageStyle) {
        let nibname = String(describing: DSBottomSheetGeneralConfirmImage.self)
        let bundle = Bundle(for: DSBottomSheetGeneralConfirmImage.self)
        super.init(nibName: nibname, bundle: bundle)
        self.currentStyle = style
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAccessibilityIdentifier(style: DSBottomSheetAccessibilityIdentifier) {
        if case let .bottomSheetGeneralConfirm(titleId,
                                               descriptionId,
                                               buttonPrimaryId,
                                               buttonPrimaryLabelId,
                                               buttonGhostId,
                                               buttonGhostLabelId,
                                               closeButtonId) = style {
            self.titleLabel.accessibilityIdentifier = titleId
            self.descriptionLabel.accessibilityIdentifier = descriptionId
            self.primaryButton.setAccessibilityIdentifier(id: buttonPrimaryId,
                                                          titleLabelId: buttonPrimaryLabelId)
            self.ghostButton.setAccessibilityIdentifier(id: buttonGhostId,
                                                        titleLabelId: buttonGhostLabelId)
            self.closeButton.setAccessibilityIdentifier(id: closeButtonId)
            
        }
    }
}

// MARK: - Action
extension DSBottomSheetGeneralConfirmImage {
    @IBAction private func didTapExitButton(_ sender: Any) {
        delegate?.bottomSheetDidTapCloseButton(tagId: tagId, params: params)
        self.dismiss(animated: true)
    }
    @IBAction private func didTapPrimaryButton(_ sender: Any) {
        self.dismiss(animated: true)
        buttonTextPrimaryAction?()
    }
    @IBAction private func didTapGhostButton(_ sender: Any) {
        self.dismiss(animated: true)
        buttonTextGhostAction?()
    }
}

// MARK: - Private
private extension DSBottomSheetGeneralConfirmImage {
    func commonInit() {
        titleLabel.font = DSFont.h2
        titleLabel.textColor = DSColor.componentLightDefault
        descriptionLabel.font = DSFont.paragraphSmall
        descriptionLabel.textColor = DSColor.componentLightDesc
        descriptionLabel.numberOfLines = Constants.numberOfLines
        view.backgroundColor = DSColor.componentLightBackground
        self.view.layer.borderWidth = Constants.borderWidth
        self.view.layer.borderColor = DSColor.componentLightOutlineTertiary.cgColor
        closeButton.isHidden = true
        ghostButton.isHidden = true
        primaryButton.isHidden = true
        pictureImageView.isHidden = true
        scrollView.delegate = self
    }
    
    func setup(_ style: BottomSheetMessageStyle) {
        switch style {
        case let .confirmImage(title,
                               description,
                               pictureImageURL,
                               pictureImage,
                               buttonTextPrimary,
                               buttonTextPrimaryAction,
                               buttonTextGhost,
                               buttonTextGhostAction):
            let description = DescriptionBottomSheetInformative.string(description ?? "")
            setLayout(title: title,
                      description: description,
                      pictureImageURL: pictureImageURL,
                      pictureImage: pictureImage,
                      hasCloseButton: hasCloseButton,
                      buttonTextPrimary: buttonTextPrimary,
                      buttonTextPrimaryAction: buttonTextPrimaryAction,
                      buttonTextGhost: buttonTextGhost,
                      buttonTextGhostAction: buttonTextGhostAction)
        default: ()
        }
    }

    func setLayout(title: String,
                   subTitle: String? = nil,
                   description: DescriptionBottomSheetInformative,
                   pictureImageURL: URL?,
                   pictureImage: UIImage?,
                   hasCloseButton: Bool = true,
                   buttonTextPrimary: String?,
                   buttonTextPrimaryAction: (() -> Void)?,
                   buttonTextGhost: String?,
                   buttonTextGhostAction: (() -> Void)?) {
        titleLabel.text = title
        self.hasCloseButton = hasCloseButton
        
        switch description {
        case .attributeString(let nSAttributedString):
            let range = NSRange(location: .zero, length: nSAttributedString.length)
            let fontAttribute: [NSAttributedString.Key: Any] = [.font: DSFont.paragraphSmall ?? .systemFont(ofSize: 14)]
            let textColorAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: DSColor.componentLightDesc]

            let mutableAttribute = NSMutableAttributedString(attributedString: nSAttributedString)
            mutableAttribute.addAttributes(fontAttribute, range: range)
            mutableAttribute.addAttributes(textColorAttribute, range: range)

            descriptionLabel.attributedText = mutableAttribute
        case .styleAttributes(let styleAttributesString):
            descriptionLabel.attributedText = styleAttributesString
        case .string(let string):
            descriptionLabel.isHidden = string.isEmpty
            descriptionLabel.text = string
        }
        
        if hasCloseButton {
            closeButton.setup(style: .normal,
                              image: DSIcons.icon24Close.image)
            closeButton.isHidden = false
        }
        
        if let buttonTextGhost = buttonTextGhost {
            ghostButton.largeGhostText(text: buttonTextGhost)
            ghostButton.isHidden = false
        }
        
        if let buttonTextPriamry = buttonTextPrimary {
            primaryButton.largePrimaryText(text: buttonTextPriamry)
            primaryButton.isHidden = false
        }
        
        if let pictureImageURL = pictureImageURL {
            pictureImageView.isHidden = false
            pictureImageView.contentMode = .scaleAspectFill
            pictureImageView.setImage(with: pictureImageURL,
                                      placeHolder: SvgIcons.placeholderLoadImage.image)
            
        }
        
        if let pictureImage = pictureImage {
            pictureImageView.image = pictureImage
            pictureImageView.isHidden = false
        }
        
        if primaryButton.isHidden && ghostButton.isHidden {
            containerButtonView.isHidden = true
        }
        
        self.buttonTextGhostAction = buttonTextGhostAction
        self.buttonTextPrimaryAction = buttonTextPrimaryAction
    }
}

// MARK: - UIScrollViewDelegate
extension DSBottomSheetGeneralConfirmImage: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isHidden = scrollView.contentOffset.y <= 0
        headerView.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
}

extension DSBottomSheetGeneralConfirmImage: PanModalPresentable {
    
    func panModalWillDismiss() {
        delegate?.bottomSheetWillDismiss(tagId: tagId, params: params)
    }
    
    var allowsTapToDismiss: Bool {
        delegate?.bottomSheetDidTapBackground(tagId: tagId, params: params)
        return hasCloseButton
    }
    
    var allowsDragToDismiss: Bool {
        return hasCloseButton
    }
    
    func shouldRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return hasCloseButton
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
