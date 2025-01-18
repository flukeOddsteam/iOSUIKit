//
//  DSDiscountRadioExpanded.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/9/2567 BE.
//

import UIKit

private enum Constants {
    static let defaultBorderWidth: CGFloat = 1.0
    static let selectedBorderWidth: CGFloat = 2.0
    
    static let defaultBorderColor: UIColor = DSColor.componentLightOutlinePrimary
    static let selectedBorderColor: UIColor = DSColor.componentLightOutlineActive
    
    static let defaultImageOpacity: CGFloat = 1.0
    static let disableImageOpacity: CGFloat = 0.3
}

/**
 Custom component DSDiscountRadioExpanded for Design System
 
 This class represents an expandable radio button with an icon, title, and additional content such as list messages, ghost buttons, and bullet notes.
 
 ![image](/DocumentationImages/ds-discount-radio-expanded.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSDiscountRadioExpanded` Class to the UIView.
 2. Binding constraint and don't set `height`.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set up the component using the `setup(viewModel:)` method.
 5. Optionally, set the `onSelectionChanged` closure to handle selection events.
 
 ```
 class ExampleViewController: UIViewController {
     
     @IBOutlet weak var ghostAndBulletRadioExpanded: DSDiscountRadioExpanded!
     @IBOutlet weak var bulletRadioExpanded: DSDiscountRadioExpanded!
     @IBOutlet weak var ghostRadioExpanded: DSDiscountRadioExpanded!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupRadioExpanded()
     }
     
     func setupRadioExpanded() {
         // Sample list messages for the first radio button
         let ghostAndBulletListMessage: [DSRadioListMessageViewModel] = [
             .init(
                 type: .small,
                 viewModel: DSRadioListMessageViewModel.ListItemViewModel(
                     title: "Lorem ipsum dolor sit amet",
                     value: "100,000,000",
                     ratio: 70/30
                 )
             )
         ]
         
         // Setting up the first radio button
         let ghostAndBulletViewModel = DSRadioExpandedViewModel(
             title: "Label1",
             isSelected: false,
             isEnabled: true,
             listMessage: ghostAndBulletListMessage,
             ghostButton: DSGhostRadioExpandedViewModel(
                 title: "Ghost Text",
                 rightIcon: DSIcons.icon24OutlineChevronRight
             ),
             bulletNote: SelectionRemarkViewModel(
                 title: "Note",
                 isShowBullet: false,
                 bulletItems: ["Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
             ),
             iconImage: .image(DSIcons.icon48MRTAHomeLoanRefinance.image)
         )
         
         ghostAndBulletRadioExpanded.setup(viewModel: ghostAndBulletViewModel)
         
         // Setting up other radio buttons similarly
         let bulletRadioListMessage: [DSRadioListMessageViewModel] = [
             .init(
                 type: .small,
                 viewModel: DSRadioListMessageViewModel.ListItemViewModel(
                     title: "Label",
                     value: "Value",
                     ratio: 70/30
                 )
             )
         ]
         
         let bulletRadioViewModel = DSRadioExpandedViewModel(
             title: "Label2",
             isSelected: false,
             isEnabled: true,
             listMessage: bulletRadioListMessage,
             iconImage: .image(DSIcons.icon48OfferingCashYourHome.image)
         )
         
         bulletRadioExpanded.setup(viewModel: bulletRadioViewModel)
         
         let ghostRadioListMessage: [DSRadioListMessageViewModel] = [
             .init(
                 type: .small,
                 viewModel: DSRadioListMessageViewModel.ListItemViewModel(
                     title: "Label",
                     value: "Value",
                     ratio: 70/30
                 )
             )
         ]
         
         let ghostRadioViewModel = DSRadioExpandedViewModel(
             title: "Label3",
             isSelected: false,
             isEnabled: false,
             listMessage: ghostRadioListMessage,
             ghostButton: DSGhostRadioExpandedViewModel(
                 title: "Ghost Text",
                 leftIcon: DSIcons.icon24OutlineEdit
             ),
             iconImage: .image(DSIcons.icon48MRTAPersonalLoan.image)
         )
         
         ghostRadioExpanded.setup(viewModel: ghostRadioViewModel)
         
         // Radio button selection behavior
         let radioButtons = [ghostAndBulletRadioExpanded, bulletRadioExpanded, ghostRadioExpanded]
         
         for radioButton in radioButtons {
             radioButton?.onSelectionChanged = { [weak self] selectedRadioButton in
                 guard let self = self else { return }
                 
                 for otherRadioButton in radioButtons {
                     if otherRadioButton !== selectedRadioButton {
                         otherRadioButton?.isSelected = false
                     }
                 }
             }
         }
     }
 }
 ```
 */
public class DSDiscountRadioExpanded: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var expandView: ExpandView!
    @IBOutlet weak var radioView: RadioView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    /// Closure triggered when the user selects the radio
    public var onSelectedRadioCard: ((DSDiscountRadioExpanded, Int) -> Void)?
    
    /// tagId for identifying component.
    public var tagId: Int = .zero
    
    /// Indicates if the radio button is interactive or disabled.
    public var isEnabled: Bool = true {
        didSet {
            updateRadioAppearance()
        }
    }
    
    /// Indicates if the radio button is currently selected or unselected.
    public var isSelected: Bool = false {
        didSet {
            updateRadioAppearance()
        }
    }
    
    /// The display text for the radio.
    public var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /**
     Configures the DSRadioExpanded component with the provided view model.

     - Parameters:
       - viewModel: The DSRadioExpandedViewModel used to configure the component.
         - title: The title to be displayed.
         - isSelected: Determines if the radio button is currently selected.
         - isEnabled: Determines if the radio button is disabled.
         - listMessage: array of list messages to be displayed.
         - ghostButton: Optional configuration for a ghost button within the component.
         - bulletNote: Optional configuration for a bullet note or remark.
         - iconImage: The image to be displayed, either as a UIImage or a URL.
     */
    public func setup(viewModel: DSRadioExpandedViewModel, tagId: Int = .zero) {
        titleText = viewModel.title
        
        isEnabled = viewModel.isEnabled
        isSelected = viewModel.isSelected
        
        updateImage(imageType: viewModel.iconImage)
        expandView.setup(viewModel: viewModel)
        
        self.tagId = tagId
    }
}

// MARK: - ExpandViewDelegate
extension DSDiscountRadioExpanded: ExpandViewDelegate {
    func expandViewGhostButtonDidTapped(_ view: ExpandView) {
        print(#function)
    }
}

// MARK: - Private Methods
private extension DSDiscountRadioExpanded {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        titleLabel.setUp(
            font: DSFont.labelList,
            textColor: DSColor.componentLightDefault,
            numberOfLines: .zero
        )
        
        iconImageView.setCircle()
        iconImageView.tintAdjustmentMode = .normal

        containerView.backgroundColor = DSColor.componentLightBackground
        containerView.setRadius(radius: .radius12px)
        
        expandView.setRadius(radius: .radius12px)
        expandView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        expandView.backgroundColor = DSColor.componentSummaryBackground
        expandView.delegate = self
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        selectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        onSelectedRadioCard?(self, tagId)
    }
    
    func updateImage(imageType: DSRadioExpandedImageType) {
        switch imageType {
        case .image(let image):
            self.iconImageView.image = image
        case let .url(url, placeholder, cacheable):
            iconImageView.setImage(
                with: url,
                placeHolder: placeholder,
                cacheable: cacheable
            )
        }
        
        iconImageView.alpha = isEnabled ? Constants.defaultImageOpacity : Constants.disableImageOpacity
    }
    
    func updateRadioAppearance() {
        radioView.updateState(
            isEnabled: isEnabled,
            isSelected: isSelected
        )
        
        var borderWidth: CGFloat = Constants.defaultBorderWidth
        var borderColor: UIColor = Constants.defaultBorderColor
        
        if isEnabled {
            borderWidth = isSelected ? Constants.selectedBorderWidth : Constants.defaultBorderWidth
            borderColor = isSelected ? Constants.selectedBorderColor : Constants.defaultBorderColor
        }
        
        containerView.dsShadowDrop(isHidden: !isEnabled)
        containerView.setBorder(width: borderWidth, color: borderColor)
    }
}

// MARK: - RadioView
private extension RadioView {
    func updateState(isEnabled: Bool, isSelected: Bool) {
        if isEnabled {
            state = isSelected ? .selected : .default
        } else {
            self.state = .disableUnselected
        }
    }
}
