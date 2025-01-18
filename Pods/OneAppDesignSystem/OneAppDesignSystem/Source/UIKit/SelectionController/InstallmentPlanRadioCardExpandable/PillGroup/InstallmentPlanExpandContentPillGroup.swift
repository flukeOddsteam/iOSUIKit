//
//  InstallmentPlanExpandContentPillGroup.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/9/24.
//

import UIKit

class InstallmentPlanExpandContentPillGroup: UIView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pillRadio: DSPillRadio!

    private var tagId = 0
    private var viewModel: InstallmentPlanExpandContentPillGroupViewModel?

    var selectedPillIndex: Int? {
        viewModel?.selectedIndex
    }

    var selectedPill: InstallmentPlanExpandContentPillGroupViewModel.Item? {
        viewModel?.selectedItem
    }

    func setUp(
        _ viewModel: InstallmentPlanExpandContentPillGroupViewModel?,
        tagId: Int
    ) {
        defer { isHidden = viewModel == nil }
        guard let viewModel else {
            return
        }
        self.tagId = tagId
        self.viewModel = viewModel
        updateAppearance()
    }

    private func updateAppearance() {
        guard let viewModel else { return }
        titleLabel.text = viewModel.title
        // Need this code to make the dequeued cell to use selected state from view model
        pillRadio.resetSelectedIndex()
        pillRadio.setup(
            tagId: tagId,
            viewModel: viewModel.items.map { DSPillRadioViewModel($0) },
            interitemSpacingForPill: 4
        )
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
            font: DSFont.h4,
            textColor: DSColor.componentLightDefault,
            numberOfLines: 0
        )
        pillRadio.delegate = self
    }

    private func instantiateView() {
        let nib = UINib(nibName: "InstallmentPlanExpandContentPillGroup", bundle: .dsBundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else {
            fatalError("cannot instantiate InstallmentPlanExpandContentPillGroup")
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

extension InstallmentPlanExpandContentPillGroup: DSPillRadioDelegate {
    func didSelectPillRadio(tagId: Int, index: Int) {
        update(selectedIndex: index)
        guard let viewModel, let selectedItem = viewModel.selectedItem else {
            return
        }
        viewModel.didSelect(selectedItem)
    }

    func update(selectedIndex: Int) {
        guard viewModel?.selectedIndex != selectedIndex else { return }
        guard let updatedViewModel = viewModel?.updated(selectedIndex: selectedIndex),
              updatedViewModel.selectedItem != nil else {
            return
        }
        viewModel = updatedViewModel
        updateAppearance()
    }
}

struct InstallmentPlanExpandContentPillGroupViewModel {
    let title: String
    let items: [InstallmentPlanExpandContentPillGroupViewModel.Item]
    let didSelect: (InstallmentPlanExpandContentPillGroupViewModel.Item) -> Void

    init(
        title: String,
        items: [InstallmentPlanExpandContentPillGroupViewModel.Item],
        didSelect: @escaping (InstallmentPlanExpandContentPillGroupViewModel.Item) -> Void
    ) {
        self.title = title
        self.items = items
        self.didSelect = didSelect
    }
}

extension InstallmentPlanExpandContentPillGroupViewModel {
    struct Item {
        let label: String
        let id: String
        let isSelected: Bool
        let selectedPillIndex: Int
    }

    var selectedIndex: Int? {
        items.enumerated().first { (_, item) in item.isSelected }.map { $0.0 }
    }

    var selectedItem: InstallmentPlanExpandContentPillGroupViewModel.Item? {
        items.first { $0.isSelected }
    }

    func updated(selectedIndex: Int) -> InstallmentPlanExpandContentPillGroupViewModel {
        InstallmentPlanExpandContentPillGroupViewModel(
            title: title,
            items: items.enumerated().map { (index, item) in
                item.updated(isSelected: index == selectedIndex)
            },
            didSelect: didSelect
        )
    }
}

extension InstallmentPlanExpandContentPillGroupViewModel.Item {
    func updated(isSelected: Bool) -> InstallmentPlanExpandContentPillGroupViewModel.Item {
        InstallmentPlanExpandContentPillGroupViewModel.Item(
            label: label,
            id: id,
            isSelected: isSelected,
            selectedPillIndex: selectedPillIndex
        )
    }
}

fileprivate extension DSPillRadioViewModel {
    init(_ item: InstallmentPlanExpandContentPillGroupViewModel.Item) {
        self.init(state: item.isSelected ? .selected : .default, title: item.label)
    }
}
