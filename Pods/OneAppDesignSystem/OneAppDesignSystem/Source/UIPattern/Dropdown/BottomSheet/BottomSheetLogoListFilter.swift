//
//  BottomSheetLogoListFilter.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/5/24.
//

import UIKit

final class BottomSheetLogoListFilter: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: DSClickableIconGeneralIcon!

    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchTextField: DSTextFieldSearch!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyContainerView: UIView!
    @IBOutlet weak var emptyView: DSEmptyAndErrorState!

    public weak var dataSource: BottomSheetLogoListFilterDataSource?
    public weak var delegate: BottomSheetLogoListFilterDelegate?

    private var viewAppearance: DSBottomSheetLogoListFilterViewAppearance!
    private var items = [BottomSheetLogoListFilterItem]()

    /// Private delegate wrapper to hidden UITableViewDelegate function
    /// inside the DSBottomSheetLogoListFilter
    private lazy var tableViewDelegateRepresentative = {
        TableViewDelegate(bottomSheet: self)
    }()

    /// Private dataSource wrapper to hidden UITableViewDataSource function
    /// inside the DSBottomSheetLogoListFilter
    private lazy var tableViewDataSourceRepresentative = {
        TableViewDataSource(bottomSheet: self)
    }()

    /// Private delegate wrapper to hidden LogoTableViewCellDelegate function
    /// inside the DSBottomSheetLogoListFilter
    private lazy var logoTableViewCellDelegateRepresentative = {
        LogoTableViewCellDelegateRepresentative(bottomSheet: self)
    }()

    /// Private delegate wrapper to hidden DSTextFieldSearchDelegate function
    /// inside the DSBottomSheetLogoListFilter
    private lazy var dsTextFieldSearchDelegateRepresentative = {
        TextFieldSearchDelegate(bottomSheet: self)
    }()

    convenience init(
        viewAppearance: DSBottomSheetLogoListFilterViewAppearance,
        dataSource: BottomSheetLogoListFilterDataSource?,
        delegate: BottomSheetLogoListFilterDelegate?
    ) {
        self.init(
            nibName: String(describing: BottomSheetLogoListFilter.self),
            bundle: Bundle(for: BottomSheetLogoListFilter.self)
        )
        self.viewAppearance = viewAppearance
        self.dataSource = dataSource
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAppearance()
        reloadData()
    }

    /// Reload data
    ///
    /// Call this to get the latest data from the dataSource
    func reloadData() {
        reload(
            items: searchTextField.text.isEmpty
            ? dataSource?.items(for: self)
            : dataSource?.items(for: self, filter: searchTextField.text)
        )
    }

    private func setUpAppearance() {
        guard let viewAppearance = viewAppearance else { return }
        setUp(title: viewAppearance.title)
        searchTextField.setUp(viewModel: viewAppearance.searchTextField)
        searchTextField.delegate = dsTextFieldSearchDelegateRepresentative
        closeButton.setup(
            viewModel: DSClickableIconGeneralIconViewModel(
                tagId: 0,
                state: .active,
                theme: .light,
                size: .medium,
                imageType: .image(DSIcons.icon24OutlineClose.image),
                isBadged: false
            ),
            action: { [weak self] _ in
                self?.dismiss(animated: true)
            }
        )
        emptyView.setup(
            style: viewAppearance.emptyView.style,
            description: viewAppearance.emptyView.description,
            useOriginalImage: true
        )
        setUpTableView()
    }

    private func setUp(title: String) {
        titleLabel.setUp(font: DSFont.h3, textColor: DSColor.componentLightDefault)
        titleLabel.text = title
    }

    private func setUpTableView() {
        tableView.register(HeaderTableViewCell.self)
        tableView.register(DividerTableViewCell.self)
        tableView.register(LogoTableViewCell.self)
        tableView.register(DSListActionIconTableViewCell.self)

        tableView.delegate = tableViewDelegateRepresentative
        tableView.dataSource = tableViewDataSourceRepresentative
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 8))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24))
    }

    private func reload(items: [BottomSheetLogoListFilterItem]?) {
        self.items = items ?? []
        tableView.reloadData()
        emptyContainerView.isHidden = !self.items.isEmpty
    }
}

extension BottomSheetLogoListFilter {

    /// Private class for UITableViewDelegate conformance
    ///
    /// Use to hide UITableViewDelegate functionalily inside BottomSheetLogoListFilter
    private class TableViewDelegate: NSObject, UITableViewDelegate {
        weak var bottomSheet: BottomSheetLogoListFilter?

        init(bottomSheet: BottomSheetLogoListFilter? = nil) {
            self.bottomSheet = bottomSheet
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let bottomSheet else { return }
            guard case let .action(item) = bottomSheet.items[indexPath.row] else {
                return
            }
            bottomSheet.delegate?.bottomSheet(bottomSheet, didSelect: item)
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard let bottomSheet else { return }
            bottomSheet.searchContainerView.dsShadowDrop(
                isHidden: scrollView.contentOffset.y <= 0,
                style: .bottom
            )
        }
    }

    /// Private class for UITableViewDataSource conformance
    ///
    /// Use to hide UITableViewDataSource functionalily inside DSBottomSheetLogoListFilter
    private class TableViewDataSource: NSObject, UITableViewDataSource {
        weak var bottomSheet: BottomSheetLogoListFilter?

        init(bottomSheet: BottomSheetLogoListFilter? = nil) {
            self.bottomSheet = bottomSheet
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let bottomSheet else { return 0 }
            return bottomSheet.items.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let bottomSheet else { return UITableViewCell() }
            switch bottomSheet.items[indexPath.row] {
            case let .header(text):
                let cell: HeaderTableViewCell = tableView.dequeueReusableCell(
                    forIndexPath: indexPath
                )
                cell.configure(title: text)
                return cell
            case .divider:
                let cell: DividerTableViewCell = tableView.dequeueReusableCell(
                    forIndexPath: indexPath
                )
                return cell
            case let .logo(items):
                let cell: LogoTableViewCell = tableView.dequeueReusableCell(
                    forIndexPath: indexPath
                )
                cell.configure(items: items, delegate: bottomSheet.logoTableViewCellDelegateRepresentative)
                return cell
            case let .action(item):
                let cell: DSListActionIconTableViewCell = tableView.dequeueReusableCell(
                    forIndexPath: indexPath
                )
                cell.configure(
                    viewModel: ListActionIconViewModel(
                        text: item.label,
                        textStyle: .paragraphMedium,
                        rightIcon: item.isSelected ? .icon24OutlineCheck : nil
                    ),
                    isShowBottomLine: true
                )
                let backgroundView = UIView()
                backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
                cell.selectedBackgroundView = backgroundView
                return cell
            }
        }
    }

    /// Private class for LogoTableViewCellDelegate conformance
    ///
    /// Use to hide LogoTableViewCellDelegate functionalily inside BottomSheetLogoListFilter
    private class LogoTableViewCellDelegateRepresentative: LogoTableViewCellDelegate {
        weak var bottomSheet: BottomSheetLogoListFilter?

        init(bottomSheet: BottomSheetLogoListFilter? = nil) {
            self.bottomSheet = bottomSheet
        }

        func logoTableViewCell(
            _ view: UITableViewCell,
            didSelect item: DSBottomSheetLogoListFilterItemLogoDisplayable
        ) {
            guard let bottomSheet else { return }
            bottomSheet.delegate?.bottomSheet(bottomSheet, didSelect: item)
        }
    }

    /// Private class for DSTextFieldSearchDelegate conformance
    ///
    /// Use to hide DSTextFieldSearchDelegate functionalily inside BottomSheetLogoListFilter
    private class TextFieldSearchDelegate: DSTextFieldSearchDelegate {
        weak var bottomSheet: BottomSheetLogoListFilter?

        init(bottomSheet: BottomSheetLogoListFilter? = nil) {
            self.bottomSheet = bottomSheet
        }

        func textFieldDidChange(_ textField: DSTextFieldSearch) {
            guard let bottomSheet else { return }
            bottomSheet.reload(
                items: bottomSheet.dataSource?.items(for: bottomSheet, filter: textField.text)
            )
        }
    }
}
