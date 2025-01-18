//
//  DSBottomSheetMenuListMessage.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/2/23.
//

import UIKit

private enum Constants {
    static let headerViewHeight: CGFloat = 56
    static let defaultTableViewHeight: CGFloat = 2000
    static let tableFooterViewHeight: CGFloat = 24
}

public protocol DSBottomSheetMenuListMessageDelegate: AnyObject {
    func bottomSheetIsDismiss(didSelected: Bool)
    func didSelectRowWithTag(index: Int, tagId: String)
}

final class DSBottomSheetMenuListMessage: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var closeButton: DSClickableIconBadge!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private var tableViewHeight: CGFloat = Constants.defaultTableViewHeight
    private var viewModel: DSBottomSheetMenuListMessageViewModel?
    private var listItem: [DSBottomSheetMenuListMessageItem] = []
    private var didSelectedItem: Bool = false
    
    // Variable for set accessibility identifier
    private var titleHeaderId: String = ""
    private var prefixMenuListMessageId: String = ""
    private var prefixLabelId: String = ""
    
    // MARK: - Public properties
    public weak var delegate: DSBottomSheetMenuListMessageDelegate?
    
    /// Variable for set tag ID of DSBottomSheetMenuListMessage
    public var tagId: String = ""
    
    /// init DSBottomSheetMenuListMessage
    init(viewModel: DSBottomSheetMenuListMessageViewModel) {
        let nibname = String(describing: DSBottomSheetMenuListMessage.self)
        let bundle = Bundle(for: DSBottomSheetMenuListMessage.self)
        super.init(nibName: nibname, bundle: bundle)
        
        self.viewModel = viewModel
        self.listItem = viewModel.listItem
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
    
    func setAccessibilityIdentifier(titleId: String,
                                    closeButtonId: String,
                                    prefixMenuListMessage: String,
                                    prefixLabel: String) {
        self.titleHeaderId = titleId
        self.closeButton.setAccessibilityIdentifier(id: closeButtonId)
        self.prefixMenuListMessageId = prefixMenuListMessage
        self.prefixLabelId = prefixLabel
    }
}

// MARK: - Action
extension DSBottomSheetMenuListMessage {
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - PanModalPresentable
extension DSBottomSheetMenuListMessage: PanModalPresentable {
    func panModalWillDismiss() {
        delegate?.bottomSheetIsDismiss(didSelected: didSelectedItem)
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

// MARK: - UITableViewDataSource
extension DSBottomSheetMenuListMessage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.listItem[indexPath.row]
        let cell: DSMenuListMessageTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(viewModel: viewModel)
        
        // Set Accessibility Identifier
        let row = String(indexPath.row)
        cell.setAccessibilityIdentifier(id: self.prefixMenuListMessageId.idConcatenation(row),
                                        titleLabelId: self.prefixLabelId.idConcatenation(row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DSHeaderMenuListMessageView()
        view.setup(title: viewModel?.title ?? "")
        
        // Set Accessibility Identifier
        view.setAccessibilityIdentifier(titleLabelId: self.titleHeaderId)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension DSBottomSheetMenuListMessage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.didSelectedItem = true
            self.delegate?.didSelectRowWithTag(
                index: indexPath.row,
                tagId: self.tagId
            )
        }
    }
}

// MARK: - UIScrollViewDelegate
extension DSBottomSheetMenuListMessage: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isHidden = scrollView.contentOffset.y <= 0
        headerView.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
}

// MARK: - Private
private extension DSBottomSheetMenuListMessage {
    func setupUI() {
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
        tableView.register(DSMenuListMessageTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: 0,
                                                         height: Constants.tableFooterViewHeight))
        
        tableViewHeight = tableView.contentSize.height
        panModalSetNeedsLayoutUpdate()
    }
}
