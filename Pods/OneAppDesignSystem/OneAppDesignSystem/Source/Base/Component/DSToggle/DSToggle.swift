//
//  DSToggle.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/12/22.
//

import UIKit

public enum DSToggleState {
    case onActive
    case offActive
    case onDisable
    case offDisable
}

/// DSToggleDelegate for get state from DsToggle.
public protocol DSToggleDelegate: AnyObject {
    func onToggle(tagId: Int, state: DSToggleState)
}

public typealias DSToggleAction = ((_ currentState: DSToggleState) -> Void)

/**
    Custom component DSToggle for Design System
 
    ![image](/DocumentationImages/ds-toggle.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSToggle` Class to the UIView.
    2. Binding constraint
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var toggle1: DSToggle!
     @IBOutlet weak var toggle2: DSToggle!
 
     override func viewDidLoad() {
         super.viewDidLoad()
         toggle1.setup(state: .onActive,
                       action: {currentState in print("toggle 1: ", currentState)})
         toggle2.setup(state: .offActive)
     }
     ```
     Display state onActive:
     ```
        toggle.setup(state: .onActive)
     ```
     Display state offActive:
     ```
        toggle.setup(state: .offActive)
     ```
     Display state onDisable:
     ```
        toggle.setup(state: .onDisable)
     ```
     Display state offDisable:
     ```
        toggle.setup(state: .offDisable)
     ```
     Set action (optional):
     ```
        toggle.setup(state: .onActive,
                     action: {currentState in print("Do something")})
     ```
     **DSToggle has 4 states:**
     - onActive
     - offActive
     - onDisable
     - offDisable
 */
public final class DSToggle: UIView {
    @IBOutlet private weak var leftIconImageView: UIImageView!
    @IBOutlet private weak var rightIconImageView: UIImageView!
    @IBOutlet private weak var circleView: UIView!
    @IBOutlet private weak var selectedLeftConstaint: NSLayoutConstraint!
    @IBOutlet private weak var selectedRightConstaint: NSLayoutConstraint!
    @IBOutlet private weak var toggleView: UIView!
    
    // MARK: - Public
    /// Variable for updating state of DSToggle
    public var state: DSToggleState = .onActive {
        didSet {
            UIView.animate(withDuration: 0.25) {
                self.updateAppearance()
            }
        }
    }
    /// Variable for setting tag ID of DSToggle
    public var tagId: Int = 0
    
    /// Variable for setting action of DSToggle
    public var action: DSToggleAction?
    
    /// For use toggle delegate.
    public weak var delegate: DSToggleDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSToggle
    ///
    /// Parameter for setup DSToggle
    /// - Parameter state: state of DSToggle.
    /// - Parameter action: action when tap on DSToggle.
    public func setup(state: DSToggleState, action: DSToggleAction? = nil) {
        self.state = state
        self.action = action
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           leftIconImageViewId: String? = nil,
                                           rightIconImageViewId: String? = nil,
                                           circleViewId: String? = nil) {
        self.accessibilityIdentifier = id
        self.leftIconImageView.accessibilityIdentifier = leftIconImageViewId
        self.rightIconImageView.accessibilityIdentifier = rightIconImageViewId
        self.circleView.accessibilityIdentifier = circleViewId
    }
}

// MARK: - Action
extension DSToggle {
    @objc func toggleViewDidTapped(_ sender: Any) {
        guard state.isUserInteractonEnabled else {
            return
        }
        if self.state == .onActive {
            self.state = .offActive
        } else if self.state == .offActive {
            self.state = .onActive
        }
        action?(state)
        delegate?.onToggle(tagId: tagId, state: state)
    }
}

// MARK: - Private
private extension DSToggle {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        self.leftIconImageView.image = DSIcons.icon16Check.image.withRenderingMode(.alwaysTemplate)
        self.leftIconImageView.tintColor = DSColor.componentPrimaryDefault
        self.leftIconImageView.tintAdjustmentMode = .normal

        self.rightIconImageView.image = DSIcons.icon16Close.image.withRenderingMode(.alwaysTemplate)
        self.rightIconImageView.tintColor = DSColor.componentPrimaryDefault
        self.rightIconImageView.tintAdjustmentMode = .normal

        self.circleView.setCircle()
        self.toggleView.setRadius(radius: DSRadius.radius12px)
    }
    
    func updateAppearance() {
        self.toggleView.backgroundColor = state.backgroundColor
        self.toggleView.isUserInteractionEnabled = state.isUserInteractonEnabled
        self.selectedLeftConstaint.priority = state.leftConstaintPriority
        self.selectedRightConstaint.priority = state.rightConstaintPriority
        self.layoutIfNeeded()
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleViewDidTapped(_:)))
        self.toggleView.addGestureRecognizer(tap)
    }
}
