//
//  MenuListDescriptionActionViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 6/6/2566 BE.
//

import UIKit

private enum Constants {
    static let defaultPaddingHeader: CGFloat = 20
}

protocol MenuListDescriptionActionDelegate: AnyObject {
    func menuListDescriptionActionDidDismiss(_ viewController: UIViewController)
    func menuListDescriptionActionDidTapGhostButton(_ viewController: UIViewController)
    func menuListDescriptionAction(_ viewController: UIViewController, didSelectItemAt index: Int)
}

class MenuListDescriptionActionViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: IntrinsicTableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var clickAbleGhostButton: DSGhostButton!
    @IBOutlet weak var clickAbleCloseButton: DSClickableIconGeneralIcon!
    
    private var viewModel: DSMenuListDescriptionActionViewModel!
    private var titleLabelTopMargin = NSLayoutConstraint()
    private var titleLabelCenterYConstraint = NSLayoutConstraint()

    var selectedIndex: Int?

    weak var delegate: MenuListDescriptionActionDelegate?
    
    init(viewModel: DSMenuListDescriptionActionViewModel) {
        let nibname = String(describing: MenuListDescriptionActionViewController.self)
        super.init(nibName: nibname, bundle: .dsBundle)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        panModalSetNeedsLayoutUpdate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.menuListDescriptionActionDidDismiss(self)
    }
}

// MARK: - Action
extension MenuListDescriptionActionViewController {
    @IBAction func ghostButtonDidTapped(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.menuListDescriptionActionDidTapGhostButton(self)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension MenuListDescriptionActionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isHidden = scrollView.contentOffset.y <= 0
        headerView.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
}

// MARK: - UITableViewDelegate
extension MenuListDescriptionActionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.menuListDescriptionAction(self, didSelectItemAt: indexPath.row)
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuListDescriptionActionTableViewCell
        else { return }
        cell.setPressed()
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuListDescriptionActionTableViewCell
        else { return }
        cell.setDefault()
    }
}

// MARK: - UITableViewDataSource
extension MenuListDescriptionActionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let item = viewModel.items[index]
        
        let cell: MenuListDescriptionActionTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.setup(
            with: DropdownCardSelectionViewModel(item),
            state: selectedIndex == index ? .selected : .default
        )
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - PanModalPresentable
extension MenuListDescriptionActionViewController: PanModalPresentable {

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
        return scrollView
    }
    
    var shortFormHeight: PanModalHeight {
        switch viewModel.presentationType {
        case .dynamic:
            return .contentHeight(getContentHeight())
        case .fullPage:
            return .maxHeight
        }
    }
    
    var longFormHeight: PanModalHeight {
        switch viewModel.presentationType {
        case .dynamic:
            return .contentHeight(getContentHeight())
        case .fullPage:
            return .maxHeight
        }
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

// MARK: - Private
private extension MenuListDescriptionActionViewController {
    func setupUI() {
        headerLabel.setUp(font: DSFont.h2, textColor: DSColor.componentLightDefault)
        headerLabel.text = viewModel.title
        
        clickAbleCloseButton.setup(
            viewModel: DSClickableIconGeneralIconViewModel(
                tagId: .zero,
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
        
        clickAbleGhostButton.smallGhostNoPaddingLeftIconLeft(text: viewModel.ghostButtonText, icon: viewModel.ghostButtonIcon.image)
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.register(MenuListDescriptionActionTableViewCell.self)
    }
    
    func reloadData() {
        view.layoutIfNeeded()
        self.tableView.reloadData()
        self.panModalSetNeedsLayoutUpdate()
    }
    
    func getContentHeight() -> CGFloat {
        return headerView.frame.height + Constants.defaultPaddingHeader + scrollView.contentSize.height
    }
}

// MARK: - CardSelectionViewModel
fileprivate extension DropdownCardSelectionViewModel {
    init(_ item: DSMenuListDescriptionActionViewModel.ActionItems) {
        self.init(
            tagId: .zero,
            titleText: item.titleText,
            descriptionText: item.descriptionText ?? "",
            iconImage: item.leftIcon,
            iconSize: .medium
        )
    }
}
