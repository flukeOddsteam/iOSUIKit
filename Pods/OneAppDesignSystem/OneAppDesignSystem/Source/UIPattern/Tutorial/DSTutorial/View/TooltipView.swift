//
//  DSTooltip.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/7/2567 BE.
//

import UIKit

private enum Constants {
    static let cornerRadius: CGFloat = 16
}

protocol TooltipViewDelegate: AnyObject {
    func tooltipCloseButtonDidTapped(_ view: TooltipView)
    func tooltipPrimaryButtonDidTapped(_ view: TooltipView)
    func tooltipSecondaryButtonDidTapped(_ view: TooltipView)
}

protocol TooltipViewDataSource: AnyObject {
    var tooltipRect: CGRect { get }
}

final class TooltipView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var closeButton: DSClickableIconGeneralIcon!
    @IBOutlet weak var primaryButton: DSPrimaryButton!
    @IBOutlet weak var secondaryButton: DSSecondaryButton!
    
    @IBOutlet weak var arrowUpContainerView: UIView!
    @IBOutlet weak var arrowDownContainerView: UIView!
    @IBOutlet weak var arrowDownImageView: UIImageView!
    @IBOutlet weak var arrowUpImageView: UIImageView!
    
    @IBOutlet weak var leadingDownArrowConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingUpArrowConstraint: NSLayoutConstraint!
    
    weak var delegate: TooltipViewDelegate?
    weak var dataSource: TooltipViewDataSource?
    
    var state: DSTutorialTooltipState = .inProgress {
        didSet {
            updateState()
        }
    }
    
    var position: DSTutorialPosition = .topLeft {
        didSet {
            updatePosition()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func update(viewModel: DSTutorialViewModel) {
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.stepLabel.text = viewModel.step
        self.primaryButton.titleText = viewModel.buttonTitle
        self.secondaryButton.titleText = viewModel.buttonTitle
        self.state = viewModel.tooltipState
        self.position = viewModel.position
    }
    
    func setArrowPosition(_ xPosition: CGFloat) {
        let arrowPosition = translateToConstraint(xPosition: xPosition)
        leadingUpArrowConstraint.constant = arrowPosition
        leadingDownArrowConstraint.constant = arrowPosition
        layoutIfNeeded()
    }
}

extension TooltipView {
    @IBAction func primaryButtonDidTapped(_ sender: Any) {
        delegate?.tooltipPrimaryButtonDidTapped(self)
    }
    
    @IBAction func secondaryButtonDidTapped(_ sender: Any) {
        delegate?.tooltipSecondaryButtonDidTapped(self)
    }
}

// MARK: - Private
private extension TooltipView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.setUp(
            font: DSFont.h3,
            textColor: DSColor.componentLightDefault,
            numberOfLines: 1
        )
        
        descriptionLabel.setUp(
            font: DSFont.paragraphSmall,
            textColor: DSColor.componentLightDesc,
            numberOfLines: .zero
        )
        
        stepLabel.setUp(
            font: DSFont.labelXSmall,
            textColor: DSColor.componentLightDesc,
            numberOfLines: 1
        )
        
        closeButton.setup(
            viewModel: DSClickableIconGeneralIconViewModel(
                tagId: .zero,
                state: .active,
                theme: .light,
                size: .small,
                imageType: .image(
                    DSIcons.icon16Close.image
                ),
                isBadged: false
            ), action: { _ in
                self.delegate?.tooltipCloseButtonDidTapped(self)
                self.removeFromSuperview()
            }
        )
        
        containerView.backgroundColor = DSColor.componentLightBackground
        containerView.setRadius(radius: .radius16px)
        
        primaryButton.smallPrimaryText(text: "")
        secondaryButton.smallSecondaryText(text: "")
        
        arrowUpImageView.image = SvgIcons.iconArrowUp.image
        arrowDownImageView.image = SvgIcons.iconArrowDown.image
        
        state = .inProgress
        position = .topLeft
    }
    
    func updateState() {
        primaryButton.isHidden = state.isHiddenPrimaryButton
        secondaryButton.isHidden = state.isHiddenSecondaryButton
    }
    
    func updatePosition() {
        arrowUpContainerView.isHidden = position.direction == .top
        arrowDownContainerView.isHidden = position.direction == .bottom
    }
    
    func translateToConstraint(xPosition: CGFloat) -> CGFloat {
        guard let frame = dataSource?.tooltipRect else {
            return .zero
        }
        
        var tempXPosition = xPosition
        
        let halfWidthArrowImage: CGFloat
        
        switch position.direction {
        case .top:
            halfWidthArrowImage = arrowUpImageView.frame.width / 2
        case .bottom:
            halfWidthArrowImage = arrowDownImageView.frame.width / 2
        }
        
        let minX = frame.minX + Constants.cornerRadius + halfWidthArrowImage
        let maxX = frame.maxX - Constants.cornerRadius - halfWidthArrowImage
        
        if xPosition < minX {
            tempXPosition = minX
        } else if xPosition > maxX {
            tempXPosition = maxX
        }
        
        let translate = tempXPosition - frame.minX - halfWidthArrowImage
        return translate
    }
}
