//
//  DSBottomSheetMessageViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/9/2565 BE.
//

import UIKit

private enum Constants {
    static let numberOfLines: Int = 0
    static let borderWidth: CGFloat = 1
}

public enum BottomSheetMessageStyle {
    case confirm(title: String,
                 description: String,
                 buttonTextPrimary: String,
                 buttonTextPrimaryAction: (() -> Void),
                 buttonTextGhost: String,
                 buttonTextGhostAction: (() -> Void))
    
    case confirmImage(title: String,
                      description: String?,
                      pictureImageURL: URL? = nil,
                      pictureImage: UIImage? = nil,
                      buttonTextPrimary: String,
                      buttonTextPrimaryAction: (() -> Void),
                      buttonTextGhost: String,
                      buttonTextGhostAction: (() -> Void))
    
    case block(title: String,
               description: String,
               buttonTextPrimary: String,
               buttonTextPrimaryAction: (() -> Void))
    
    case error(title: String,
               description: String,
               buttonTextPrimary: String,
               buttonTextPrimaryAction: (() -> Void))
    
    case informative(title: String,
                     subTitle: String?,
                     description: DescriptionBottomSheetInformative,
                     pictureImageURL: URL? = nil,
                     pictureImage: UIImage? = nil)
    
    case limitation(title: String,
                    description: String,
                    buttonTextPrimary: String,
                    buttonTextPrimaryAction: (() -> Void),
                    icon: UIImage)

    case technical(title: String,
                   description: String,
                   buttonTextPrimary: String,
                   buttonTextPrimaryAction: (() -> Void),
                   buttonTextGhost: String? = nil,
                   buttonTextGhostAction: (() -> Void)? = nil,
                   icon: UIImage? = nil,
                   hasCloseButton: Bool)
}

public enum DescriptionBottomSheetInformative {
    case attributeString(NSAttributedString)
    case styleAttributes(NSAttributedString)
    case string(String)
}

final class DSBottomSheetGeneral: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var closeButton: DSClickableIconBadge!
    @IBOutlet weak var ghostButton: DSGhostButton!
    @IBOutlet weak var primaryButton: DSPrimaryButton!
    @IBOutlet weak var containerButtonView: UIStackView!
    @IBOutlet weak var containerIconView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var subTitleContentView: UIView!
    private var buttonTextPrimaryAction: (() -> Void)?
    private var buttonTextGhostAction: (() -> Void)?
    private var hasCloseButton: Bool = true
    private var currentStyle: BottomSheetMessageStyle!
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
        let nibname = String(describing: DSBottomSheetGeneral.self)
        let bundle = Bundle(for: DSBottomSheetGeneral.self)
        super.init(nibName: nibname, bundle: bundle)
        self.currentStyle = style
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAccessibilityIdentifier(style: DSBottomSheetAccessibilityIdentifier) {
        switch style {
        case .bottomSheetGeneralConfirm(let titleId,
                                        let descriptionId,
                                        let buttonPrimaryId,
                                        let buttonPrimaryLabelId,
                                        let buttonGhostId,
                                        let buttonGhostLabelId,
                                        let closeButtonId):
            self.titleLabel.accessibilityIdentifier = titleId
            self.descriptionLabel.accessibilityIdentifier = descriptionId
            self.primaryButton.setAccessibilityIdentifier(id: buttonPrimaryId,
                                                          titleLabelId: buttonPrimaryLabelId)
            self.ghostButton.setAccessibilityIdentifier(id: buttonGhostId,
                                                        titleLabelId: buttonGhostLabelId)
            self.closeButton.setAccessibilityIdentifier(id: closeButtonId)
        case .bottomSheetGeneralBlock(let titleId,
                                      let descriptionId,
                                      let buttonPrimaryId,
                                      let buttonPrimaryLabelId):
            self.titleLabel.accessibilityIdentifier = titleId
            self.descriptionLabel.accessibilityIdentifier = descriptionId
            self.primaryButton.setAccessibilityIdentifier(id: buttonPrimaryId,
                                                          titleLabelId: buttonPrimaryLabelId)
        case .bottomSheetGeneralError(let titleId,
                                      let descriptionId,
                                      let buttonPrimaryId,
                                      let buttonPrimaryLabelId,
                                      let closeButtonId):
            self.titleLabel.accessibilityIdentifier = titleId
            self.descriptionLabel.accessibilityIdentifier = descriptionId
            self.primaryButton.setAccessibilityIdentifier(id: buttonPrimaryId,
                                                          titleLabelId: buttonPrimaryLabelId)
            self.closeButton.setAccessibilityIdentifier(id: closeButtonId)
        case .bottomSheetGeneralInformative(let titleId,
                                            let subTitleId,
                                            let descriptionId,
                                            let closeButtonId):
            self.titleLabel.accessibilityIdentifier = titleId
            self.subTitleLabel.accessibilityIdentifier = subTitleId
            self.descriptionLabel.accessibilityIdentifier = descriptionId
            self.closeButton.setAccessibilityIdentifier(id: closeButtonId)
        case .bottomSheetGeneralLimitation(let titleId,
                                           let descriptionId,
                                           let buttonPrimaryId,
                                           let buttonPrimaryLabelId,
                                           let closeButtonId):
            self.titleLabel.accessibilityIdentifier = titleId
            self.descriptionLabel.accessibilityIdentifier = descriptionId
            self.primaryButton.setAccessibilityIdentifier(id: buttonPrimaryId,
                                                          titleLabelId: buttonPrimaryLabelId)
            self.closeButton.setAccessibilityIdentifier(id: closeButtonId)
        case .bottomSheetTechnical(let titleId,
                                   let descriptionId,
                                   let buttonPrimaryId,
                                   let buttonPrimaryLabelId,
                                   let buttonGhostId,
                                   let buttonGhostLabelId,
                                   let closeButtonId):
            self.titleLabel.accessibilityIdentifier = titleId
            self.descriptionLabel.accessibilityIdentifier = descriptionId
            self.primaryButton.setAccessibilityIdentifier(id: buttonPrimaryId,
                                                          titleLabelId: buttonPrimaryLabelId)
            self.ghostButton.setAccessibilityIdentifier(id: buttonGhostId,
                                                        titleLabelId: buttonGhostLabelId)
            self.closeButton.setAccessibilityIdentifier(id: closeButtonId)
        default: break
        }
    }
}

// MARK: - Action
extension DSBottomSheetGeneral {
    @IBAction func didTapExitButton(_ sender: Any) {
        delegate?.bottomSheetDidTapCloseButton(tagId: tagId, params: params)
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapPrimaryButton(_ sender: Any) {
        self.dismiss(animated: true)
        buttonTextPrimaryAction?()
    }
    
    @IBAction func didTapGhostButton(_ sender: Any) {
        self.dismiss(animated: true)
        buttonTextGhostAction?()
    }
}

// MARK: - Private
private extension DSBottomSheetGeneral {
    func commonInit() {
        titleLabel.font = DSFont.h2
        titleLabel.textColor = DSColor.componentLightDefault
        subTitleLabel.font = DSFont.h3
        subTitleLabel.textColor = DSColor.componentLightDefault
        subTitleLabel.numberOfLines = Constants.numberOfLines
        descriptionLabel.font = DSFont.paragraphSmall
        descriptionLabel.textColor = DSColor.componentLightDesc
        descriptionLabel.numberOfLines = Constants.numberOfLines
        view.backgroundColor = DSColor.componentLightBackground
        self.view.layer.borderWidth = Constants.borderWidth
        self.view.layer.borderColor = DSColor.componentLightBackgroundOnPress.cgColor
        closeButton.isHidden = true
        ghostButton.isHidden = true
        primaryButton.isHidden = true
        containerIconView.isHidden = true
        pictureImageView.isHidden = true
        subTitleContentView.isHidden = true
        scrollView.delegate = self
        iconImageView.tintAdjustmentMode = .normal

    }
    
    func setup(_ style: BottomSheetMessageStyle) {
        switch style {
        case .confirm(let title,
                      let description,
                      let buttonTextPrimary,
                      let buttonTextPrimaryAction,
                      let buttonTextGhost,
                      let buttonTextGhostAction):
            let description = DescriptionBottomSheetInformative.string(description)
            setLayout(title: title,
                      description: description,
                      icon: nil,
                      pictureImageURL: nil,
                      pictureImage: nil,
                      hasCloseButton: hasCloseButton,
                      buttonTextPrimary: buttonTextPrimary,
                      buttonTextPrimaryAction: buttonTextPrimaryAction,
                      buttonTextGhost: buttonTextGhost,
                      buttonTextGhostAction: buttonTextGhostAction)
        case .block(let title,
                    let description,
                    let buttonTextPrimary,
                    let buttonTextPrimaryAction):
            let description = DescriptionBottomSheetInformative.string(description)
            setLayout(title: title,
                      description: description,
                      icon: DSIcons.icon36OutlineAlert.image,
                      pictureImageURL: nil,
                      pictureImage: nil,
                      hasCloseButton: false,
                      buttonTextPrimary: buttonTextPrimary,
                      buttonTextPrimaryAction: buttonTextPrimaryAction,
                      buttonTextGhost: nil,
                      buttonTextGhostAction: nil)
            iconImageView.tintColor = DSColor.componentLightError
        case .error(let title,
                    let description,
                    let buttonTextPrimary,
                    let buttonTextPrimaryAction):
            let description = DescriptionBottomSheetInformative.string(description)
            setLayout(title: title,
                      description: description,
                      icon: DSIcons.icon36OutlineAlert.image,
                      pictureImageURL: nil,
                      pictureImage: nil,
                      hasCloseButton: true,
                      buttonTextPrimary: buttonTextPrimary,
                      buttonTextPrimaryAction: buttonTextPrimaryAction,
                      buttonTextGhost: nil,
                      buttonTextGhostAction: nil)
            iconImageView.tintColor = DSColor.componentLightError
        case .informative(let title,
                          let subTitle,
                          let description,
                          let pictureImageURL,
                          let pictureImage):
            setLayout(title: title,
                      subTitle: subTitle,
                      description: description,
                      icon: nil,
                      pictureImageURL: pictureImageURL,
                      pictureImage: pictureImage,
                      buttonTextPrimary: nil,
                      buttonTextPrimaryAction: nil,
                      buttonTextGhost: nil,
                      buttonTextGhostAction: nil)
        case .limitation(let title,
                         let description,
                         let buttonTextPrimary,
                         let buttonTextPrimaryAction,
                         let icon):
            let description = DescriptionBottomSheetInformative.string(description)
            setLayout(title: title,
                      description: description,
                      icon: icon,
                      pictureImageURL: nil,
                      pictureImage: nil,
                      hasCloseButton: true,
                      buttonTextPrimary: buttonTextPrimary,
                      buttonTextPrimaryAction: buttonTextPrimaryAction,
                      buttonTextGhost: nil,
                      buttonTextGhostAction: nil)
            iconImageView.tintColor = DSColor.componentLightDefault
        case .technical(let title,
                        let description,
                        let buttonTextPrimary,
                        let buttonTextPrimaryAction,
                        let buttonTextGhost,
                        let buttonTextGhostAction,
                        let icon,
                        let hasCloseButton):
            let description = DescriptionBottomSheetInformative.string(description)
            setLayout(title: title,
                      description: description,
                      icon: icon,
                      pictureImageURL: nil,
                      pictureImage: nil,
                      hasCloseButton: hasCloseButton,
                      buttonTextPrimary: buttonTextPrimary,
                      buttonTextPrimaryAction: buttonTextPrimaryAction,
                      buttonTextGhost: buttonTextGhost,
                      buttonTextGhostAction: buttonTextGhostAction)
            iconImageView.tintColor = DSColor.componentLightDefault
        default: break
        }
    }

    func setLayout(title: String,
                   subTitle: String? = nil,
                   description: DescriptionBottomSheetInformative,
                   icon: UIImage?,
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
        
        if let icon = icon {
            containerIconView.isHidden = false
            iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
        }
        
        if let pictureImageURL = pictureImageURL {
            pictureImageView.isHidden = false
            pictureImageView.setImage(with: pictureImageURL,
                                      placeHolder: SvgIcons.placeholderLoadImage.image)
            pictureImageViewHeight.constant = (9 * (UIScreen.main.bounds.width - 32)) / 16
        }
        
        if let pictureImage = pictureImage {
            pictureImageView.image = pictureImage
            pictureImageView.isHidden = false
        }
        
        if pictureImage == nil && pictureImageURL == nil, case .informative = currentStyle {
            titleLabel.textAlignment = .left
            subTitleLabel.textAlignment = .left
            descriptionLabel.textAlignment = .left
        }
        
        if primaryButton.isHidden && ghostButton.isHidden {
            containerButtonView.isHidden = true
        }
        
        if let subTitle = subTitle {
            subTitleLabel.text = subTitle
            subTitleContentView.isHidden = false
        }
        
        self.buttonTextGhostAction = buttonTextGhostAction
        self.buttonTextPrimaryAction = buttonTextPrimaryAction
    }
}

// MARK: - UIScrollViewDelegate
extension DSBottomSheetGeneral: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isHidden = scrollView.contentOffset.y <= 0
        headerView.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
}

extension DSBottomSheetGeneral: PanModalPresentable {
    
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
