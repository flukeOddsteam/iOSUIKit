//
//  DSTabBarView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/9/2565 BE.
//

import UIKit

private enum Constants {
    static let numberOfMaximumTabBar: Int = 3
}

/**
The method that an object adopt to manage data and view for `DSTabBarView`. Just conform protocol `DSTabBarViewDataSource` and provide data to data source
 
 ```
 extension ViewController: DSTabBarViewDataSource {
 
     var views: [UIView]
     var titleButtons: [String]
 
     func numberOfTabBarItems(_ tabBarView: DSTabBarView) -> Int {
         return viewBinddings.count
     }
     
     func tabBarView(_ tabBarView: DSTabBarView, contentForItemAt index: Int) -> UIView {
         let view = views[index]
         return view
     }
     
     func tabBarView(_ tabBarView: DSTabBarView, titleTabBarAt index: Int) -> String {
         let title = titleButtons[index]
         return title
     }
 }
 ```
 */

public protocol DSTabBarViewDataSource: AnyObject {
    /// Tell the data source to return number of tabbar
    func numberOfTabBarItems(_ tabBarView: DSTabBarView) -> Int
    /// Tell the data source to return content view for each  items with index
    func tabBarView(_ tabBarView: DSTabBarView, contentForItemAt index: Int) -> UIView
    /// Tell the data source to return title of tabbar for each item with index
    func tabBarView(_ tabBarView: DSTabBarView, titleTabBarAt index: Int) -> String
}

public extension DSTabBarViewDataSource {
    func tabBarView(_ tabBarView: DSTabBarView, contentForItemAt index: Int) -> UIView {
        return UIView()
    }
}

/**
    Method for managing event for `DSTabBarView`. Just conform protocol `DSTabBarViewDelegate`
 ```
 extension ViewController: DSTabBarViewDataSource {
     func tabBarView(_ tabBarView: DSTabBarView, didSelectTabBarAt index: Int) {
        // Do stuff
     }
 }
 ```
 */
public protocol DSTabBarViewDelegate: AnyObject {
    /// Tell the delegate of DSTabBarView is did select the tabbar with index item
    func tabBarView(_ tabBarView: DSTabBarView, didSelectTabBarAt index: Int)
}

/**
 Custom component DSTabBarView for Design System
 
 ![image](/DocumentationImages/ds-tabbar.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSTabBarView` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 5. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var tabbarView: DSTabBarView!
     
     override func viewDidLoad() {
        super.viewDidLoad()
        tabbarView.delegate = self
        tabbarView.dataSource = self
        // Or use the component by calling setup() method.
        tabbarView.setup(delegate: self, dataSource: self, theme: .light)
     }
     ```
 6. After binding dataSource. Just call method `tabbarView.reloadTabBar()`
 */
public final class DSTabBarView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabBarSegmentView: TabBarSegmentedView!
    @IBOutlet weak var contentStackView: UIStackView!
    
    // MARK: - Delegate & DataSource
    /// The object that acts as the data source of the DSTabBarView.
    public weak var dataSource: DSTabBarViewDataSource?
    /// The object that acts as the delegate of the DSTabBarView.
    public weak var delegate: DSTabBarViewDelegate?

    /// The configuration of tabBar.
    public var configuration: DSTabBarConfiguration = .default

    // MARK: - Private
    private var selectedIndex: Int = .zero
    /// Variable for set theme of the DSTabBarView.
    private var theme: DSTabBarTheme = .light
    
    // Variable for set accessibility identifier
    private var prefixTabBarSegmentedId: String = ""
    private var prefixTabBarSegmentedLabelId: String = ""
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupUI()
    }
    
    public func reloadTabBar() {
        relayout()
        updateSelectedTabBar()
    }
    
    /// Setup DSTabBarView
    ///
    /// Parameter for setup DSTabBarView
    /// - Parameter configuration: The configuration of DSTabBarView.
    /// - Parameter delegate: the parameter that acts as the delegate of the DSTabBarView.
    /// - Parameter dataSource: the parameter that acts as the data source of the DSTabBarView.
    /// - Parameter theme: the parameter that acts as the theme of the DSTabBarView. default is`.light`
    public func setup(
        delegate: DSTabBarViewDelegate,
        dataSource: DSTabBarViewDataSource,
        theme: DSTabBarTheme = .light,
        configuration: DSTabBarConfiguration = .default
    ) {
        self.configuration = configuration
        self.theme = theme

        self.delegate = delegate
        self.dataSource = dataSource
    }

    /// Parameter for setup seleted tabbar item
    /// - Parameter index: The index of the tabBar that will be selected. It starts at zero
    public func setSelected(with index: Int) {
        updateSelectedTabBar(
            at: index,
            isUpdateSegmentView: true
        )
    }

    /// Function for get selected index of tabBar
    public func getSelectedIndex() -> Int {
        selectedIndex
    }

    public func setAccessibilityIdentifier(prefixTabBarSegmentedId: String? = nil,
                                           prefixTabBarSegmentedLabelId: String? = nil) {
        self.prefixTabBarSegmentedId = prefixTabBarSegmentedId ?? ""
        self.prefixTabBarSegmentedLabelId = prefixTabBarSegmentedLabelId ?? ""
    }
}

// MARK: - TabbarSegmentedViewDelegate
extension DSTabBarView: TabBarSegmentedViewDelegate {
    func tabBarSegmentedView(_ view: TabBarSegmentedView, didSelectAtIndex index: Int) {
        updateSelectedTabBar(
            at: index,
            isUpdateSegmentView: false
        )
        delegate?.tabBarView(self, didSelectTabBarAt: index)
    }
}

// MARK: - Private
private extension DSTabBarView {
    
    func setupUI() {
        tabBarSegmentView.delegate = self
    }
    
    func relayout() {
        selectedIndex = .zero
        tabBarSegmentView.clearLayout()
        contentStackView.removeAllSubviews()
        
        makeTabBarSegmented()
        makeTabBarContents()
    }

    func updateSelectedTabBar(
        at index: Int,
        isUpdateSegmentView: Bool
    ) {
        selectedIndex = index
        updateSelectedTabBar()

        if isUpdateSegmentView {
            tabBarSegmentView.preSelected(at: index)
        }
    }

    func makeTabBarSegmented() {
        guard let dataSource = self.dataSource else {
            return
        }
        
        let numberOfTabBarItems = dataSource.numberOfTabBarItems(self)
        guard numberOfTabBarItems <= Constants.numberOfMaximumTabBar else {
            fatalError("Number of tabBar should less or equal than \(Constants.numberOfMaximumTabBar) items (UX Requirement)")
        }
        
        let titleList = Array(0..<numberOfTabBarItems).map {
            dataSource.tabBarView(self, titleTabBarAt: $0)
        }
        
        tabBarSegmentView.setAccessibilityIdentifier(
            prefixTabBarSegmentedId: self.prefixTabBarSegmentedId,
            prefixTabBarSegmentedLabelId: self.prefixTabBarSegmentedLabelId)
        
        tabBarSegmentView.setup(titleButtons: titleList, theme: theme)
    }
    
    func makeTabBarContents() {
        guard let dataSource = self.dataSource else {
            return
        }
        
        let numberOfTabBarItems = dataSource.numberOfTabBarItems(self)
        guard numberOfTabBarItems <= Constants.numberOfMaximumTabBar else {
            fatalError("Number of tabBar should less or equal than \(Constants.numberOfMaximumTabBar) items (UX Requirement)")
        }

        contentStackView.isHidden = !configuration.isUseContentLayout
        if configuration.isUseContentLayout {
            let views = (0..<numberOfTabBarItems).map {
                dataSource.tabBarView(
                    self,
                    contentForItemAt: $0
                )
            }
            contentStackView.addArrangedSubviews(views)
        }
    }
    
    func updateSelectedTabBar() {
        guard configuration.isUseContentLayout else {
            return
        }

        contentStackView.arrangedSubviews.enumerated().forEach { index, view in
            let isSelected = selectedIndex == index
            view.isHidden = !isSelected
        }
    }
}
