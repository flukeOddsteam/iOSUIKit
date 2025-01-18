//
//  DSFilterPill.swift
//  OneAppDesignSystem
//
//  Created by TTB on 19/4/2566 BE.
//

import UIKit

/**
    Method for managing event for `DSFilterPill`.
 ```
extension ViewController: DSFilterPillDelegate {
    func filterPill(_ view: DSFilterPill, pillDidRemoveAtIndex index: Int) {

    }
 ```
 */
public protocol DSFilterPillDelegate: AnyObject {
    func filterPill(_ view: DSFilterPill, pillDidTapAtIndex index: Int)
    func filterPill(_ view: DSFilterPill, pillDidTapRemoveAtIndex index: Int)
}

/**
 Custom component DSFilterPill
 
 ![image](/DocumentationImages/ds-filter-pill.png)

 **Usage Example:**
 1. Import oneappdesignsystem
 2. Create UIView on .xib file and assign `DSFilterPill` Class to the UIView
 3. Binding constraint and don't set height, set intrinsic size to placeholder
 4. Connect UIView to `@IBOutlet` in text editor
 5. Call `func setup()` in `viewDidLoad()`
  ```
 @IBOutlet weak var filterPill: DSFilterPill!

  override func viewDidLoad() {
    super.viewDidLoad()
    let viewModels = [
        DSFilterPillViewModel(title: "Text Label", state: .active, isDisplayRemoveIcon: true),
        DSFilterPillViewModel(title: "Text Label", state: .active, isDisplayRemoveIcon: false),
        DSFilterPillViewModel(title: "Text Label", state: .default, isDisplayRemoveIcon: false),
        DSFilterPillViewModel(title: "Text Label", state: .disable, isDisplayRemoveIcon: false),
    ]
 
    filterPill.setup(viewModels: viewModels)
  }
  ```
 */

public final class DSFilterPill: UIView {

    @IBOutlet weak var collectionView: IntrinsicCollectionView!
    
    /// The array of viewModel for binding data to `DSFilterPill`
    public var viewModels: [DSFilterPillViewModel] = [] {
        didSet {
            reloadData()
        }
    }
    /// The object that acts as the delegate of the DSFilterPill.
    public weak var delegate: DSFilterPillDelegate?
    
    // MARK: - Private variable
    private var prefixTitleId: String = ""
    private var prefixIconButtonId: String = ""
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSFilterPill
    ///
    /// Parameter for setup DSFilterPill
    /// - Parameter viewModels: The array of viewModel for binding data.
    public func setup(viewModels: [DSFilterPillViewModel]) {
        self.viewModels = viewModels
    }
    
    /// Setup accessibilityIdentifier
    ///
    /// Parameter for setup accessibilityIdentifier
    /// - Parameter id: the identifier of containerView.
    /// - Parameter collectionViewId: the identifier of collectionView.
    /// - Parameter prefixTitleId: the prefix  title label identifier of each item.
    /// - Parameter prefixIconButtonId: the prefix icon button identifier of each item.
    public func setAccessibilityIdentifier(id: String? = nil,
                                           collectionViewId: String? = nil,
                                           prefixTitleId: String? = nil,
                                           prefixIconButtonId: String? = nil) {
        self.accessibilityIdentifier = id
        self.collectionView.accessibilityIdentifier = collectionViewId
        self.prefixTitleId = prefixTitleId ?? ""
        self.prefixIconButtonId = prefixIconButtonId ?? ""
    }
}

extension DSFilterPill: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.item]
        let item = String(indexPath.item)
        
        let cell: FilterPillCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(indexItem: indexPath.item, viewModel: viewModel)
        cell.setAccessibilityIdentifier(titleId: prefixTitleId.idConcatenation(item),
                                        iconButtonId: prefixIconButtonId.idConcatenation(item))
        cell.delegate = self
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterPill(self, pillDidTapAtIndex: indexPath.item)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DSFilterPill: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let view = FilterPillView(frame: .zero)
        view.setup(viewModel: viewModels[indexPath.item])
        view.sizeToFit(forWidth: collectionView.frame.width)
        return view.frame.size
    }
}

extension DSFilterPill: FilterPillCollectionViewCellDelegate {
    func filterPillCell(_ cell: FilterPillCollectionViewCell, didTapIconAtIndexOfItem index: Int) {
        delegate?.filterPill(self, pillDidTapRemoveAtIndex: index)
    }
}

// MARK: - Private
private extension DSFilterPill {
    func commonInit() {
        setupXib()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.register(FilterPillCollectionViewCell.self, bundle: .dsBundle)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let leftAlignedFlowLayout = LeftAlignedFlowLayout()
        leftAlignedFlowLayout.minimumInteritemSpacing = 8
        collectionView.collectionViewLayout = leftAlignedFlowLayout
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.layoutIfNeeded()
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}
