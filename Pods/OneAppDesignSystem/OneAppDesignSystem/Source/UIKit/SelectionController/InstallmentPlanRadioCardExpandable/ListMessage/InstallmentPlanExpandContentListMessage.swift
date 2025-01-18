//
//  InstallmentPlanExpandContentListMessage.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/9/24.
//

import UIKit

class InstallmentPlanExpandContentListMessage: UIView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!

    func setUp(_ viewModel: InstallmentPlanExpandContentListMessageViewModel?) {
        guard let viewModel, viewModel.items.count != 0 else {
            isHidden = true
            return
        }
        titleLabel.set(text: viewModel.title)
        descriptionLabel.set(text: viewModel.description)
        stackView.setUp(viewModel.items)
        isHidden = false
    }

    // MARK: - Initialize view
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    private func setUpView() {
        instantiateView()
        titleLabel.setUp(
            font: DSFont.labelList,
            textColor: DSColor.componentLightDefault,
            numberOfLines: 0
        )
        descriptionLabel.setUp(
            font: DSFont.labelInput,
            textColor: DSColor.componentLightDesc,
            numberOfLines: 0
        )
    }

    private func instantiateView() {
        let nib = UINib(nibName: "InstallmentPlanExpandContentListMessage", bundle: .dsBundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else {
            fatalError("cannot instantiate InstallmentPlanExpandContentListMessage")
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

struct InstallmentPlanExpandContentListMessageViewModel {
    let title: String?
    let description: String?
    let items: [InstallmentPlanExpandContentListMessageViewModel.Item]
}

extension InstallmentPlanExpandContentListMessageViewModel {
    struct Item {
        let label: String
        let value: String
        let ratio: CGFloat

        init(label: String, value: String, ratio: CGFloat = 1) {
            self.label = label
            self.value = value
            self.ratio = ratio
        }
    }
}

fileprivate extension UILabel {
    func set(text: String?) {
        self.text = text
        self.isHidden = text == nil
    }
}

fileprivate extension UIStackView {
    func setUp(_ items: [InstallmentPlanExpandContentListMessageViewModel.Item]) {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        items
            .map { DSListMessage(DSListMessageViewModel($0), $0.ratio) }
            .forEach { addArrangedSubview($0) }
    }
}

fileprivate extension DSListMessage {
    convenience init(_ item: DSListMessageViewModel, _ ratio: CGFloat) {
        self.init()
        setup(
            type: .small(
                viewModel: item
            )
        )
        self.ratio = ratio
    }
}

fileprivate extension DSListMessageViewModel {
    init(_ item: InstallmentPlanExpandContentListMessageViewModel.Item) {
        self.init(style: .horizontal, label: item.label, value: item.value)
    }
}
