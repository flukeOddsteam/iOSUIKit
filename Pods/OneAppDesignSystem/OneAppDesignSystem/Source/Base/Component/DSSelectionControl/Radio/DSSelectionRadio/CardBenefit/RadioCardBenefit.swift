//
//  RadioCardBenefit.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/4/2566 BE.
//

import UIKit

final class RadioCardBenefit: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var creditCardImageView: UIImageView!
    @IBOutlet weak var wowImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountUnitLabel: UILabel!
    @IBOutlet weak var radioView: RadioView!
    
    // MARK: - Public
    public var state: DSSelectionRadioState? = .default {
        didSet {
            updateAppearance()
        }
    }
    
    public var style: DSSelectionRadioCardBenefitListStyle? = .card {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - private variable
    private var image: DSRadioCardBenefitImageType?
    private var title: String?
    private var amount: String?
    private var amountUnit: String?
    
    // MARK: - public function
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func setup(image: DSRadioCardBenefitImageType,
                      title: String,
                      amount: String,
                      amountUnit: String,
                      style: DSSelectionRadioCardBenefitListStyle,
                      state: DSSelectionRadioState) {
        self.image = image
        self.title = title
        self.amount = amount
        self.amountUnit = amountUnit
        self.state = state
        self.style = style
    }
}
    
// MARK: - Private
private extension RadioCardBenefit {
    func commonInit() {
        setupXib()
        commonUI()
    }
    
    func commonUI() {
        self.titleLabel.font = DSFont.labelInput
        self.titleLabel.textColor = DSColor.componentLightLabel
        
        self.amountLabel.font = DSFont.buttonSmall
        self.amountLabel.textColor = DSColor.componentLightDefault
        
        self.amountUnitLabel.font = DSFont.labelList
        self.amountUnitLabel.textColor = DSColor.componentLightDefault
        
        self.backgroundColor = DSColor.componentLightBackground
        self.layer.cornerRadius = DSRadius.radius16px.rawValue
        
        self.updateRadioViewAppearance()
        self.updateContainerViewAppearance()
        self.updateImageAppearance()
    }
    
    func updateAppearance() {
        self.titleLabel.text = self.title
        self.amountLabel.text = self.amount
        self.amountUnitLabel.text = self.amountUnit
        
        self.updateRadioViewAppearance()
        self.updateContainerViewAppearance()
        self.updateImageAppearance()
    }
    
    func updateContainerViewAppearance() {
        self.containerView.layer.cornerRadius = DSRadius.radius16px.rawValue
        
        switch self.state {
        case .selected:
            self.containerView.setBorder(width: 2, color: DSColor.componentLightOutlineActive)
        case .disableUnselected:
            self.containerView.backgroundColor = DSColor.componentDisableBackground
            self.containerView.setBorder(width: 2, color: DSColor.componentDisableOutline)
        default:
            self.containerView.backgroundColor = DSColor.componentLightBackground
            self.containerView.setBorder(width: 1, color: DSColor.componentLightOutline)
        }
        self.containerView.dsShadowDrop()
    }
    
    func updateRadioViewAppearance() {
        switch self.state {
        case .selected:
            self.radioView.state = .selected
            self.radioView.alpha = 1
            
        case .disableUnselected:
            self.radioView.state = .disableUnselected
            self.radioView.alpha = 0.3
            
        default:
            self.radioView.state = .default
            self.radioView.alpha = 1
            
        }
    }
    
    func updateImageAppearance() {
        wowImageView.tintAdjustmentMode = .normal
        creditCardImageView.tintAdjustmentMode = .normal

        self.wowImageView.setCircle()
        
        switch self.style {
        case .icon:
            self.creditCardImageView.isHidden = true
            self.wowImageView.isHidden = false
        default:
            self.creditCardImageView.isHidden = false
            self.wowImageView.isHidden = true
        }
        
        switch self.image {
        case .image(let image):
            self.creditCardImageView.image = image
            self.wowImageView.image = image
        case .url(let url, let placeholder):
            self.creditCardImageView.setImage(with: url, placeHolder: placeholder ?? style?.placeHolderImage)
            self.wowImageView.setImage(with: url, placeHolder: placeholder ?? style?.placeHolderImage)
        default:
            self.creditCardImageView.image = style?.placeHolderImage
            self.wowImageView.image = style?.placeHolderImage
        }
        
        switch self.state {
        case .disableUnselected:
            self.creditCardImageView.alpha = 0.3
            self.wowImageView.alpha = 0.3
        default:
            self.creditCardImageView.alpha = 1
            self.wowImageView.alpha = 1
        }
    }
}
