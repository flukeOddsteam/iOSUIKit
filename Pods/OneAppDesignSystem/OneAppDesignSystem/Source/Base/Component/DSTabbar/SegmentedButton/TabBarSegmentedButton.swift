//
//  TabbarSegmentedButton.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/9/2565 BE.
//

import UIKit

class TabBarSegmentedButton: UIView {
    typealias TabBarSegmentedButtonAction = ((_ referenceId: Int) -> Void)
    
    // MARK: - Views
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Variable
    var action: TabBarSegmentedButtonAction?
    var referenceId: Int = .zero
    var segmentedStateOfTheme: SegmentedStateOfTheme = .light(.default) {
        didSet {
            updateAppearance()
        }
    }
    
    var titleText: String? {
        didSet {
            updateTitle()
        }
    }
    
    // MARK: - Life Cycle
    init(referenceId: Int,
         title: String,
         action: TabBarSegmentedButtonAction?,
         viewAccessibilityId: String,
         titleLabelAccessibilityId: String) {
        super.init(frame: .zero)
        setupXib()
        setupUI()
        updateAppearance()
        setup(referenceId: referenceId, title: title, action: action)
        setAccessibilityIdentifier(id: viewAccessibilityId,
                                   titleLabelId: titleLabelAccessibilityId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupUI()
        updateAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupUI()
        updateAppearance()
    }
    
    func setup(referenceId: Int, title: String, action: TabBarSegmentedButtonAction?) {
        self.referenceId = referenceId
        self.titleText = title
        self.action = action
    }
    
    func setAccessibilityIdentifier(id: String, titleLabelId: String) {
        self.accessibilityIdentifier = id
        self.titleLabel.accessibilityIdentifier = titleLabelId
    }
}

// MARK: - Action
extension TabBarSegmentedButton {
    @IBAction func segmentedButtonDidTapped(_ sender: Any) {
        action?(referenceId)
    }
}

// MARK: - Private
private extension TabBarSegmentedButton {
    func setupUI() {
        titleLabel.font = DSFont.h3
    }
    
    func updateAppearance() {
        containerView.backgroundColor = segmentedStateOfTheme.backgroundColor
        titleLabel.textColor = segmentedStateOfTheme.titleColor
    }
    
    func updateTitle() {
        self.titleLabel.text = titleText
    }
}
