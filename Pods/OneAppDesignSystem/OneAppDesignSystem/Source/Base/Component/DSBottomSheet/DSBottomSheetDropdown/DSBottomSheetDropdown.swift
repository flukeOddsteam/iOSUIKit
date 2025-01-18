//
//  BottomSheetDropdownViewController.swift
//  OneApp
//
//  Created by TTB on 31/8/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import UIKit

private enum Constants {
    static let headerViewHeight: CGFloat = 56
    static let defaultTableViewHeight: CGFloat = 2000
}

public protocol DSBottomSheetDropdownDelegate: AnyObject {
    
    func bottomSheet(_ viewController: UIViewController, didSelectAt index: Int)
    func bottomSheet(_ viewController: UIViewController, didDismiss isSelected: Bool)
}

enum BottomSheetListStyle {
    case listAction(viewModel: DSBottomSheetDropdownViewModel?)
    case listAccountAction(viewModel: DSBottomSheetDropdownViewModel?)
}

/**
 Custom component ClickableIcon
 
 **Usage Example:**
 1. Declare `DSBottomSheetDropdown` and select style.
 2. Set up deletegate.
 3. Present pan modal `DSBottomSheetDropdown` that we defined.
 ```
 let style: BottomSheetStyle = .listAction(viewModel: DSBottomSheetDropDownViewModel(leftIcon: nil, rightIcon: nil, listItem: itemList))
 let vc = DSBottomSheetDropdown(style: style)
 vc.delegate = self
 navigationController?.presentPanModal(vc)
 ```
 **Current list of style:**
 - ListAction
 */
final class DSBottomSheetDropdown: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var closeButton: DSClickableIconBadge!
    
    // MARK: - Private variable
    private var tableViewHeight: CGFloat = Constants.defaultTableViewHeight
    private var style: ListActionViewStyle!
    private var viewModel: DSBottomSheetDropdownViewModel?
    private var didSelectedDropdown: Bool = false
    
    // MARK: - Public
    /// Variable for set tag ID of DSBottomSheetDropdown
    public var tagId: String = ""
    
    /// Delegate of DSBottomSheetDropdown
    public weak var delegate: DSBottomSheetDropdownDelegate?
    
    /// init DSBottomSheetDropdown by style
    init(style: BottomSheetListStyle) {
        let nibname = String(describing: DSBottomSheetDropdown.self)
        let bundle = Bundle(for: DSBottomSheetDropdown.self)
        super.init(nibName: nibname, bundle: bundle)
        
        setupStyle(style: style)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupScrollView()
        setupTableView()
    }
}

// MARK: - Action
extension DSBottomSheetDropdown {
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - PanModalPresentable
extension DSBottomSheetDropdown: PanModalPresentable {
    
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
        return .contentHeight(tableViewHeight + Constants.headerViewHeight)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(tableViewHeight + Constants.headerViewHeight)
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
extension DSBottomSheetDropdown: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch style {
        case .listActionIcons, .listAccountWithIcon:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch style {
        case .listActionIcons, .listAccountWithIcon:
            let spacingView: UIView = UIView()
            spacingView.backgroundColor = .clear
            return UIView()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch style {
        case .listActionIcons(let info):
            return info.count
        case .listAccountWithIcon(let info):
            return info.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch style {
        case .listActionIcons(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let isShowBottomList: Bool = indexPath.row != viewModels.count - 1
            let cell: DSListActionIconTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            let backgroundView = UIView()
            backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
            cell.selectedBackgroundView = backgroundView
            cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomList)
            return cell
        case .listAccountWithIcon(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let cell: DSListAccountTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        default:
            return UITableViewCell()

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
		didSelectedDropdown = true
        switch style {
        case .listActionIcons, .listAccountWithIcon:
            delegate?.bottomSheet(self, didSelectAt: indexPath.row)
            dismiss(animated: true)
        default:
            break
        }
    }
}

// MARK: - UIScrollViewDelegate
extension DSBottomSheetDropdown: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isHidden = scrollView.contentOffset.y <= 0
        headerView.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
}

// MARK: - Private
private extension DSBottomSheetDropdown {
    func setupUI() {
        headerLabel.font = DSFont.h3
        headerLabel.textColor = DSColor.componentLightDefault
        headerLabel.text = viewModel?.title
        headerLabel.numberOfLines = 0
        closeButton.setTitle("", for: .normal)
        closeButton.setup(style: .normal, image: SvgIcons.icon24Close.image)
    }
    
    func setupScrollView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func setupTableView() {
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(DSListActionIconTableViewCell.self)
        tableView.register(DSListAccountTableViewCell.self)
        tableView.register(DSMenuListMessageTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24))
        
        tableViewHeight = tableView.contentSize.height
        panModalSetNeedsLayoutUpdate()
        
    }
    
    func setupStyle(style: BottomSheetListStyle) {
        switch style {
        case .listAction(let viewModel):
            guard let viewModel = viewModel else {
                return
            }
            let dataList: [ListActionIconViewModel] = viewModel.listItem.enumerated().map { index, item in
                let isSelected = index == viewModel.selectedIndex
                let rightIcon: DSIcons? = isSelected ? .icon24OutlineCheck : nil
                return ListActionIconViewModel(text: item.title, leftIcon: viewModel.leftIcon, rightIcon: rightIcon, hideRightIcon: .onlyIcon)
            }
            self.viewModel = viewModel
            self.style = .listActionIcons(viewModels: dataList)
        case .listAccountAction(let viewModel):
            guard let item = viewModel else { return }
            self.viewModel = viewModel
            self.style = .listAccountWithIcon(viewModels: item.listItem)
        }
    }
}
