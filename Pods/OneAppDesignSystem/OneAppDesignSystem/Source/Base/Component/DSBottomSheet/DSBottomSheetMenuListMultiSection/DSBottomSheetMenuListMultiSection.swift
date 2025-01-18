//
//  DSBottomSheetMenuListMultiSection.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/10/24.
//
import UIKit

private enum Constants {
    static let headerViewHeight: CGFloat = 56
    static let defaultTableViewHeight: CGFloat = 2000
    static let cellSpacingHeight: CGFloat = 16
}

public struct DSBottomSheetMultiSectionSelectedItem {
    public let section: Int
    public let row: Int
}

public protocol DSBottomSheetMenuListMultiSectionDelegate: AnyObject {
    func bottomSheetMultiSection(
        tagId: Int,
        didSelectAt item: DSBottomSheetMultiSectionSelectedItem
    )
}

/**
 
 Custom component DSBottomSheetMenuListMultiSection for Design System
 
 ![image](/DocumentationImages/ds-bottom-sheet-menu-list-multi-section.png)
 ![image](/DocumentationImages/ds-bottom-sheet-menu-list-multi-section-over-scroll.png)
 
**Usage Example:**
 1. Create UIView on .xib file and assign `DSBottomSheetMenuListMultiSection` Class to the UIView.
 2. Binding constraint.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
 
 ```
    @IBOutlet weak var ghostButton: DSGhostButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    func setupUI() {
        ghostButton.smallGhostText(text: "Show Icon 24 Full - Page")
    }
        
    @IBAction func didTapGhostButton(_ sender: Any) {
        let viewModels = [
            DSBottomSheetMenuListMultiSectionViewModel(
                header: "Header, Section 1 Keep it short",
                listItem: [
                    .init(
                        image: DSIcons.icon24OutlinePlaceholder,
                        title: "Label",
                        description: "Lorem ipsum dolor sit amet"
                    ),
                    .init(
                        image: DSIcons.icon24OutlineBillStatement,
                        title: "Lorem ipsum dolor sit amet consectetur.",
                        description: "Lorem ipsum dolor sit amet consectetur. Aliquam tellus quis amet  lacinia cursus ut."
                    )
                ]
            ),
            DSBottomSheetMenuListMultiSectionViewModel(
                header: "Header, Section 2 Keep it short",
                listItem: [
                    .init(
                        image: DSIcons.icon24OutlineCamera,
                        title: "ถ่ายรูป"
                    ),
                    .init(
                        image: DSIcons.icon24OutlinePhoto,
                        title: "",
                        description: "This case for test only. Not use as an example."
                    )
                ]
            )
        ]
                
        DSBottomSheetWrapper.presentBottomSheetMenuListMultiSection(
            viewController: self,
            viewModel: viewModels
        )
    }
 */

final class DSBottomSheetMenuListMultiSection: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var closeButton: DSClickableIconGeneralIcon!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private var tableViewHeight: CGFloat = Constants.defaultTableViewHeight
    private var viewModel: [DSBottomSheetMenuListMultiSectionViewModel] = []
    
    // Variable for set accessibility identifier
    private var titleHeaderId: String = ""
    private var prefixMenuListMultiSectionId: String = ""
    private var prefixLabelId: String = ""
    private var prefixDescriptionId: String = ""
    private var tagId: Int = .zero
    
    // MARK: - Public properties
    public weak var delegate: DSBottomSheetMenuListMultiSectionDelegate?
    
    /// init DSBottomSheetMenuListMultiSection
    init(tagId: Int, viewModel: [DSBottomSheetMenuListMultiSectionViewModel]) {
        let nibname = String(describing: DSBottomSheetMenuListMultiSection.self)
        let bundle = Bundle(for: DSBottomSheetMenuListMultiSection.self)
        super.init(nibName: nibname, bundle: bundle)
        
        self.tagId = tagId
        self.viewModel = viewModel.filter { $0.listItem.isNotEmpty }
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
    
    /// Setup accessibility identifier DSBottomSheetMenuListMultiSection
    ///
    /// Parameter for setup accessibility identifier for DSBottomSheetMenuListMultiSection
    /// - Parameter accessibility: the object that contain attribute identifier of each element.
    func setAccessibilityIdentifier(
        titleId: String,
        prefixMenuListMultiSectionId: String,
        prefixLabel: String,
        closeButtonId: String
    ) {
        self.titleHeaderId = titleId
        self.prefixMenuListMultiSectionId = prefixMenuListMultiSectionId
        self.prefixLabelId = prefixLabel
        self.closeButton.setAccessibilityIdentifier(id: closeButtonId)
    }
}

// MARK: - PanModalPresentable
extension DSBottomSheetMenuListMultiSection: PanModalPresentable {
    func panModalWillDismiss() {
        self.dismiss(animated: true, completion: nil)
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
extension DSBottomSheetMenuListMultiSection: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel[section].listItem.count * 2 - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == .zero {
            let listItem = self.viewModel[indexPath.section].listItem
            
            let cell: DSMenuListMultiSectionTableViewCell = tableView.dequeueReusableCell(
                forIndexPath: indexPath
            )
            
            let indexPathRow = indexPath.row.isZero ? .zero : indexPath.row / 2
            cell.configure(viewModel: listItem[indexPathRow])
            
            // Set Accessibility Identifier
            let row = String(indexPathRow)
            
            cell.setAccessibilityIdentifier(
                id: self.prefixMenuListMultiSectionId.idConcatenation(row),
                titleLabelId: self.prefixLabelId.idConcatenation(row),
                descriptionLabelId: self.prefixDescriptionId.idConcatenation(row)
            )
            return cell
        } else {
            // Spacer cell
            let cell: DSSpacingCell = tableView.dequeueReusableCell(
                forIndexPath: indexPath
            )
            cell.backgroundColor = .clear
            cell.setupSpacing(height: Constants.cellSpacingHeight)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DSHeaderMenuListMultiSectionView()
        view.setup(title: viewModel[section].header)
        
        // Set Accessibility Identifier
        view.setAccessibilityIdentifier(titleLabelId: self.titleHeaderId)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension DSBottomSheetMenuListMultiSection: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.delegate?.bottomSheetMultiSection(
                tagId: self.tagId,
                didSelectAt: DSBottomSheetMultiSectionSelectedItem(
                    section: indexPath.section,
                    row: indexPath.row.isZero ? .zero : indexPath.row / 2
                )
            )
        }
    }
}

// MARK: - UIScrollViewDelegate
extension DSBottomSheetMenuListMultiSection: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isHidden = scrollView.contentOffset.y <= .zero
        headerView.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
}

// MARK: - Private
private extension DSBottomSheetMenuListMultiSection {
    func setupUI() {
        closeButton.setup(
            viewModel: DSClickableIconGeneralIconViewModel(
                tagId: .zero,
                state: .active,
                theme: .light,
                size: .medium,
                imageType: .image(DSIcons.icon24Close.image),
                isBadged: false
            ),
            action: { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true, completion: nil)
            }
        )
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
        tableView.register(DSMenuListMultiSectionTableViewCell.self)
        tableView.register(DSSpacingCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.layoutIfNeeded()
        
        tableViewHeight = tableView.contentSize.height
        panModalSetNeedsLayoutUpdate()
    }
}
