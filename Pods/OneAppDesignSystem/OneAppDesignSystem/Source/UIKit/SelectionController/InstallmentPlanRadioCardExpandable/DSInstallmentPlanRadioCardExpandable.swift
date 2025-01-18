//
//  DSInstallmentPlanRadioCardExpandable.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/9/24.
//

import UIKit

public class DSInstallmentPlanRadioCardExpandable: UIView {
    /// Get current state of the radio
    public var state: DSInstallmentPlanRadioCardExpandable.State {
        DSInstallmentPlanRadioCardExpandable.State(radioView.state)
    }

    /// Get current expand state of the radio
    public var expandState: DSInstallmentPlanRadioCardExpandable.ExpandState {
        DSInstallmentPlanRadioCardExpandable.ExpandState(radioView.expandState)
    }

    /// Get current selected pill index
    ///
    /// Return nil when don't have any selected pill
    public var selectedPillIndex: Int? {
        expandContentView.selectedPillIndex
    }

    public var selectedPill: DSInstallmentPlanRadioCardExpandableModel.PillRadio.Item? {
        expandContentView.selectedPill.map {
            DSInstallmentPlanRadioCardExpandableModel.PillRadio.Item($0)
        }
    }

    private lazy var radioView = {
        let view = RadioExpandableView()
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return view
    }()

    private lazy var expandContentView = {
        InstallmentPlanRadioCardExpandContentView()
    }()

    public func setUp(viewModel: DSInstallmentPlanRadioCardExpandableViewModel) {
        radioView.setUp(
            title: viewModel.model.title,
            state: RadioExpandableViewState(viewModel.model.state),
            expandState: RadioExpandableViewExpandState(viewModel.model.expandState),
            contentView: {
                expandContentView.setUp(
                    viewModel: InstallmentPlanRadioCardExpandContentViewModel(
                        pillGroup: InstallmentPlanExpandContentPillGroupViewModel(
                            viewModel.model.pillRadio,
                            onSelectPill: viewModel.onSelectPill
                        ),
                        remark: viewModel.model.remark.map { SelectionRemarkViewModel($0) },
                        ghostButton: viewModel.model.ghostButton.map {
                            InstallmentPlanExpandContentGhostButtonViewModel(
                                label: $0.label,
                                icon: InstallmentPlanExpandContentGhostButtonViewModel.Icon($0.icon),
                                action: viewModel.ghostButtonAction
                            )
                        }
                    )
                )
                return expandContentView
            }(),
            didTap: viewModel.onTapRadio
        )
    }

    /// Update the radio state
    ///
    /// - Parameter state: New radio state (`.default`, `.selected`, `.disabled`)
    public func update(state: DSInstallmentPlanRadioCardExpandable.State) {
        radioView.update(state: RadioExpandableViewState(state))
    }

    /// Update radio expand/collapse state
    ///
    /// - Parameters:
    ///   - expandState: New expand state (`.expanded`, `.collapsed`)
    ///   - animated: Specify `true` to animate transition when changing expand state. default is `false`
    public func update(
        expandState: DSInstallmentPlanRadioCardExpandable.ExpandState,
        animated: Bool = false
    ) {
        radioView.update(expandState: RadioExpandableViewExpandState(expandState), animated: animated)
    }

    /// Select pill by index
    ///
    /// - Parameter selectedPillIndex: Index of pill that want to be selected
    ///
    /// If the index is out of range, all pills will be unselected
    public func update(selectedPillIndex: Int) {
        expandContentView.update(selectedPillIndex: selectedPillIndex)
    }
    
    /// Set listMessage
    ///
    /// - Parameter listMessage: object of list message that want to show on view
    /// If `items` in `ListMessage` empty it not show section list message
    public func set(listMessage: DSInstallmentPlanRadioCardExpandableModel.ListMessage) {
        expandContentView.setUp(
            listMessage: InstallmentPlanExpandContentListMessageViewModel(listMessage)
        )
    }
}

public extension DSInstallmentPlanRadioCardExpandable {
    enum State: Equatable {
        case `default`
        case selected
        case disabled
    }

    enum ExpandState: Equatable {
        case expanded
        case collapsed
    }
}

fileprivate extension RadioExpandableViewState {
    init(_ state: DSInstallmentPlanRadioCardExpandable.State) {
        switch state {
        case .default: self = .default
        case .selected: self = .selected
        case .disabled: self = .disabled
        }
    }
}

fileprivate extension DSInstallmentPlanRadioCardExpandable.State {
    init(_ state: RadioExpandableViewState) {
        switch state {
        case .default: self = .default
        case .selected: self = .selected
        case .disabled: self = .disabled
        }
    }
}

fileprivate extension RadioExpandableViewExpandState {
    init(_ state: DSInstallmentPlanRadioCardExpandable.ExpandState) {
        switch state {
        case .collapsed: self = .collapsed
        case .expanded: self = .expanded
        }
    }
}

fileprivate extension DSInstallmentPlanRadioCardExpandable.ExpandState {
    init(_ state: RadioExpandableViewExpandState) {
        switch state {
        case .collapsed: self = .collapsed
        case .expanded: self = .expanded
        }
    }
}

fileprivate extension InstallmentPlanExpandContentPillGroupViewModel {
    init?(
        _ pillRadio: DSInstallmentPlanRadioCardExpandableModel.PillRadio?,
        onSelectPill: @escaping (DSInstallmentPlanRadioCardExpandableModel.PillRadio.Item) -> Void
    ) {
        guard let pillRadio = pillRadio else { return nil }
        
        self.init(
            title: pillRadio.title,
            items: pillRadio.items.enumerated().map { (index, item) in
                InstallmentPlanExpandContentPillGroupViewModel.Item(
                    label: item.label,
                    id: item.id,
                    isSelected: index == pillRadio.selectedIndex,
                    selectedPillIndex: index
                )
            },
            didSelect: { item in
                guard let selectedItem = pillRadio.items.first(where: { item.id == $0.id }) else {
                    return
                }
                onSelectPill(selectedItem)
            }
        )
    }
}

fileprivate extension SelectionRemarkViewModel {
    init(_ viewModel: DSInstallmentPlanRadioCardExpandableModel.Remark) {
        self.init(
            title: viewModel.title,
            isShowBullet: viewModel.isShowSymbol,
            bulletItems: viewModel.bullets
        )
    }
}

fileprivate extension InstallmentPlanExpandContentGhostButtonViewModel.Icon {
    init?(_ icon: DSInstallmentPlanRadioCardExpandableModel.GhostButton.Icon?) {
        guard let icon else { return nil }
        switch icon {
        case .left(let dsIcon): self = .left(dsIcon)
        case .right(let dsIcon): self = .right(dsIcon)
        }
    }
}

fileprivate extension DSInstallmentPlanRadioCardExpandableModel.PillRadio.Item {
    init(_ item: InstallmentPlanExpandContentPillGroupViewModel.Item) {
        self.init(
            id: item.id,
            label: item.label,
            selectedPillIndex: item.selectedPillIndex
        )
    }
}

fileprivate extension InstallmentPlanExpandContentListMessageViewModel {
    init(_ listMessage: DSInstallmentPlanRadioCardExpandableModel.ListMessage) {
        self.init(
            title: listMessage.title,
            description: listMessage.description,
            items: listMessage.items.map { InstallmentPlanExpandContentListMessageViewModel.Item($0) }
        )
    }
}

fileprivate extension InstallmentPlanExpandContentListMessageViewModel.Item {
    init(_ item: DSInstallmentPlanRadioCardExpandableModel.ListMessage.Item) {
        self.init(label: item.label, value: item.value, ratio: item.ratio)
    }
}
