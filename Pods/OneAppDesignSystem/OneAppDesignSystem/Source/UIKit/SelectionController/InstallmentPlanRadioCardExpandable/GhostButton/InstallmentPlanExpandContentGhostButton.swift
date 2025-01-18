//
//  InstallmentPlanExpandContentGhostButton.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/9/24.
//

import UIKit

class InstallmentPlanExpandContentGhostButton: UIView {
    @IBOutlet private weak var ghostButton: DSGhostButton!
    private var action: (() -> Void)?

    func setUp(_ viewModel: InstallmentPlanExpandContentGhostButtonViewModel?) {
        defer { isHidden = viewModel == nil }
        guard let viewModel else {
            return
        }
        action = viewModel.action
        ghostButton.setup(
            style: .ghost,
            size: .small,
            content: DSButtonContent(viewModel)
        )
    }

    @IBAction private func ghostButtonDidTap() {
        action?()
    }

    // MARK: - Initialize view
    public override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        instantiateView()
    }

    private func instantiateView() {
        let nib = UINib(nibName: "InstallmentPlanExpandContentGhostButton", bundle: .dsBundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else {
            fatalError("cannot instantiate InstallmentPlanExpandContentGhostButton")
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
}

struct InstallmentPlanExpandContentGhostButtonViewModel {
    let label: String
    let icon: InstallmentPlanExpandContentGhostButtonViewModel.Icon?
    let action: () -> Void

    init(
        label: String,
        icon: InstallmentPlanExpandContentGhostButtonViewModel.Icon?,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.icon = icon
        self.action = action
    }
}

extension InstallmentPlanExpandContentGhostButtonViewModel {
    enum Icon {
        case left(DSIcons)
        case right(DSIcons)
    }
}

fileprivate extension DSButtonContent {
    init(_ viewModel: InstallmentPlanExpandContentGhostButtonViewModel) {
        guard let icon = viewModel.icon else {
            self = .textOnlyNoPadding(text: viewModel.label)
            return
        }
        switch icon {
        case .left(let dsIcon):
            self = .iconLeftNoPaddingLeftAndRight(image: dsIcon.image, text: viewModel.label)
        case .right(let dsIcon):
            self = .iconRightNoPaddingLeftAndRight(image: dsIcon.image, text: viewModel.label)
        }
    }
}
