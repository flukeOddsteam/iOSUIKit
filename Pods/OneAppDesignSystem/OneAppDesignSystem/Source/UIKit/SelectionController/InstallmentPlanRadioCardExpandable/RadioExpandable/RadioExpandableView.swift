//
//  RadioExpandableView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/8/24.
//

import UIKit

class RadioExpandableView: UIView {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!

    /// Selection view for trigger `didSelect` callback
    @IBOutlet private weak var selectionView: UIView!
    @IBOutlet private weak var radioView: RadioView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var expandIconView: UIView!
    @IBOutlet private weak var expandIconImageView: UIImageView!

    /// Container view for expand/collapse content
    @IBOutlet private weak var expandableView: UIView!

    private var didTap: (() -> Void)?

    private(set) var state: RadioExpandableViewState = .default
    private(set) var expandState: RadioExpandableViewExpandState = .collapsed
    private var contentView: UIView?

    func setUp(
        title: String,
        state: RadioExpandableViewState,
        expandState: RadioExpandableViewExpandState,
        contentView: @autoclosure () -> UIView,
        didTap: (() -> Void)? = nil
    ) {
        defer {
            self.state = state
            self.expandState = expandState
            self.didTap = didTap
        }
        titleLabel.text = title

        setUpExpandableView(with: contentView())
        updateExpandableView(expandState, animated: false)
        updateSelectionAppearance(state)
    }

    func update(state: RadioExpandableViewState) {
        defer { self.state = state }
        updateSelectionAppearance(state)
    }

    func update(expandState: RadioExpandableViewExpandState, animated: Bool) {
        defer { self.expandState = expandState }
        updateExpandableView(expandState, animated: animated)
    }

    private func setUpExpandableView(with view: UIView) {
        guard contentView != view else { return }
        defer { contentView = view }
        contentView?.removeFromSuperview()
        expandableView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: expandableView.topAnchor),
            view.trailingAnchor.constraint(equalTo: expandableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: expandableView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: expandableView.leadingAnchor)
        ])
    }

    private func updateExpandableView(
        _ newExpandState: RadioExpandableViewExpandState,
        animated: Bool
    ) {
        expandIconImageView.setUp(newExpandState)

        guard expandableView.isHidden != newExpandState.isHidden else { return }
        if animated {
            UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { [weak self] in
                guard let self else { return }
                self.expandableView.isHidden = newExpandState.isHidden
                self.stackView.layoutIfNeeded()
            }
            .startAnimation()
        } else {
            expandableView.isHidden = newExpandState.isHidden
            stackView.layoutIfNeeded()
        }
    }

    private func updateSelectionAppearance(_ newState: RadioExpandableViewState) {
        radioView.state = DSSelectionRadioState(newState)
        // Prevent animation bug for shadow by apply shadow only when isUserInteractonEnabled changed
        if state.isUserInteractonEnabled != newState.isUserInteractonEnabled {
            containerView.dsShadowDrop(isHidden: !newState.isUserInteractonEnabled, style: .bottom)
        }
        containerView.layer.borderWidth = newState.borderWidth
        containerView.layer.borderColor = newState.borderColor
    }

    // MARK: - Initialize view
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    private func setUp() {
        instantiateView()

        titleLabel.setUp(
            font: DSFont.labelList,
            textColor: DSColor.componentLightDefault,
            numberOfLines: 0
        )
        
        expandIconImageView.tintAdjustmentMode = .normal

        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = DSColor.componentLightBackground
        containerView.dsShadowDrop(isHidden: !state.isUserInteractonEnabled, style: .bottom)
        expandableView.backgroundColor = DSColor.componentLightBackgroundOnPress
        expandableView.layer.cornerRadius = 12
        expandableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        selectionView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(selectionAreaDidTap)
            )
        )

        expandIconView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(expandAreaDidTap)
            )
        )
    }

    private func instantiateView() {
        let nib = UINib(nibName: "RadioExpandableView", bundle: .dsBundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else {
            fatalError("cannot instantiate RadioExpandableView")
        }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func selectionAreaDidTap() {
        guard state.isUserInteractonEnabled else {
            return
        }
        didTap?()
    }

    @objc private func expandAreaDidTap() {
        update(expandState: expandState.toggled(), animated: true)
    }
}

enum RadioExpandableViewState: Equatable {
    case `default`
    case selected
    case disabled
}

enum RadioExpandableViewExpandState {
    case expanded
    case collapsed
}

fileprivate extension RadioExpandableViewState {
    var isUserInteractonEnabled: Bool {
        self != .disabled
    }

    var borderWidth: CGFloat {
        switch self {
        case .default, .disabled: return 1
        case .selected: return 2
        }
    }

    var borderColor: CGColor? {
        switch self {
        case .default, .disabled: return DSColor.componentLightOutlinePrimary.cgColor
        case .selected: return DSColor.componentLightOutlineActive.cgColor
        }
    }
}

fileprivate extension RadioExpandableViewExpandState {
    func toggled() -> RadioExpandableViewExpandState {
        switch self {
        case .expanded: return .collapsed
        case .collapsed: return .expanded
        }
    }

    var isHidden: Bool {
        self == .collapsed
    }
}

fileprivate extension UIImageView {
    func setUp(_ state: RadioExpandableViewExpandState) {
        switch state {
        case .expanded: image = DSIcons.icon24OutlineChevronUp.image
        case .collapsed: image = DSIcons.icon24OutlineChevronDown.image
        }
    }
}

fileprivate extension DSSelectionRadioState {
    init(_ state: RadioExpandableViewState) {
        switch state {
        case .default: self = .default
        case .selected: self = .selected
        case .disabled: self = .disableUnselected
        }
    }
}
