//
//  DSContentList.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import UIKit

/**
    Method for managing event for `DSContentList`. Just conform protocol `DSContentListDelegate`
 ```
 extension ViewController: DSContentListDelegate {
    func contentListView(_ view: DSContentList, didSelectAtIndex index: Int) {
        // Do stuff
    }
 }
 ```
 */

public protocol DSContentListDelegate: AnyObject {
    func contentListView(_ view: DSContentList, didSelectAtIndex index: Int)
    func contentListView(_ view: DSContentList, ghostActionDidTappedAt index: Int)
}

public extension DSContentListDelegate {
    func contentListView(_ view: DSContentList, didSelectAtIndex index: Int) { }
    func contentListView(_ view: DSContentList, ghostActionDidTappedAt index: Int) { }
}

/**
 Custom component DSContentList for Design System
 
 ![image](/DocumentationImages/ds-contentlist-vertical.png)
 ![image](/DocumentationImages/ds-contentlist-horizontal.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSContentList` Class to the UIView
 2. Binding constraint top, leading, trailing, bottom
 3. Connect UIView to `@IBOutlet` in text editor
 5. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var contentListView: DSContentList!
     
     override func viewDidLoad() {
        contentListView.setup(style: style)
        contentListView.viewModels = [ DSContentListViewModel, DSContentListViewModel, DSContentListViewModel ]
        contentListView.reloadData()
     }
     ```
 6. After binding viewModels. Just call method `contentListView.reloadData()`
 */

public final class DSContentList: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    private var accessibility: DSContentListAccessibility?
    
    // MARK: - Public properties
    /// The object that acts as the delegate of the DSContentList.
    public weak var delegate: DSContentListDelegate?
    
    /// The properties that contain style of vertical or horizontal
    public var style: DSContentListStyle = .vertical
    
    /// The array of viewModel for binding data to `DSContentList`
    public var viewModels: [DSContentListViewModel] = []
    
    /// The contentSize of collectionView
    public var contentSize: CGSize {
        return collectionView.contentSize
    }
    
    // MARK: - Private properties
    private var isIntrinsicSize: Bool = false
    
    // MARK: - Public life cycle & function
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Method for setup collectionview and style
    public func setup(style: DSContentListStyle, isIntrinsicSize: Bool = false) {
        self.style = style
        self.isIntrinsicSize = isIntrinsicSize
        setupCollectionView()
        setupActiveIntrinsicHeight()
    }
    
    /// Method for reload data binding to `DSContentList`
    public func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
            self.collectionView.collectionViewLayout.invalidateLayout()
            
            if self.isIntrinsicSize {
                self.updateHeightConstraint()
            }
        }
    }
    
    public func setScrollEnabled(isEnabled: Bool) {
        collectionView.isScrollEnabled = isEnabled
    }
    
    @available(*, deprecated, message: "Deprecated, Please use model DSContentListAccessibility instead.")
    public func setAccessibilityIdentifier(id: String? = nil,
                                           prefixContentBasicView: String? = nil,
                                           prefixLeftHeaderTitleLabelId: String? = nil,
                                           prefixRightHeaderTitleLabelId: String? = nil,
                                           prefixTitleLabelId: String? = nil,
                                           prefixStatusPillViewId: String? = nil,
                                           prefixStatusPillViewLabelId: String? = nil,
                                           prefixTagPillViewId: String? = nil,
                                           prefixDescriptionLabelId: String? = nil,
                                           prefixActionButtonId: String? = nil,
                                           prefixActionButtonLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.accessibility = DSContentListAccessibility(id: id,
                                                        prefixContentBasicViewId: prefixContentBasicView,
                                                        prefixLeftHeaderTitleLabelId: prefixLeftHeaderTitleLabelId,
                                                        prefixRightHeaderTitleLabelId: prefixRightHeaderTitleLabelId,
                                                        prefixTitleLabelId: prefixTitleLabelId,
                                                        prefixStatusPillViewId: prefixStatusPillViewId,
                                                        prefixStatusPillViewLabelId: prefixStatusPillViewLabelId,
                                                        prefixTagPillViewId: prefixTagPillViewId,
                                                        prefixDescriptionLabelId: prefixDescriptionLabelId,
                                                        prefixActionButtonId: prefixActionButtonId,
                                                        prefixActionButtonLabelId: prefixActionButtonLabelId)
    }

    func setAccessibility(accessibility: DSContentListAccessibility) {
        self.accessibilityIdentifier = accessibility.id
        self.accessibility = accessibility
    }
}

// MARK: - UICollectionViewDelegate
extension DSContentList: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.contentListView(self, didSelectAtIndex: indexPath.item)
    }
}

// MARK: - UICollectionViewDataSource
extension DSContentList: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.item]
        let row = String(indexPath.row)
        switch style {
        case .vertical:
            let cell: ContentListVerticalCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(viewModel: viewModel)
            cell.delegate = self

            if let accessibility {
                cell.setAccessibilityIdentifier(id: accessibility.prefixContentBasicViewId.idConcatenation(row),
                                                leftHeaderTitleLabelId: accessibility.prefixLeftHeaderTitleLabelId.idConcatenation(row),
                                                rightHeaderTitleLabelId: accessibility.prefixRightHeaderTitleLabelId.idConcatenation(row),
                                                titleLabelId: accessibility.prefixTitleLabelId.idConcatenation(row),
                                                statusPillViewId: accessibility.prefixStatusPillViewId.idConcatenation(row),
                                                statusPillViewLabelId: accessibility.prefixStatusPillViewLabelId.idConcatenation(row),
                                                tagPillViewId: accessibility.prefixTagPillViewId.idConcatenation(row),
                                                descriptionLabelId: accessibility.prefixDescriptionLabelId.idConcatenation(row),
                                                actionButtonId: accessibility.prefixActionButtonId.idConcatenation(row),
                                                actionButtonLabelId: accessibility.prefixActionButtonLabelId.idConcatenation(row))
            }

            return cell
        case .horizontal:
            let cell: ContentListHorizontalCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(viewModel: viewModel)
            cell.delegate = self

            if let accessibility {
                cell.setAccessibilityIdentifier(id: accessibility.prefixContentBasicViewId.idConcatenation(row),
                                                leftHeaderTitleLabelId: accessibility.prefixLeftHeaderTitleLabelId.idConcatenation(row),
                                                rightHeaderTitleLabelId: accessibility.prefixRightHeaderTitleLabelId.idConcatenation(row),
                                                titleLabelId: accessibility.prefixTitleLabelId.idConcatenation(row),
                                                statusPillViewId: accessibility.prefixStatusPillViewId.idConcatenation(row),
                                                statusPillViewLabelId: accessibility.prefixStatusPillViewLabelId.idConcatenation(row),
                                                tagPillViewId: accessibility.prefixTagPillViewId.idConcatenation(row),
                                                descriptionLabelId: accessibility.prefixDescriptionLabelId.idConcatenation(row),
                                                actionButtonId: accessibility.prefixActionButtonId.idConcatenation(row),
                                                actionButtonLabelId: accessibility.prefixActionButtonLabelId.idConcatenation(row))
            }

            return cell
        }
    }
}
// MARK: - ContentListCollectionViewDelegate
extension DSContentList: ContentListCollectionViewDelegate {
    func contentListCollectionCellGhostDidTapped(_ cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        delegate?.contentListView(self, ghostActionDidTappedAt: indexPath.item)
    }
}

// MARK: - DSContentListCollectionViewLayoutDelegate
extension DSContentList: DSGridCollectionViewLayoutDelegate {
    public func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let layout = collectionView.collectionViewLayout as? DSGridCollectionViewLayout else { return .zero }
        let basicView: ContentListBasicViewInterface = style == .vertical ? ContentListVerticalBasicView() : ContentListHorizontalBasicView()
        basicView.setup(viewModel: viewModels[indexPath.item])
        basicView.view.autosizing(forWidth: layout.columnWidth)
        return basicView.view.frame.height
    }
}

// MARK: - Private
private extension DSContentList {
    func commonInit() {
        setupXib()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ContentListHorizontalCollectionViewCell.self)
        collectionView.register(ContentListVerticalCollectionViewCell.self)
        
        let layoutProperties: DSContentListStyleLayout = style

        let layout = DSGridCollectionViewLayout()
        layout.delegate = self
        layout.verticalCellSpacing = layoutProperties.verticalCellSpacing
        layout.horizontalCellSpacing = layoutProperties.horizontalCellSpacing
        layout.numberOfColumns = layoutProperties.numberOfColumn
        layout.contentInsets = layoutProperties.contentInset
        
        collectionView.collectionViewLayout = layout
    }
    
    func setupActiveIntrinsicHeight() {
        if !isIntrinsicSize {
            collectionViewHeightConstraint.isActive = false
        } else {
            collectionViewHeightConstraint.isActive = true
        }
    }
    
    func updateHeightConstraint() {
        self.collectionViewHeightConstraint.constant = collectionView.contentSize.height
        self.layoutIfNeeded()
    }
}
