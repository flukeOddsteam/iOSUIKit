//
//  DSDropdownBottomSheetLogoListFilter.swift
//  OneAppDesignSystem
//
//  Created by TTB on 30/4/24.
//

import UIKit

public final class DSDropdownBottomSheetLogoListFilter: UIView {
    @IBOutlet private weak var dropdownView: DSDropdown!

    public weak var dataSource: DSDropdownBottomSheetLogoListFilterDataSource?
    public weak var delegate: DSDropdownBottomSheetLogoListFilterDelegate?

    /// tagId for identifying component.
    /// Should have different value for each component on the screen
    public private(set) var tagId = 0

    /// Current state of the component
    ///
    /// To change the dropdown state,
    /// use ``DSDropdownBottomSheetLogoListFilter/updateLayout(state:isAnimate:)``
    public private(set) var state: DSDropdownBottomSheetLogoListFilterState?

    private var viewModel: DSDropdownBottomSheetLogoListFilterViewModel?

    /// Store the state before changing into focus state
    /// - Tag: stateBeforeFocus
    ///
    /// When calling ``DSDropdownBottomSheetLogoListFilter/presentBottomSheetDropdown()``,
    /// dropdown will change the appearance automatically by changing the state to `.focus`.
    /// This variable is using with `isDirty` to restore the previous state
    /// when perform select the item on the bottom sheet or
    /// dismiss the bottom sheet without perform the select action.
    private var stateBeforeFocus: DSDropdownBottomSheetLogoListFilterState?

    /// Indicating if some dropdown items was selected
    private var isDirty = false

    /// Private delegate wrapper to hidden DSDropdownDelegate function
    /// inside the DSDropdownBottomSheetLogoListFilter
    private lazy var dsDropdownDelegateRepresentative = {
        DropdownDelegate(dropdown: self)
    }()

    /// Private delegate wrapper to hidden DSBottomSheetLogoListFilterDelegate function
    /// inside the DSDropdownBottomSheetLogoListFilter
    private lazy var dsBottomSheetLogoListFilterDelegateRepresentative = {
        BottomSheetLogoListFilterDelegateRepresentative(dropdown: self)
    }()

    /// Private dataSource wrapper to hidden DSBottomSheetLogoListFilterDataSource function
    /// inside the DSDropdownBottomSheetLogoListFilter
    private lazy var dsBottomSheetLogoListFilterDataSourceRepresentative = {
        BottomSheetLogoListFilterDataSourceRepresentative(dropdown: self)
    }()

    /// Set up the appearance and state
    public func setUp(
        viewModel: DSDropdownBottomSheetLogoListFilterViewModel,
        dataSource: DSDropdownBottomSheetLogoListFilterDataSource?,
        delegate: DSDropdownBottomSheetLogoListFilterDelegate?
    ) {
        self.viewModel = viewModel
        self.dataSource = dataSource
        self.delegate = delegate
        self.tagId = viewModel.tagId
        self.state = viewModel.state

        dropdownView.delegate = dsDropdownDelegateRepresentative
        dropdownView.titleText = viewModel.title
        dropdownView.textLabel.text = viewModel.text
        dropdownView.isAutoDisplay = false
        if let helperText = viewModel.helperText {
            dropdownView.helperText = helperText
        }
        dropdownView.updateLayout(state: DSDropdownState(viewModel.state))
    }

    /// Set the dropdown selection text
    public func set(text: String) {
        dropdownView.textLabel.text = text
    }

    /// Use for changing the dropdown state
    ///
    /// When changing to ``DSDropdownBottomSheetLogoListFilterState/focus`` state, 
    /// store the current state for restoring when select or dismiss the bottom sheet.
    /// See [stateBeforeFocus](x-source-tag://stateBeforeFocus), `isDirty`, 
    /// and ``DSDropdownBottomSheetLogoListFilter/presentBottomSheetDropdown()`` for more detail
    public func updateLayout(
        state: DSDropdownBottomSheetLogoListFilterState,
        isAnimate: Bool = true
    ) {
        defer { self.state = state }
        guard case .focus = state else {
            dropdownView.updateLayout(state: DSDropdownState(state), isAnimate: isAnimate)
            return
        }
        stateBeforeFocus = self.state
        dropdownView.setFocusState()
    }

    /// Present dropdown bottom sheet for item selection
    ///
    /// When calling this method, dropdown will ask dataSource to provide selection item.
    /// If the dataSource return `nil` or don't have any items to select,
    /// dropdown will not open the bottom sheet.
    ///
    /// State will change to ``DSDropdownBottomSheetLogoListFilterState/focus``
    /// to update its appearance
    public func presentBottomSheetDropdown() {
        guard let viewModel,
              let window = UIApplication.getWindow(),
              let controller = window.rootViewController as? UINavigationController,
              let data = dataSource?.data(
                for: self, filter: viewModel.bottomSheet.searchTextField.text
              ),
              data.bottomSheetLogoListFilterItems(
                withHeader: viewModel.bottomSheet.searchTextField.text.isEmpty
              )
              .isNotEmpty
        else {
            return
        }
        isDirty = false
        updateLayout(state: .focus)
        controller.presentPanModal(
            BottomSheetLogoListFilter(
                viewAppearance: DSBottomSheetLogoListFilterViewAppearance(
                    title: viewModel.bottomSheet.title,
                    searchTextField: viewModel.bottomSheet.searchTextField,
                    emptyView: viewModel.bottomSheet.emptyView
                ),
                dataSource: dsBottomSheetLogoListFilterDataSourceRepresentative,
                delegate: dsBottomSheetLogoListFilterDelegateRepresentative
            )
        )
    }

    // MARK: - Initialize view
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        instantiateView()
    }

    private func instantiateView() {
        let nib = UINib(nibName: "DSDropdownBottomSheetLogoListFilter", bundle: .dsBundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else {
            fatalError("cannot instantiate DSDropdownBottomSheetLogoListFilter")
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

extension DSDropdownBottomSheetLogoListFilter {

    /// Private class for DSDropdownDelegate conformance
    ///
    /// Use to hide DSDropdownDelegate functionalily inside DSDropdownBottomSheetLogoListFilter
    private class DropdownDelegate: DSDropdownDelegate {
        weak var dropdown: DSDropdownBottomSheetLogoListFilter?

        init(dropdown: DSDropdownBottomSheetLogoListFilter? = nil) {
            self.dropdown = dropdown
        }

        func dropdown(_ view: DSDropdown, didSelectAt index: Int, withTagId id: Int) {
            /* Not implement */
        }

        func dropdownDidTapped(_ view: DSDropdown, withTagId id: Int) {
            guard let dropdown else { return }
            dropdown.delegate?.dropdownDidTap(dropdown)
        }

        func dropdownDidCancel(_ view: DSDropdown, withTagId id: Int) {
            /* Not implement */
        }
    }

    /// Private class for BottomSheetLogoListFilterDelegate conformance
    ///
    /// Use to hide BottomSheetLogoListFilterDelegate functionalily
    /// inside DSDropdownBottomSheetLogoListFilter
    private class BottomSheetLogoListFilterDelegateRepresentative: BottomSheetLogoListFilterDelegate {
        weak var dropdown: DSDropdownBottomSheetLogoListFilter?

        init(dropdown: DSDropdownBottomSheetLogoListFilter? = nil) {
            self.dropdown = dropdown
        }

        func bottomSheetWillDismiss(_ viewController: BottomSheetLogoListFilter) {
            guard let dropdown else { return }
            if !dropdown.isDirty, let stateBeforeFocus = dropdown.stateBeforeFocus {
                dropdown.updateLayout(state: stateBeforeFocus)
            }
            dropdown.delegate?.dropdownWillDismiss(dropdown)
        }

        func bottomSheetDidDismiss(_ viewController: BottomSheetLogoListFilter) {
            guard let dropdown else { return }
            dropdown.delegate?.dropdownDidDismiss(dropdown)
        }

        func bottomSheet(
            _ viewController: BottomSheetLogoListFilter,
            didSelect item: DSBottomSheetLogoListFilterItemLabelDisplayable
        ) {
            guard let dropdown else { return }
            if let stateBeforeFocus = dropdown.stateBeforeFocus {
                dropdown.updateLayout(state: stateBeforeFocus)
            }
            dropdown.isDirty = true
            dropdown.delegate?.dropdown(dropdown, didSelect: item)
            viewController.dismiss(animated: true)
        }
    }

    /// Private class for BottomSheetLogoListFilterDataSource conformance
    ///
    /// Use to hide BottomSheetLogoListFilterDataSource functionalily
    /// inside DSDropdownBottomSheetLogoListFilter
    private class BottomSheetLogoListFilterDataSourceRepresentative: BottomSheetLogoListFilterDataSource {
        weak var dropdown: DSDropdownBottomSheetLogoListFilter?

        init(dropdown: DSDropdownBottomSheetLogoListFilter? = nil) {
            self.dropdown = dropdown
        }

        func items(
            for bottomSheet: BottomSheetLogoListFilter
        ) -> [BottomSheetLogoListFilterItem] {
            guard let dropdown,
                  let dataSource = dropdown.dataSource,
                  let items = dataSource.data(
                    for: dropdown,
                    filter: ""
                  )?
                  .bottomSheetLogoListFilterItems(withHeader: true)
            else {
                return []
            }
            return items
        }

        func items(
            for bottomSheet: BottomSheetLogoListFilter,
            filter text: String
        ) -> [BottomSheetLogoListFilterItem] {
            guard let dropdown,
                  let dataSource = dropdown.dataSource,
                  let items = dataSource.data(
                    for: dropdown,
                    filter: text
                  )?
                  .bottomSheetLogoListFilterItems(withHeader: false)
            else {
                return []
            }
            return items
        }
    }
}

extension DSDropdownBottomSheetLogoListFilterData {

    /// Make BottomSheetLogoListFilterItem for display on the BottomSheetLogoListFilter
    ///
    /// - Parameter withHeader: `true` if want to create ``BottomSheetLogoListFilterItem/header(text:)`` item.
    func bottomSheetLogoListFilterItems(withHeader: Bool) -> [BottomSheetLogoListFilterItem] {
        let result = Array(
            [
                makeLogoSectionItem(withHeader: withHeader),
                makeListSectionItem(withHeader: withHeader)
            ]
            .reduce(into: [[BottomSheetLogoListFilterItem]]()) { partialResult, list in
                guard !list.isEmpty else { return }
                partialResult += [list]
            }
            .joined(separator: [.divider])
        )
        return result
    }

    func makeLogoSectionItem(
        withHeader: Bool
    ) -> [BottomSheetLogoListFilterItem] {
        guard let logoSection, logoSection.items.count > 0 else {
            return []
        }
        let items = [BottomSheetLogoListFilterItem.logo(items: logoSection.items)]
        guard withHeader else {
            return items
        }
        return [.header(text: logoSection.title)] + items
    }

    func makeListSectionItem(
        withHeader: Bool
    ) -> [BottomSheetLogoListFilterItem] {
        guard let listSection, listSection.items.count > 0 else {
            return []
        }
        let items = listSection.items.map { BottomSheetLogoListFilterItem.action(item: $0) }
        guard withHeader else {
            return items
        }
        return [.header(text: listSection.title)] + items
    }
}

extension DSDropdownState {

    /// Initial DSDropdownState using ``DSDropdownBottomSheetLogoListFilterState``
    init(_ state: DSDropdownBottomSheetLogoListFilterState) {
        switch state {
        case .idle: self = .idle
        case .focus: self = .focus
        case .selected: self = .selected
        case .error(let message): self = .error(errorMessage: message)
        case .disable: self = .disable
        }
    }
}
