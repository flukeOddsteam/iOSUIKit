//
//  TabbarSegmentedView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/9/2565 BE.
//

import UIKit

private enum Constants {
    static let containerBorderWidth: CGFloat = 1
    static let stackViewSpcaing: CGFloat = 1
}

protocol TabBarSegmentedViewDelegate: AnyObject {
    func tabBarSegmentedView(_ view: TabBarSegmentedView, didSelectAtIndex index: Int)
}

final class TabBarSegmentedView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Public variable
    weak var delegate: TabBarSegmentedViewDelegate?
    
    // MARK: - Private variable
    private var selectedIndex: Int = .zero {
        didSet {
            updateSegmentButtonState()
        }
    }
    
    // Variable for set theme TabBarSegmentedView
    private var theme: DSTabBarTheme = .light
    
    // Variable for set accessibility identifier
    private var prefixTabBarSegmentedId: String = ""
    private var prefixTabBarSegmentedLabelId: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupUI()
    }
    
    func setup(titleButtons: [String], theme: DSTabBarTheme = .light) {
        self.theme = theme
        setupViews(titleButtons: titleButtons)
        updateSegmentButtonState()
    }
    
    func clearLayout() {
        stackView.removeAllSubviews()
        selectedIndex = .zero
    }

    func preSelected(at index: Int) {
        guard let index = getIndexOfSegmentButtonView(with: index) else { return }
        selectedIndex = index
    }

    func setAccessibilityIdentifier(prefixTabBarSegmentedId: String,
                                    prefixTabBarSegmentedLabelId: String) {
        self.prefixTabBarSegmentedId = prefixTabBarSegmentedId
        self.prefixTabBarSegmentedLabelId = prefixTabBarSegmentedLabelId
    }
}

// MARK: - Action
extension TabBarSegmentedView {
    func segmentButtonDidTapped(referenceId: Int) {
        guard let index = getIndexOfSegmentButtonView(with: referenceId),
              selectedIndex != index else { return }
        
        selectedIndex = index
        delegate?.tabBarSegmentedView(self, didSelectAtIndex: index)
    }
}

// MARK: - Private
private extension TabBarSegmentedView {
    func setupUI() {
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.layer.borderWidth = Constants.containerBorderWidth
        containerView.layer.borderColor = DSColor.componentLightOutlineSecondary.cgColor
        containerView.backgroundColor = DSColor.componentLightOutlineClickable
        stackView.spacing = Constants.stackViewSpcaing
        stackView.distribution = .fillEqually
    }
    
    func setupViews(titleButtons: [String]) {
        stackView.removeAllSubviews()
        
        let views = titleButtons.enumerated().map {
            TabBarSegmentedButton(
                referenceId: $0.offset,
                title: $0.element,
                action: { referenceId in
                    self.segmentButtonDidTapped(referenceId: referenceId)
                },
                viewAccessibilityId: self.prefixTabBarSegmentedId.idConcatenation(String($0.offset)),
                titleLabelAccessibilityId: self.prefixTabBarSegmentedLabelId.idConcatenation(String($0.offset))
            )
        }
        
        stackView.addArrangedSubviews(views)
    }

    func getIndexOfSegmentButtonView(with referenceId: Int) -> Int? {
        return stackView.arrangedSubviews.firstIndex {
            let view = $0 as? TabBarSegmentedButton
            return view?.referenceId == referenceId
        }
    }

    func updateSegmentButtonState() {
        stackView.arrangedSubviews.enumerated().forEach { offset, view in
            let segmentedButtonView = view as? TabBarSegmentedButton
            let state: TabBarSegmentedButtonState = offset == selectedIndex ? .highlighted : .default
            
            switch theme {
            case .light:
                segmentedButtonView?.segmentedStateOfTheme = .light(state)
            case .dark:
                segmentedButtonView?.segmentedStateOfTheme = .dark(state)
            }
        }
    }
}
