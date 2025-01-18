//
//  DSDivider.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/3/2566 BE.
//

import UIKit
/**
    Custom component DSDivider for Design System

    ![image](/DocumentationImages/ds-divider.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign ` DSDivider` Class to the UIView.
    2. Binding constraint and don't set `height` and `width` just set it to placeholder layout.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var divider: DSDivider!

     override func viewDidLoad() {
         super.viewDidLoad()
         divider.setup(size: .large, orientation: .horizontal)
     }
     ```
 */

public final class DSDivider: UIView {

    private var view = UIView(frame: .zero)
    private var size: DSDividerSize = .small
    private var orientation: DSDividerOrientation = .horizontal

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSDivider
    ///
    /// Parameter for setup DSDivider
    /// - Parameter size: size of divider. (e.g. small / large)
    /// - Parameter orientation: orientation of view. (e.g. horizontal / vertical)
    public func setup(size: DSDividerSize,
                      orientation: DSDividerOrientation) {
        self.size = size
        self.orientation = orientation
        self.updateUI()
    }
}

// MARK: - Private
private extension DSDivider {
    func commonInit() {
        backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }

    func updateUI() {
        view.backgroundColor = size.backgroundColor

        var constraints: [NSLayoutConstraint] = []

        switch orientation {
        case .horizontal:
            constraints = [
                view.topAnchor.constraint(equalTo: self.topAnchor),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                view.heightAnchor.constraint(equalToConstant: self.size.value),
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ]
        case .vertical:
            constraints = [
                view.topAnchor.constraint(equalTo: self.topAnchor),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                view.widthAnchor.constraint(equalToConstant: self.size.value),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ]
        }

        NSLayoutConstraint.activate(constraints)
        layoutIfNeeded()
    }
}
