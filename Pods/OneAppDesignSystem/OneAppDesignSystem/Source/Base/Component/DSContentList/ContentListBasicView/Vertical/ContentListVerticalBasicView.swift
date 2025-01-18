//
//  ContentListVerticalBasicView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import UIKit

class ContentListVerticalBasicView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var leftHeaderTitleLabel: UILabel!
    @IBOutlet weak var rightHeaderTitleLabel: UILabel!
    @IBOutlet weak var headerContainerView: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleContainerView: UIView!
    
    @IBOutlet weak var statusPillView: DSPill!
    @IBOutlet weak var statusPillContainerView: UIView!
    
    @IBOutlet weak var tagPillView: DSPill!
    @IBOutlet weak var tagPillContainerView: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionContainerView: UIView!
    
    @IBOutlet weak var actionGhostContainerView: UIView!
    @IBOutlet weak var actionButton: DSGhostButton!
    
    weak var delegate: ContentListBasicViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setAccessibilityIdentifier(id: String,
                                    leftHeaderTitleLabelId: String,
                                    rightHeaderTitleLabelId: String,
                                    titleLabelId: String,
                                    statusPillViewId: String,
                                    statusPillViewLabelId: String,
                                    tagPillViewId: String,
                                    descriptionLabelId: String,
                                    actionButtonId: String,
                                    actionButtonLabelId: String) {
        self.accessibilityIdentifier = id
        self.leftHeaderTitleLabel.accessibilityIdentifier = leftHeaderTitleLabelId
        self.rightHeaderTitleLabel.accessibilityIdentifier = rightHeaderTitleLabelId
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.statusPillView.setAccessibilityIdentifier(id: statusPillViewId, labelId: statusPillViewLabelId)
        self.tagPillView.accessibilityIdentifier = tagPillViewId
        self.descriptionLabel.accessibilityIdentifier = descriptionLabelId
        self.actionButton.setAccessibilityIdentifier(id: actionButtonId, titleLabelId: actionButtonLabelId)
    }
}

// MARK: - Action
extension ContentListVerticalBasicView {
    @IBAction func ghostActionDidTapped(_ sender: Any) {
        delegate?.contentListBasicViewGhostActionDidTapped(self)
    }
}

// MARK: - ContentListBasicInterface
extension ContentListVerticalBasicView: ContentListBasicViewInterface {
    var view: UIView {
        self
    }
    
    func setup(viewModel: DSContentListViewModel) {
        self.titleLabel.text = viewModel.title
        
        self.leftHeaderTitleLabel.text = viewModel.leftHeaderTitle
        self.rightHeaderTitleLabel.text = viewModel.rightHeaderTitle
        self.headerContainerView.isHidden = viewModel.leftHeaderTitle.isNilOrEmpty && viewModel.rightHeaderTitle.isNilOrEmpty
        
        if let statusPillViewModel = viewModel.statusPill {
            self.statusPillView.setup(style: .status(statusPillViewModel.style), title: statusPillViewModel.title)
        }
        
        self.statusPillContainerView.isHidden = viewModel.statusPill.isNull
        
        if let titleTagPill = viewModel.titleTagPill {
            self.tagPillView.setup(style: .tag, title: titleTagPill)
        }
        
        self.tagPillContainerView.isHidden = viewModel.titleTagPill.isNilOrEmpty
        self.descriptionLabel.text = viewModel.description
        
        switch viewModel.image {
        case .image(let image):
            contentImageView.image = image
        case .url(let url, let placeholder):
            contentImageView.setImage(with: url, placeHolder: placeholder)
        }
        
        actionGhostContainerView.isHidden = viewModel.ghostAction.isNull
        
        if let ghostAction = viewModel.ghostAction {
            actionButton.titleText = ghostAction.title
            actionButton.iconRightImage = ghostAction.rightIcon.image
        }
        
        contentImageView.contentMode = viewModel.imageContentMode
    }
}

// MARK: - Private
private extension ContentListVerticalBasicView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        leftHeaderTitleLabel.font = DSFont.labelInput
        rightHeaderTitleLabel.font = DSFont.labelInput
        
        leftHeaderTitleLabel.textColor = DSColor.componentSummaryDesc
        rightHeaderTitleLabel.textColor = DSColor.componentSummaryDesc
        
        titleLabel.font = DSFont.h4
        titleLabel.textColor = DSColor.componentSummaryDefault
        
        descriptionLabel.font = DSFont.labelInput
        descriptionLabel.textColor = DSColor.componentSummaryDesc
        
        contentImageView.setRadius(radius: DSRadius.radius12px)
        contentImageView.tintAdjustmentMode = .normal

        actionButton.smallGhostNoPaddingRightIconRight(text: "", icon: DSIcons.icon16ChevronRight.image)
    }
}
