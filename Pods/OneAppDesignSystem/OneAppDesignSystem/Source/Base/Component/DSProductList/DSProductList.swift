//
//  ProductList.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/2/2566 BE.
//

import UIKit

public protocol DSProductListDelegate: AnyObject {
    func productList(_ view: DSProductList, didSelectAtIndex index: Int)
}

/**
 Custom component ProductList for Design System
 
 ![image](/DocumentationImages/ds-product-list.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `ProductList` Class to the UIView.
 2. Binding constraint.`
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
    - Setup contentfor render to view list.
    - Setup valiable property view.
 5. Wait for event action after user taged item in list view.
     ```
        @IBOutlet weak var imagSize1x1ProductListView: DSProductList!
                  
        private var imagSize1x1DataList: [DSProductListViewModel] = []
         
        override func viewDidLoad() {
            super.viewDidLoad()
            
             // Setup contentfor render to view list
             let imagSize1x1DataList = [
                 DSProductListViewModel(image: nil,
                                        title: "Title",
                                        description: "Description message here, keep this short, 2 lines maximum. Description message here,"),
                 DSProductListViewModel(image: .image(self.image),
                                        imageRadio: .ratio1x1,
                                        title: "Title",
                                        description: "Description message here, keep this short, 2 lines maximum.")
             ]
 
                            
             // Setup valiable property view
             imagSize1x1ProductListView.delegate = self
             imagSize1x1ProductListView.viewModels = imagSize1x1DataList
             imagSize1x1ProductListView.isViewScrollEnabled = false
             imagSize1x1ProductListView.reloadData()
        }
     ```
 
    Wait for event action after user taged item in list view:
    /// Don't forget handle DSProductListDelegate for wait for event action
      ```
         func productList(_ view: DSProductList, didSelectAtIndex index: Int) {
            // Do somting after user selected cell
         }
      ```
 */

public final class DSProductList: UIView {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: IntrinsicTableView!
    
    // MARK: - Public properties
    public weak var delegate: DSProductListDelegate?
    
    /// Variable for setup enabled or disabled scoll
    public var isViewScrollEnabled: Bool = false {
        didSet {
            self.updateAppearance()
        }
    }
    
    /// Variable for setup show highlight color after user selected cell view
    public var isShowHighlightSelectionView: Bool = false {
        didSet {
            self.reloadData()
        }
    }
    
    /// Variable for setup content to render in list view
    public var viewModels: [DSProductListViewModel] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Parameters for setup funtion
    /// - Parameter viewModels: content to render in list view
    public func setup(viewModels: [DSProductListViewModel] = []) {
        self.viewModels = viewModels
    }
    
    public func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
        }
    }
    
    public func setScrollEnabled(isEnabled: Bool) {
        tableView.isScrollEnabled = isEnabled
    }
    
    public func setAccessibilityIdentifier(id: String? = nil) {
        self.accessibilityIdentifier = id
    }
}

// MARK: - UITableViewDelegate
extension DSProductList: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.productList(self, didSelectAtIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension DSProductList: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModels[indexPath.item]
        let row = indexPath.row
        let cell: ProductListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.isShowSeparatorLine = cell.style.showSeparatorLine(rowIndex: row, contents: self.viewModels.count)
        
        switch isShowHighlightSelectionView {
        case true:
            cell.selectionStyle = UITableViewCell.SelectionStyle.default
        default:
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
        }
        
        cell.setup(viewModel: viewModel, style: .imageAspectRatio(ratio: viewModel.imageRadio))
        
        return cell
    }
}

// MARK: - ContentListTableViewDelegate
extension DSProductList: DSProductListDelegate {
    public func productList(_ view: DSProductList, didSelectAtIndex index: Int) {
        self.delegate?.productList(view, didSelectAtIndex: index)
    }
}

// MARK: - Private
private extension DSProductList {
    func commonInit() {
        setupXib()
        commonUI()
    }
    
    func commonUI() {
        setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.isScrollEnabled = self.isViewScrollEnabled
        self.tableView.register(ProductListTableViewCell.self)
    }
    
    func updateAppearance() {
        self.tableView.isScrollEnabled = self.isViewScrollEnabled
        self.layoutIfNeeded()
    }
}
