//
//  DSPillRadio.swift
//  OneAppDesignSystem
//
//  Created by TTB on 25/10/22.
//

import UIKit

/**
 Custom component DSPillRadioView for Design System
 
 DSPillRadioView is a single pill radio.
 
 ![image](/DocumentationImages/ds-pill-radio.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSPillRadioView` Class to the UIView
 2. Binding constraint and don't set `width` and `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or wherever you want.
     ```
        @IBOutlet weak var pillRadio: DSPillRadioView!
         
        override func viewDidLoad() {
            super.viewDidLoad()
            pillRadio.setup(textLabel: "Label", state: .default, action: {})
                            
        }
     ```
 **DSPillRadio has 3 states:**
 - default
 - selected
 - disable
 */
public class DSPillRadioView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var label: UILabel!
    
    // MARK: - Public
    /// Variable for update state of DSPillRadioView
    public var state: DSPillRadioState = .default {
        didSet {
            updateAppearance()
        }
    }
    /// Variable for set action of DSPillRadioView
    public var action: DSPillRadioAction?
    
    /// For setup DSPillRadioView
    ///
    /// Parameter for setup DSPillRadioView
    /// - Parameter textLabel: text to display on DSPillRadioView.
    /// - Parameter state: state of DSPillRadioView.
    /// - Parameter action: action when tap on DSPillRadioView.
    public func setup(textLabel: String, state: DSPillRadioState, action: DSPillRadioAction?) {
        self.label.text = textLabel
        self.state = state
        self.action = action
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupUI()
        updateAppearance()
        setupGesture()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupUI()
        updateAppearance()
        setupGesture()
    }
    
    public func setAccessibilityIdentifier(id: String? = nil, labelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = labelId
    }

}

// MARK: - Action
extension DSPillRadioView {
    @objc func pillRadioDidTapped(_ gesture: UIGestureRecognizer) {
        action?()
    }
}

// MARK: - Private
private extension DSPillRadioView {
    func setupUI() {
        label.font = DSFont.labelList
        self.layoutIfNeeded()
        contentView.layoutIfNeeded()
        contentView.setCircle()
    }
    
    func updateAppearance() {
        self.label.textColor = state.textColor
        self.contentView.layer.borderColor = state.borderColor.cgColor
        self.contentView.layer.borderWidth = state.borderWidth
        self.contentView.backgroundColor = state.backgroundColor
        self.isUserInteractionEnabled = state.isUserInteractonEnabled
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(pillRadioDidTapped(_:)))
        self.contentView.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
}
