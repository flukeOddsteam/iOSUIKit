//
//  DSRadioNumber.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/12/2565 BE.
//

import UIKit

public enum DSRadioNumberState {
    case `default`
    case onPress
    case selected
}

public typealias DSDSRadioNumberAction = (() -> Void)

/**
 Custom component DSRadioNumberView for Design System
 
 DSPillRadioView is a single radio number.
 
 ![image](/DocumentationImages/ds-radio-number-views.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSRadioNumberView` Class to the UIView
 2. Binding constraint and don't set `width` and `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or wherever you want.
     ```
        @IBOutlet weak var radioNumber1: DSRadioNumberView!
         
        override func viewDidLoad() {
            super.viewDidLoad()
            radioNumber1.setup(action: { self.didTapOnRadioNumberView(self.radioNumber1, self.radioNumberViewList)},
                               state: .default,
                               number: 1)
                            
        }
     ```
 **DSRadioNumber has 3 states:**
 - default
 - onPress
 - selected
 */
public final class DSRadioNumberView: UIView {
    @IBOutlet var containView: UIView!
    @IBOutlet weak var radioNumberLabel: UILabel!
    
    public var state: DSRadioNumberState = .default {
        didSet {
            updateAppearance()
        }
    }
    
    private var number: Int = 0 {
        didSet {
            radioNumberLabel.text = String(number).maxLength(length: 2)
        }
    }
    
    private var action: DSDSRadioNumberAction?

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.containView.backgroundColor = DSColor.componentPrimaryBackgroundOnPress
        self.radioNumberLabel.textColor = DSColor.componentPrimaryDefault
        self.containView.layer.borderColor = UIColor.clear.cgColor
      
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateAppearance()
    }
        
    /// For setup DSRadioNumberView
    ///
    /// Parameter for setup DSRadioNumberView
    /// - Parameter action: action when tap on DSRadioNumber.
    /// - Parameter state: state of DSRadioNumber.
    /// - Parameter number: integer to display as a label on DSlRadioNumberView.
    public func setup(action: DSDSRadioNumberAction?, state: DSRadioNumberState, number: Int) {
        self.action = action
        self.state = state
        self.number = number
    }
    
    public func setAccessibilityIdentifier(id: String? = nil, radioNumberLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.radioNumberLabel.accessibilityIdentifier = radioNumberLabelId
    }
}

// MARK: - Action
extension DSRadioNumberView {
    @objc func selectedViewDidTapped(_ sender: Any) {
        action?()
    }
}

// MARK: - Private
private extension DSRadioNumberView {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        containView.setCircle()
        radioNumberLabel.font = DSFont.buttonMedium
    }
    
    func updateAppearance() {
        containView.backgroundColor = state.backgroundColor
        containView.layer.borderColor = state.borderColor.cgColor
        containView.layer.borderWidth = state.borderWidth
        radioNumberLabel.textColor = state.textColor
    }
        
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedViewDidTapped(_:)))
        self.containView.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
}
