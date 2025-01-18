//
//  DSTabPill.swift
//  OneAppDesignSystem
//
//  Created by TTB on 12/10/2565 BE.
//

import UIKit

private enum Constants {
    static let menuViewContentInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
    static let menuViewReuseIdentifier: String = "MenuCell"
    static let totallyHorizontalPadding: CGFloat = 32
    static let menuViewCellSpacing: CGFloat = 4
}

/**
The method that an object adopt to manage data and view for `DSTabPill`. Just conform protocol `DSTabPillDataSource` and provide data to data source
 
 ```swift
 extension ViewController: DSTabPillDataSource {
 
     var viewControllers: [UIViewController] = []
     var titles: [String] = []

     func numberOfTabPillItems() -> Int {
         viewControllers.count
     }
     
     func tabPillView(_ tabPillView: DSTabPill, controllerForItemAt index: Int) -> UIViewController {
         viewControllers[index]
     }
     
     func tabPillView(_ tabPillView: DSTabPill, titleTabPillAt index: Int) -> String {
         titles[index]
     }
 }
 ```
 */

public protocol DSTabPillDataSource: AnyObject {
    /// Tell the data source to return number of tab pill
    func numberOfTabPillItems() -> Int
    /// Tell the data source to return view controller for each  page with index
    func tabPillView(_ tabPillView: DSTabPill, controllerForItemAt index: Int) -> UIViewController
    /// Tell the data source to return title of tab pill for each item with index
    func tabPillView(_ tabPillView: DSTabPill, titleTabPillAt index: Int) -> String
}

/**
    Method for managing event for `DSTabPill`. Just conform protocol `DSTabPillDelegate`
 ```swift
 extension ViewController: DSTabPillDelegate {
     func tabPillView(_ tabPillView: DSTabPill, didSelectMenuItemsAt index: Int) {
        // Do stuff
     }
 
     func tabPillView(_ tabPillView: DSTabPill, didManualScrollAt index: Int) {
        // Do stuff
     }
 }
 ```
 */

public protocol DSTabPillDelegate: AnyObject {
    /// Tell the delegate of DSTabPill is did select the tab pill menu with index item
    func tabPillView(_ tabPillView: DSTabPill, didSelectMenuItemsAt index: Int)
    /// Tell the delegate of DSTabPill is did scroll the content page to index
    func tabPillView(_ tabPillView: DSTabPill, didManualScrollAt index: Int)
}

/**
 Custom component DSTabPill for Design System
 
 ![image](/DocumentationImages/ds-tab-pill-light.png)
 ![image](/DocumentationImages/ds-tab-pill-dark.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSTabPill` Class to the UIView
 2. Binding constraint
 3. Connect UIView to `@IBOutlet` in text editor
 5. Set value to properties in `viewDidLoad()` or where ever you want.
     ```swift
     @IBOutlet weak var tabPillView: DSTabPill!

     override func viewDidLoad() {
        super.viewDidLoad()
        tabPillView.delegate = self
        tabPillView.dataSource = self
        tabPillView.setup(style: style)
     }
     ```
 */
public final class DSTabPill: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var heightMenuContainerViewConstraint: NSLayoutConstraint!
    
    // MARK: - Public
    public weak var dataSource: DSTabPillDataSource?
    public weak var delegate: DSTabPillDelegate?
    
    // MARK: - Private
    private var style: DSTabPillStyle = .light
    
    private var menuViewController: PagingMenuViewController!
    private var contentViewController: PagingContentViewController!
    
    private var viewControllers: [UIViewController] = []
    private var titleList: [String] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
    }
    
    public func setup(style: DSTabPillStyle) {
        self.style = style
        setupPropertiesIfNeeded()
        setupPagingKit()
        menuViewController.reloadData()
        contentViewController.reloadData()
        updateMaskMenu()
    }
    
    public func reloadTabPill() {
        relayout()
        setupPropertiesIfNeeded()
        setupPagingKit()
        menuViewController.reloadData()
        contentViewController.reloadData()
        updateMaskMenu()
    }
}

// MARK: - PagingMenuViewControllerDelegate
extension DSTabPill: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
        delegate?.tabPillView(self, didSelectMenuItemsAt: page)
    }
    
    func menuViewController(viewController: PagingMenuViewController, willAnimateFocusViewTo index: Int, with coordinator: PagingMenuFocusViewAnimationCoordinator) {
        
        updateMaskMenu()
        coordinator.animateFocusView(alongside: { _ in
            self.updateMaskMenu()
        }, completion: nil)
    }
    
    func menuViewController(viewController: PagingMenuViewController, willDisplay cell: PagingMenuViewCell, forItemAt index: Int) {
        guard let cell = cell as? TabPillOverlayView else {
            return
        }
        
        cell.updateMask()
    }
}

// MARK: - PagingMenuViewControllerDataSource
extension DSTabPill: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        viewControllers.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        guard let cell = viewController.dequeueReusableCell(withReuseIdentifier: Constants.menuViewReuseIdentifier, for: index) as? TabPillOverlayView else {
            fatalError("TabPillOverlayView is undefined")
        }
        
        cell.configure(title: titleList[index])
        cell.referencedMenuView = viewController.menuView
        cell.referencedFocusView = viewController.focusView
        cell.normalTextColor = getStyleColor(light: DSColor.componentLightDefault, dark: DSColor.pageDarkComponentGhostDefault)
        cell.hightlightTextColor = getStyleColor(light: DSColor.componentCustomBackgroundDefault, dark: DSColor.componentLightDefault)
        cell.updateMask()
        return cell
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {

        // swiftlint:disable force_unwrapping
        let stringWidth = String.getWidth(string: titleList[index],
                                          withConstraintedHeight: heightMenuContainerViewConstraint.constant,
                                          font: DSFont.h3!)
        // swiftlint:enable force_unwrapping
        
        return stringWidth + Constants.totallyHorizontalPadding
    }
}

// MARK: - PagingContentViewControllerDataSource
extension DSTabPill: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        viewControllers.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return viewControllers[index]
    }
}

extension DSTabPill: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
        updateMaskMenu()
    }
    
    func contentViewController(viewController: PagingContentViewController, didEndManualScrollOn index: Int) {
        delegate?.tabPillView(self, didManualScrollAt: index)
    }
}

// MARK: - Private
private extension DSTabPill {
    
    func setupPagingKit() {
        menuViewController = PagingMenuViewController()
        menuViewController.delegate = self
        menuViewController.dataSource = self
        
        let focusView = TabPillFocusView()
        focusView.contentBackgroundColor = getStyleColor(light: DSColor.componentCustomBackgroundBackgroundInformativeSpecial, dark: DSColor.componentLightBackground)
        menuViewController.cellSpacing = Constants.menuViewCellSpacing
        menuViewController.contentInset = Constants.menuViewContentInset
        menuViewController.register(type: TabPillOverlayView.self, forCellWithReuseIdentifier: Constants.menuViewReuseIdentifier)
        menuViewController.registerFocusView(view: focusView, isBehindCell: true)
        
        contentViewController = PagingContentViewController()
        contentViewController.delegate = self
        contentViewController.dataSource = self
        
        let menuView = menuViewController.view ?? UIView()
        let contentView = contentViewController.view ?? UIView()
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        menuContainerView.addSubview(menuView)
        contentContainerView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: menuContainerView.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: menuContainerView.bottomAnchor),
            menuView.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor)
        ])
    }
    
    func setupPropertiesIfNeeded() {
        guard let dataSource = dataSource else {
            return
        }
        
        let numberOfItems = dataSource.numberOfTabPillItems()
        
        viewControllers = Array(Int.zero..<numberOfItems).map {
            dataSource.tabPillView(self, controllerForItemAt: $0)
        }
        
        titleList = Array(Int.zero..<numberOfItems).map {
            dataSource.tabPillView(self, titleTabPillAt: $0)
        }
    }
    
    func relayout() {
        viewControllers.removeAll()
        titleList.removeAll()
        
        menuViewController.view.removeFromSuperview()
        contentViewController.view.removeFromSuperview()
        
        menuContainerView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        contentContainerView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func updateMaskMenu() {
        menuViewController.visibleCells.forEach { view in
            guard let overlayView = view as? TabPillOverlayView else {
                return
            }
            
            overlayView.updateMask()
        }
    }
    
    func getStyleColor(light: UIColor, dark: UIColor) -> UIColor {
        switch style {
        case .light:
            return light
        case .dark:
            return dark
        }
    }
}
