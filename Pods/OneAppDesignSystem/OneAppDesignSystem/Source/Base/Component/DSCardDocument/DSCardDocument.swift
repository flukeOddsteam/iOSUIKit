//
//  DSCardDocument.swift
//  OneAppDesignSystem
//
//  Created TTB on 21/3/2566 BE.
//

import UIKit

/// Delegate for DSCardDocument
public protocol DSCardDocumentDelegate: AnyObject {
    func selectionCardDocumentViewDidTapped(_ tagId: Int)
}

/**
 Custom component DSCardDocument

 **Overview**
 ![image](/DocumentationImages/ds-card-document-1.png)


 **Contents**
 ![image](/DocumentationImages/ds-card-document-2.svg)

    **Usage Example:**
     class YourViewController: UIViewController {
         1. Declare some variable (IBOutlet, viewModel)
         ```
         @IBOutlet weak var cardDocument: DSCardDocument!
         var cardDocumentViewModel: DSCardDocumentViewModel?

         2. Setup to source code
         ```
         override func viewDidLoad() {
            super.viewDidLoad()

            // Mock data to view model
            cardDocumentViewModel = DSCardDocumentViewModel(image: .image(UIImage(named: "ds-card-document-2"), category: nil, title: "Title", subTitle: "Subtitle")

            // Config my viewController for waiting the result from user tapped CardDucument View.
            self.cardDocument1.delegate = self

            // setup view
            self.cardDocument1.setup(viewModel: cardDocumentViewModel, tagId: 0)
         }
     }

    3. Waiting the result from user tapped CardDucument View.
     ```
     extension YourViewController: DSCardDocumentDelegate {
         func selectionCardDocumentViewDidTapped(_ tagId: Int) {
             // Handle clickable a card content here..
         }
     }
 */

public final class DSCardDocument: UIView {
    // MARK: - Private outlet variable
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var backgroundShadowView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var dividerLineView: UIView!
    @IBOutlet private weak var labelView: UIView!

    @IBOutlet private weak var imageAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet private weak var subTitleLabelHightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var subTitleLabelBottomSpaceConstraint: NSLayoutConstraint!

    // MARK: - public variable

    /// Variable for define id card ducument
    public var tagId: Int = .zero

    /// Variable for config component to return user tapped the result.
    public weak var delegate: DSCardDocumentDelegate?

    // MARK: - Private variable
    private var viewModel: DSCardDocumentViewModel? {
        didSet {
            updateContent()
        }
    }

    public override func layoutSublayers(of layer: CALayer) {
        self.updateImageViewAppearance()
    }

    // MARK: - public function

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// Parameter for setup
    /// - Parameter viewModel: view model to my component.
    /// - Parameter tagId: define id card ducument.
    public func setup(viewModel: DSCardDocumentViewModel?, tagId: Int = .zero) {
        self.viewModel = viewModel
        self.tagId = tagId
    }
}

// MARK: - Action
extension DSCardDocument {
    @objc
    func selectionCardDocumentViewDidTapped(_ gesture: UIGestureRecognizer) {
        self.delegate?.selectionCardDocumentViewDidTapped(tagId)
    }
}

// MARK: - Private
private extension DSCardDocument {
    func commonInit() {
        setupXib()
        commonUI()
        setupGesture()
    }

    func commonUI() {
        self.imageView.image = SvgIcons.placeholder1x1.image
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.tintAdjustmentMode = .normal

        self.categoryLabel.font = DSFont.allCap
        self.categoryLabel.textColor = DSColor.componentLightDesc

        self.titleLabel.font = DSFont.h4
        self.titleLabel.textColor = DSColor.componentLightDefault

        self.subTitleLabel.font = DSFont.labelInput
        self.subTitleLabel.textColor = DSColor.componentLightDefault

        self.layer.cornerRadius = DSRadius.radius16px.rawValue
        self.dividerLineView.backgroundColor = DSColor.componentDividerBackgroundBig
        self.labelView.backgroundColor = DSColor.componentLightBackground

        self.containerView.layer.cornerRadius = DSRadius.radius16px.rawValue
        self.containerView.setBorder(width: 1, color: DSColor.componentLightOutlineClickable)
        self.backgroundShadowView.layer.cornerRadius = DSRadius.radius16px.rawValue
        self.backgroundShadowView.dsShadowDrop()
    }

    func updateImageViewAppearance() {
        self.imageView.roundCorners(corners: [.topLeft, .topRight], radius: DSRadius.radius16px.rawValue)
    }

    func updateContent() {
        self.categoryLabel.text = self.viewModel?.category?.uppercased()
        self.titleLabel.text = self.viewModel?.title
        self.subTitleLabel.text = self.viewModel?.subTitle

        updateImageAppearance()
        updateTitleAppearance()
    }

    func updateTitleAppearance() {
        if self.titleLabel.lines() > 1 {
            self.subTitleLabelHightConstraint.constant = 0
            self.subTitleLabelBottomSpaceConstraint.constant = 12
        } else {
            self.subTitleLabelHightConstraint.constant = 16
            self.subTitleLabelBottomSpaceConstraint.constant = 16
        }
    }

    func updateImageAppearance() {
        switch self.viewModel?.image {
        case .image(let image):
            self.imageView.image = image
            let imageRatio = CGFloat(self.imageView.image?.size.width ?? 0.0) / CGFloat(self.imageView.image?.size.height ?? 0.0)
            self.imageAspectRatioConstraint = self.imageAspectRatioConstraint.setMultiplier(multiplier: imageRatio)
        case .url(let url, let placeholder):
            self.imageView.setImage(with: url,
                                    placeHolder: placeholder ?? SvgIcons.placeholder16x9.image,
                                    completion: {
                let imageRatio = CGFloat(self.imageView.image?.size.width ?? 0.0) / CGFloat(self.imageView.image?.size.height ?? 0.0)
                self.imageAspectRatioConstraint = self.imageAspectRatioConstraint.setMultiplier(multiplier: imageRatio)
            })
        default:
            self.imageView.image = SvgIcons.placeholder16x9.image
        }
        
        self.layoutIfNeeded()
    }

    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectionCardDocumentViewDidTapped(_:)))
        self.addGestureRecognizer(tapGesture)
    }
}
