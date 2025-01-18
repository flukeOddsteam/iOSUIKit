//
//  BottomSheetDropdownFilterViewController.swift
//  OneApp
//
//  Created by TTB on 22/11/2566 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import UIKit

private enum Constants {
    static let headerViewHeight: CGFloat = 56
    static let searchBarViewHeight: CGFloat = 48
    static let defaultTableViewHeight: CGFloat = 2000
}

public protocol DSBottomSheetDropdownFilterDelegate: AnyObject {
    func bottomSheet(_ viewController: UIViewController, didSelectAt index: Int)
    func bottomSheet(_ viewController: UIViewController, didDismiss isSelected: Bool)
    func bottomSheet(_ viewController: UIViewController, didFilter text: String, on item: ListActionIconViewModel) -> Bool
}

enum BottomSheetFilterListStyle {
    case listAction(viewModel: DSBottomSheetDropdownFilterViewModel?)
}

/**
 Custom component ClickableIcon
 
 **Usage Example:**
 1. Declare `DSBottomSheetDropdownFilter` and select style.
 2. Set up deletegate.
 3. Present pan modal `DSBottomSheetDropdown` that we defined.
 ```
 let style: BottomSheetFilterListStyle = .listAction(viewModel: DSBottomSheetDropdownFilterViewModel(
     title: "bottomSheetTitle",
     searchTextFieldPlaceholder: "placeholder",
     searchTextFieldTitleToolBar: "Done",
     leftIcon: leftIcon,
     selectedIndex: selectionIndex,
     listItem: itemList))
 let bottomSheet = DSBottomSheetDropdownFilter(style: style)
 bottomSheet.delegate = self
 navigationController?.presentPanModal(bottomSheet)
 ```
 **Current list of style:**
 - ListAction
 */
final class DSBottomSheetDropdownFilter: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var closeButton: DSClickableIconBadge!
    @IBOutlet weak var searchTextField: DSTextFieldSearch!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var emptyAndErrorState: DSEmptyAndErrorState!

    // MARK: - Private variable
    private var tableViewHeight: CGFloat = Constants.defaultTableViewHeight
    private var style: ListActionViewStyle!
    private var dataList: [(uniqId: Int, value: ListActionIconViewModel)] = []
    private var filteredDataList: [(uniqId: Int, value: ListActionIconViewModel)] = []
    private var emptyDataList: [(uniqId: Int, value: ListActionIconViewModel)] = []
    private var viewModel: DSBottomSheetDropdownFilterViewModel?
    private var didSelectedDropdown: Bool = false
    private var isDisplayMaxHeight: Bool = false
    
    // MARK: - Public
    /// Variable for set tag ID of DSBottomSheetDropdown
    public var tagId: String = ""
    
    /// Delegate of DSBottomSheetDropdown
    public weak var delegate: DSBottomSheetDropdownFilterDelegate?

    /// init DSBottomSheetDropdown by style
    init(style: BottomSheetFilterListStyle) {
        let nibname = String(describing: DSBottomSheetDropdownFilter.self)
        let bundle = Bundle(for: DSBottomSheetDropdownFilter.self)
        super.init(nibName: nibname, bundle: bundle)

        setupStyle(style: style)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
}

// MARK: - Action
extension DSBottomSheetDropdownFilter {
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - PanModalPresentable
extension DSBottomSheetDropdownFilter: PanModalPresentable {
    
    func panModalWillDismiss() {
        delegate?.bottomSheet(self, didDismiss: didSelectedDropdown)
    }
    
    var cornerRadius: CGFloat {
        return DSRadius.radius24px.rawValue
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var isUserInteractionEnabled: Bool {
        return true
    }
    
    var panScrollable: UIScrollView? {
        return tableView
    }
    
    var shortFormHeight: PanModalHeight {
        if isDisplayMaxHeight {
            return .maxHeight
        }
        return .contentHeight(tableViewHeight + Constants.headerViewHeight + Constants.searchBarViewHeight)
    }
    
    var longFormHeight: PanModalHeight {
        if isDisplayMaxHeight {
            return .maxHeight
        }
        return .contentHeight(tableViewHeight + Constants.headerViewHeight + Constants.searchBarViewHeight)
    }
    
    var anchorModalToLongForm: Bool {
        return true
    }
    
    var panModalBackgroundColor: UIColor {
        return DSColor.otherBackgroundOverlayScreen
    }
    
    var topOffset: CGFloat {
        return UIApplication.getStatusBarFrame().height + 16
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DSBottomSheetDropdownFilter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard filteredDataList.count > indexPath.row else {
            return UITableViewCell()
        }
        let viewModel = filteredDataList[indexPath.row].value
        let isShowBottomList: Bool = indexPath.row != filteredDataList.count - 1
        let cell: DSListActionIconTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let backgroundView = UIView()
        backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
        cell.selectedBackgroundView = backgroundView
        cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            dismiss(animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectedDropdown = true
        guard filteredDataList.count > indexPath.row,
              let index = dataList.firstIndex(where: { $0.uniqId == filteredDataList[indexPath.row].uniqId }) else {
            return
        }
        delegate?.bottomSheet(self, didSelectAt: index)
    }
}

// MARK: - UIScrollViewDelegate
extension DSBottomSheetDropdownFilter: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isHidden = scrollView.contentOffset.y <= 0
        textFieldView.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
}

// MARK: - Private
private extension DSBottomSheetDropdownFilter {
    func setupUI() {
        guard let viewModel = viewModel else { return }
        headerLabel.font = DSFont.h3
        headerLabel.textColor = DSColor.componentLightDefault
        headerLabel.text = viewModel.title
        headerLabel.numberOfLines = 0
        closeButton.setTitle("", for: .normal)
        closeButton.setup(style: .normal, image: SvgIcons.icon24Close.image)
        searchTextField.titleToolBar = viewModel.searchTextFieldTitleToolBar
        searchTextField.setup(
            text: "",
            state: .default,
            helperText: "",
            placeholder: viewModel.searchTextFieldPlaceholder)
        searchTextField.delegate = self

        emptyAndErrorState.setup(
            style: viewModel.emptyViewModel.style,
            description: viewModel.emptyViewModel.description,
            useOriginalImage: true
        )
        emptyAndErrorState.layoutSubviews()
    }

    func setupTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(DSListActionIconTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24))

        tableViewHeight = tableView.contentSize.height
        panModalSetNeedsLayoutUpdate()
    }

    func setupStyle(style: BottomSheetFilterListStyle) {
        switch style {
        case .listAction(let viewModel):
            guard let viewModel = viewModel else {
                return
            }
            let dataList: [(uniqId: Int, value: ListActionIconViewModel)] = mapListActionModel(listItem: viewModel.listItem, selectedIndex: viewModel.selectedIndex, leftIcon: viewModel.leftIcon)
            self.dataList = dataList
            self.filteredDataList = dataList
            self.viewModel = viewModel
            self.style = .listActionIcons(viewModels: dataList.map { $0.value })
            self.emptyDataList = mapEmptyListActionModel(listItem: viewModel.listItem, selectedIndex: viewModel.selectedIndex, leftIcon: viewModel.leftIcon)
            self.isDisplayMaxHeight = viewModel.isDisplayMaxHeight
        }
    }
    
    func mapListActionModel(listItem: [DSBottomSheetDropdownFilterViewModel.DSBottomSheetItem], selectedIndex: Int?, leftIcon: DSIcons?) -> [(uniqId: Int, value: ListActionIconViewModel)] {
        let dataList: [(uniqId: Int, value: ListActionIconViewModel)] = listItem.enumerated().map { index, item in
            let isSelected = index == selectedIndex
            let rightIcon: DSIcons? = isSelected ? .icon24OutlineCheck : nil
            return (uniqId: index, value: ListActionIconViewModel(text: item.title, leftIcon: leftIcon, rightIcon: rightIcon, hideRightIcon: .onlyIcon))}
        return dataList
    }
    
    func mapEmptyListActionModel(listItem: [DSBottomSheetDropdownFilterViewModel.DSBottomSheetItem], selectedIndex: Int?, leftIcon: DSIcons?) -> [(uniqId: Int, value: ListActionIconViewModel)] {
        var dataList: [(uniqId: Int, value: ListActionIconViewModel)] = []
        listItem.enumerated().forEach { index, item in
            let isSelected = index == selectedIndex
            let rightIcon: DSIcons? = isSelected ? .icon24OutlineCheck : nil
            if item.isEmptyItem {
                dataList.append((uniqId: index, value: ListActionIconViewModel(text: item.title, leftIcon: leftIcon, rightIcon: rightIcon, hideRightIcon: .onlyIcon)))
            }
        }
        return dataList
    }
}

extension DSBottomSheetDropdownFilter: DSTextFieldSearchDelegate {
    func textFieldDidChange(_ textField: DSTextFieldSearch) {
        guard let delegate = delegate else {
            return
        }
        filteredDataList = dataList.filter({
            delegate.bottomSheet(self, didFilter: textField.text, on: $0.value)
        })
        if !emptyDataList.isEmpty, filteredDataList.isEmpty {
            filteredDataList = emptyDataList
        }
        errorView.isHidden = filteredDataList.isNotEmpty
        tableView.reloadData()
    }
}
