//
//  DSCarouselView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 22/11/2565 BE.
//

import UIKit

private enum Constants {
    static let minimumLineSpacing: CGFloat = 8
}

public enum DSCarouselState {
    case `default`
    case auto
}

public enum DSCarouselStyle {
    case dark
    case light
    
    var dotColor: UIColor {
        switch self {
        case .dark:
            return DSColor.componentCustomBackgroundDefault
        case .light:
            return DSColor.componentDisableOutline
        }
    }
    
    var selectedColor: UIColor {
        return DSColor.componentCustomBackgroundBackgroundInformativeSpecial
    }
}

public protocol DSCarouselViewtDelegate: AnyObject {
    func contentListView(didSelectAtIndex index: Int, tagId: Int)
    func getCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, tagId: Int) -> UICollectionViewCell
    func scrollDidEndDeceleratingCurrentPage(page: Int, tagId: Int)
    func scrollViewDidScrollCurrentPage(page: Int, tagId: Int)
}

public extension DSCarouselViewtDelegate {
    func contentListView(didSelectAtIndex index: Int, tagId: Int) {}
    func scrollDidEndDeceleratingCurrentPage(page: Int, tagId: Int) {}
    func scrollViewDidScrollCurrentPage(page: Int, tagId: Int) {}
}

/**
 Custom component DSCarouselView for Design System
 
 ![image](/DocumentationImages/ds-carousel-dark.png)
 
 ![image](/DocumentationImages/ds-carousel-light.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSCarouselView` Class to the UIView
 2. Binding constraint
 3. Connect UIView to `@IBOutlet` in text editor
 5. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     carouselView.setup(
         state: .auto(duration: 5),
         tagId: 100,
         customCell: ExampleCarouselCell(),
         cellHeight: 200,
         style: .light,
         pageCount: 1
     )
     carouselView.delegate = self
     ```
 6. `Important!!` The user need to implement DSCarouselViewtDelegate for provide collection view cell for render
     extension KcsCarouselViewController: DSCarouselViewtDelegate {
         func scrollDidEndDeceleratingCurrentPage(page: Int, tagId: Int) {
             debugPrint("DSCarousel id \(tagId) Scroll to page: \(page)")
         }
         
         func contentListView(didSelectAtIndex index: Int,  tagId: Int) {
             debugPrint("DSCarousel id \(tagId) didSelectAtIndex: \(index)")
         }
         func getCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath,  tagId: Int) -> UICollectionViewCell {
             let cell: ExampleCarouselCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
             return cell
         }
     }
 */
public final class DSCarouselView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollingPageControl: ScrollingPageControl!
    @IBOutlet weak var scrollingView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    // MARK: - Private properties
    private var style: DSCarouselStyle?
    private var cellHeight: CGFloat?
    private var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    private var pageCount: Int?
    private var tagId: Int = 0
    private var state: DSCarouselState = .default
    private var autoScrollingTimer: TimerResumeable?
    
    // MARK: - Public properties
    public weak var delegate: DSCarouselViewtDelegate?

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Parameter | Type + Information
    /// --- | ---
    /// `state` | `DSCarouselState` State of carousel such as default, auto scrolling.  (Optional)
    /// `tagId` | `Int` Tag of component. (Required)
    /// `customCell` | `UICollectionViewCell` Cell view. (Required)
    /// `cellHeight` | `CGFloat` Height of cell view.  (Required)
    /// `style` | `DSCarouselStyle`  Style of carousel such as light, dark. (Required)
    /// `pageCount` | `Int`  Count of total carousel pages. (Required)
    
    public func setup(
        state: DSCarouselState = .default,
        tagId: Int,
        customCell: UICollectionViewCell,
        bundle: Bundle = .dsBundle,
        cellHeight: CGFloat,
        style: DSCarouselStyle,
        pageCount: Int
    ) {
        // Stored properties
        self.style = style
        self.pageCount = pageCount
        self.cellHeight = cellHeight
        self.tagId = tagId
        self.state = state
        
        // Register CustomCell
        collectionView.register(
            UINib(nibName: customCell.xibName, bundle: bundle),
            forCellWithReuseIdentifier: customCell.xibName
        )
        scrollingPageControl.isHidden = pageCount <= 1
        scrollingView.isHidden = pageCount <= 1
        scrollingPageControl.pages = self.pageCount ?? 0
        scrollingPageControl.dotColor = self.style?.dotColor ?? DSColor.componentDisableOutline
        scrollingPageControl.selectedColor = self.style?.selectedColor ?? DSColor.componentCustomBackgroundBackgroundInformativeSpecial
        // Configure the required item size (REQURED)
        DispatchQueue.main.async {
            self.setupItemSize()
        }
        collectionViewHeight.constant = cellHeight
        collectionView.reloadData()
        setupState()
        
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            autoScrollingTimer?.stop()
        } else if gestureRecognizer.state == .ended {
            autoScrollingTimer?.start()
        }
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           collectionViewId: String? = nil,
                                           scrollingViewId: String? = nil,
                                           scrollingPageControlId: String? = nil) {
        self.accessibilityIdentifier = id
        self.collectionView.accessibilityIdentifier = collectionViewId
        self.scrollingView.accessibilityIdentifier = scrollingViewId
        self.scrollingPageControl.accessibilityIdentifier = scrollingPageControlId
    }
}

// MARK: - Public
public extension DSCarouselView {
   func reloadData() {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func autoScrolling() {
        let nextIndex = (scrollingPageControl.selectedPage + 1) % (pageCount ?? 0)
        scrollToPage(index: nextIndex, animated: true)
    }
    
    func scrollToPage(index: Int, animated: Bool = false) {
        // Sanity check
        guard let pageCount = pageCount,
        pageCount >= (index - 1) else {
            return
        }
        scrollingPageControl.isAnimate = animated
        centeredCollectionViewFlowLayout.scrollToPage(index: index, animated: animated)
	}
}

// MARK: - Private
private extension DSCarouselView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        setupCollectionView()
    }
    
    func setupState() {
        switch state {
        case .auto:
            autoScrollingTimer = TimerResumeable(interval: 5, isRepeats: true, completion: { [weak self] in
                self?.autoScrolling()
            })
            autoScrollingTimer?.start()
        case .default:
            break
        }
    }
    
    func setupCollectionView() {
        // Get the reference to the CenteredCollectionViewFlowLayout (REQURED)
        centeredCollectionViewFlowLayout = (
            collectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout
        )

        // Modify the collectionView's decelerationRate (REQURED)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        // Assign delegate and data source
        collectionView.delegate = self
        collectionView.dataSource = self

        // Configure the optional inter item spacing (OPTIONAL)
        centeredCollectionViewFlowLayout.minimumLineSpacing = Constants.minimumLineSpacing
    }
    
    func setupItemSize() {
        let spacing = self.pageCount ?? 0 > 1 ? 64 : 32
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: self.bounds.width - CGFloat(spacing),
            height: cellHeight ?? 0
        )
    }
}

// MARK: - UICollectionViewDelegate
extension DSCarouselView: UICollectionViewDelegate {
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.contentListView(didSelectAtIndex: indexPath.row, tagId: self.tagId)
    }
}

// MARK: - UICollectionViewDataSource
extension DSCarouselView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pageCount ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let customCell = self.delegate?.getCell(
			collectionView: collectionView,
            cellForItemAt: indexPath,
            tagId: self.tagId
		) {
            return customCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / (scrollView.frame.width - 64))
        let currentPage = page < 0 ? 0 : Int(page)
        scrollingPageControl.selectedPage = Int(page)
        self.delegate?.scrollViewDidScrollCurrentPage(
            page: currentPage,
            tagId: self.tagId
        )
    }
	
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.scrollDidEndDeceleratingCurrentPage(
            page: centeredCollectionViewFlowLayout.currentCenteredPage ?? 0,
            tagId: self.tagId
        )
        autoScrollingTimer?.reset()
    }
}
