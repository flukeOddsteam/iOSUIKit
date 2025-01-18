//
//  DSCopyCode.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/9/2567 BE.
//

import UIKit

/**
 Custom component DSCopyCode for Design System
 
 This class represents a copy code component with a title, value, and
 
 ![image](/DocumentationImages/ds-discount-radio-expanded.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign DSCopyCode Class to the UIView.
 2. Binding constraint and set appropriate width and height.
 3. Connect UIView to @IBOutlet in text editor.
 4. Set up the component using the setup(viewModel:) method.
 
 ```
 class ExampleViewController: UIViewController {
     
     @IBOutlet weak var copyCodeView: DSCopyCode!
     
     override func viewDidLoad() {
         super.setup()
         setupCopyCode()
     }
     
     func setup() {
         let viewModel = DSCopyCodeViewModel(
             title: "Promotion Code",
             value: "SUMMER2024",
             ratio: 0.4,
             onClick: {
                 print("Code copied!")
             }
         )
         
         copyCodeView.setup(viewModel: viewModel)
     }
 }
 ```
 */
public final class DSCopyCode: UIView {
    
    @IBOutlet weak var backgroundView: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var widthLeftContainerConstraint: NSLayoutConstraint!
    
    private var onClick: (() -> Void)?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /**
     Configures the DSCopyCode component with the provided view model.

     - Parameters:
       - viewModel: The DSCopyCodeViewModel used to configure the component.
         - title: The title to be displayed on the left side.
         - value: The value to be displayed on the right side and copied when tapped.
         - ratio: The width ratio of the title label (left side) to the total width.
         - onClick: The closure to be executed when the component is tapped.
     */
    public func setup(viewModel: DSCopyCodeViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        widthLeftContainerConstraint.setMultiplier(multiplier: viewModel.ratio)
        onClick = viewModel.onClick
    }
}

// MARK: - Private
private extension DSCopyCode {
    func commonInit() {
        setupXib()
        setupUI()
        setupTapGesture()
    }
    
    func setupUI() {
        backgroundView.backgroundColor = DSColor.componentLightBackground
        titleLabel.setUp(
            font: DSFont.labelListMedium,
            textColor: DSColor.componentLightLabel,
            numberOfLines: .zero
        )
        
        valueLabel.setUp(
            font: DSFont.valueListMedium,
            textColor: DSColor.componentLightDefault,
            numberOfLines: .zero
        )
        
        iconImage.image = DSIcons.icon24OutlineCopy.image.withRenderingMode(.alwaysTemplate)
        iconImage.tintColor = DSColor.componentLightDefault
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        onClick?()
    }
}
