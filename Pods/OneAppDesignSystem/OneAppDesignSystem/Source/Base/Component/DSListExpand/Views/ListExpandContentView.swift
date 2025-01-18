//
//  ListExpandContentView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/3/2566 BE.
//

import UIKit

private enum Constants {
    static let animationTimeInterval: TimeInterval = 0.2
}

protocol ListExpandContentViewDelegate: AnyObject {
    func listExpandContentView(_ view: ListExpandContentView, didSelectExpand state: DSListExpandContentState)
}

protocol HeaderViewModel: UIView {
    func setup(viewModel: DSListExpandViewModel)
    func setDelegate(_ delegate: AnyObject)
    func updateStateRightIconImage(_ image: UIImage)
}

final class ListExpandContentView: UIView {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var dividerView: UIView!
    
    private let spotHeaderView = SpotHeaderView()
    private let iconHeaderView = IconHeaderView()

    private var state: DSListExpandContentState = .collapse

    weak var delegate: ListExpandContentViewDelegate?
    
    var isAnimated: Bool = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(
        viewModel: DSListExpandViewModel,
        contentView: UIView,
        isAnimated: Bool,
        delegate: ListExpandContentViewDelegate
    ) {
        self.isAnimated = isAnimated
        self.delegate = delegate
        
        dividerView.isHidden = !viewModel.isDisplayDivider
        
        validateSetupHeaderView(viewModel: viewModel)
        setupContentView(view: contentView)

        setExpandState(
            viewModel.state,
            animate: false
        )
    }

    func setExpandState(
        _ state: DSListExpandContentState,
        animate: Bool
    ) {
        self.state = state
        updateExpandState(animated: animate)
    }
}

// MARK: - Private
private extension ListExpandContentView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        dividerView.backgroundColor = DSColor.componentDividerBackgroundBig
    }
    
    func setupContentView(view: UIView) {
        setupConstraint(parent: contentContainerView, childView: view)
    }
    
    func validateSetupHeaderView(viewModel: DSListExpandViewModel) {
        switch viewModel.type {
        case .icon:
            setupHeaderView(iconHeaderView, viewModel: viewModel)
        case .spot:
            setupHeaderView(spotHeaderView, viewModel: viewModel)
        }
    }
    
    func setupHeaderView(_ view: UIView, viewModel: DSListExpandViewModel) {
        if let view = view as? HeaderViewModel {
            view.setup(viewModel: viewModel)
            view.setDelegate(self)
            setupConstraint(parent: headerContainerView, childView: view)
        }
    }
    
    func setupConstraint(parent: UIView, childView: UIView) {
        parent.addSubview(childView)
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: parent.topAnchor),
            childView.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            childView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
        ])
    }
    
    func updateExpandState(animated: Bool) {
        updateHeaderState()
        
        let isCollapse = self.state == .collapse
        if animated {
            UIView.animate(
                withDuration: Constants.animationTimeInterval,
                delay: .zero,
                options: .curveLinear,
                animations: {
                    self.contentContainerView.isHidden = isCollapse
                    self.contentContainerView.alpha = isCollapse ? .zero : 1
                    self.contentContainerView.layoutIfNeeded()
                },
                completion: nil
            )
        } else {
            self.contentContainerView.isHidden = isCollapse
        }
    }
    
    func updateHeaderState() {
        headerContainerView.subviews.forEach { view in
            if let view = view as? HeaderViewModel {
                view.updateStateRightIconImage(state.iconImage)
            }
        }
    }
}

extension ListExpandContentView: SpotHeaderViewDelegate {
    func didTapped(_ view: SpotHeaderView) {
        setExpandState(
            state.inverse,
            animate: isAnimated
        )

        delegate?.listExpandContentView(self, didSelectExpand: state)
    }
}

extension ListExpandContentView: IconHeaderViewDelegate {
    func didTapped(_ view: IconHeaderView) {
        setExpandState(
            state.inverse,
            animate: isAnimated
        )

        delegate?.listExpandContentView(self, didSelectExpand: state)
    }
}
