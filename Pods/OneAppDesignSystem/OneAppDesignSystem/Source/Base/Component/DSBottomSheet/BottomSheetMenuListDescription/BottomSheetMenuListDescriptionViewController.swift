//
//  BottomSheetMenuListDescriptionViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/3/2566 BE.
//

import UIKit

private enum Constants {
    static let defaultSpacingHeader: CGFloat = 8
    static let defaultHeaderSection: CGFloat = 64
    static let defaultFooterHeight: CGFloat = 24
    static let defaultBottomSheetTopPadding: CGFloat = 16
}

public protocol DSBottomSheetMenuListDescriptionDelegate: AnyObject {
    func bottomSheetMenuListDescriptionDidSelectAtIndex(_ index: Int, withTagId tag: Int)
}

final class BottomSheetMenuListDescriptionViewController: UIViewController {
    
    @IBOutlet weak var closeButton: DSClickableIconBadge!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: IntrinsicTableView!
    
    private var tagId: Int = .zero
    private var imageRatio: DSRatio = .ratio1x1
    private var headerTitle: String = ""
    private var viewModels: [DSBottomSheetMenuListDescriptionViewModel] = []
    
    weak var delegate: DSBottomSheetMenuListDescriptionDelegate?
    
    init(tagId: Int, headerTitle: String, imageRatio: DSRatio, viewModels: [DSBottomSheetMenuListDescriptionViewModel]) {
        let nibName = String(describing: BottomSheetMenuListDescriptionViewController.self)
        super.init(nibName: nibName, bundle: .dsBundle)
        
        self.tagId = tagId
        self.headerTitle = headerTitle
        self.imageRatio = imageRatio
        self.viewModels = viewModels
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not allowed implement by storyboard or nib")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadData()
    }
}

// MARK: - Action
extension BottomSheetMenuListDescriptionViewController {
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension BottomSheetMenuListDescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isHidden = scrollView.contentOffset.y <= 0
        headerView.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
}

// MARK: - UITableViewDelegate
extension BottomSheetMenuListDescriptionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.delegate?.bottomSheetMenuListDescriptionDidSelectAtIndex(indexPath.row, withTagId: self.tagId)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BottomSheetMenuListDescriptionCell
        else { return }
        cell.highlight()
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BottomSheetMenuListDescriptionCell
        else { return }
        cell.unhighlight()
    }
}

// MARK: - UITableViewDataSource
extension BottomSheetMenuListDescriptionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BottomSheetMenuListDescriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(viewModel: viewModels[indexPath.row], imageRatio: imageRatio)
        return cell
    }
}

// MARK: - PanModalPresentable
extension BottomSheetMenuListDescriptionViewController: PanModalPresentable {
    
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
        scrollView
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(getContentHeight())
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(getContentHeight())
    }
    
    var anchorModalToLongForm: Bool {
        return true
    }
    
    var panModalBackgroundColor: UIColor {
        return DSColor.otherBackgroundOverlayScreen
    }
    
    var topOffset: CGFloat {
        return UIApplication.getStatusBarFrame().height + Constants.defaultBottomSheetTopPadding
    }
}

// MARK: - Private
private extension BottomSheetMenuListDescriptionViewController {
    func setupUI() {
        view.backgroundColor = DSColor.componentLightBackground
        
        closeButton.setup(style: .normal, image: DSIcons.icon24Close.image)
        titleLabel.font = DSFont.h2
        titleLabel.textColor = DSColor.componentLightDefault
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isScrollEnabled = false
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.showsVerticalScrollIndicator = false
        let footerView = UIView(frame: CGRect(x: .zero, y: .zero, width: .zero, height: Constants.defaultFooterHeight))
        footerView.backgroundColor = .clear
        tableView.tableFooterView = footerView

        tableView.register(BottomSheetMenuListDescriptionCell.self)
    }
    
    func getContentHeight() -> CGFloat {
        scrollView.contentSize.height + Constants.defaultHeaderSection + Constants.defaultFooterHeight
    }
    
    func reloadData() {
        view.layoutIfNeeded()
        self.tableView.reloadData()
        self.panModalSetNeedsLayoutUpdate()
    }
}
